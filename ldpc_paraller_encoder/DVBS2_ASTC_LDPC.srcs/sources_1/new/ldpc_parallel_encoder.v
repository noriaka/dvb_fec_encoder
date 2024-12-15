`timescale 1ns / 1ps

module ldpc_parallel_encoder(
    input               clk,
    input               rst_n,
    input               clk_enable,
    input               bit_in,

    output              valid_out,
    output [18:0]       data_out
);

parameter ADDR_WIDTH = 7;
parameter MATRIX_DATA_WIDTH = 96;
parameter DATA_WIDTH = 360;
parameter DEPTH = 72;         // input_ram 的深度
parameter SM_DEPTH = 108;     // sm_ram 的深度
parameter PM_DEPTH = 108;
parameter NUM_READ_PORTS = 2; // 同时读取两个地址
parameter NUM_WRITE_PORTS = 2;

wire [NUM_READ_PORTS-1:0]               input_ram_re;
wire [NUM_READ_PORTS*ADDR_WIDTH-1:0]    input_ram_rd_addr;
wire [NUM_READ_PORTS*DATA_WIDTH-1:0]    input_ram_rd_data;
reg                                     input_ram_we;
reg [ADDR_WIDTH-1:0]                    input_ram_wr_addr;
reg [DATA_WIDTH-1:0]                    input_ram_wr_data;

multiport_ram #(
    .ADDR_WIDTH         (ADDR_WIDTH),
    .DATA_WIDTH         (DATA_WIDTH),
    .DEPTH              (DEPTH),
    .NUM_READ_PORTS     (NUM_READ_PORTS),
    .NUM_WRITE_PORTS    (1)
) input_ram_inst (
    .clk                (clk),
    .rst_n              (rst_n),
    .re                 (input_ram_re),
    .rd_addr            (input_ram_rd_addr),
    .rd_data            (input_ram_rd_data),
    .we                 (input_ram_we),
    .wr_addr            (input_ram_wr_addr),
    .wr_data            (input_ram_wr_data)
);

reg                     en;
reg [8:0]               idx;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        input_ram_we <= 0;
        input_ram_wr_addr <= 7'd0;
        input_ram_wr_data <= 360'd0;

        en <= 0;
        idx <= 9'd0;
    end else begin
        if (clk_enable == 1) begin
            if (input_ram_wr_addr == 72) begin
                input_ram_we <= 0;
                idx <= 9'd0;
                en <= 1;
            end else begin
                if (idx < DATA_WIDTH-1) begin
                    input_ram_we <= 0;
                    input_ram_wr_data[idx] <= bit_in;
                    idx <= idx + 1;
                end else begin
                    input_ram_wr_data[idx] <= bit_in;
                    idx <= 0;
                    input_ram_we <= 1;
                end
                if (input_ram_we == 1) begin
                    input_ram_wr_addr <= input_ram_wr_addr + 1;
                end
            end
        end
    end
end

// pm_ram wt端口
wire [NUM_WRITE_PORTS-1:0]              pm_ram_we;      // 写使能信号
wire [NUM_READ_PORTS*ADDR_WIDTH-1:0]    pm_ram_wr_addr;
wire [NUM_READ_PORTS*DATA_WIDTH-1:0]    pm_ram_wr_data;

wire                                    pm_calc_end;

parity_core #(
    .ADDR_WIDTH                  (ADDR_WIDTH),
    .MATRIX_DATA_WIDTH           (MATRIX_DATA_WIDTH),
    .DATA_WIDTH                  (DATA_WIDTH),
    .DEPTH                       (DEPTH),
    .SM_DEPTH                    (SM_DEPTH),
    .NUM_READ_PORTS              (NUM_READ_PORTS),
    .NUM_WRITE_PORTS             (NUM_WRITE_PORTS)
) parity_core_inst (
    .clk                            (clk),
    .rst_n                          (rst_n),
    .en                             (en),
    .input_ram_rd_data              (input_ram_rd_data),
    .input_ram_re                   (input_ram_re),
    .input_ram_rd_addr              (input_ram_rd_addr),
    .pm_ram_we                      (pm_ram_we),
    .pm_ram_wr_addr                 (pm_ram_wr_addr),
    .pm_ram_wr_data                 (pm_ram_wr_data),
    .pm_calc_end                    (pm_calc_end)
);

// pm_ram_rd端口
reg                                     pm_ram_re;
reg [ADDR_WIDTH-1:0]                    pm_ram_rd_addr;
wire [DATA_WIDTH-1:0]                   pm_ram_rd_data;
multiport_ram #(
    .ADDR_WIDTH         (ADDR_WIDTH),
    .DATA_WIDTH         (DATA_WIDTH),
    .DEPTH              (PM_DEPTH),
    .NUM_READ_PORTS     (1),
    .NUM_WRITE_PORTS    (NUM_WRITE_PORTS)
) pm_ram_inst (
    .clk                (clk),
    .rst_n              (rst_n),
    .re                 (pm_ram_re),
    .rd_addr            (pm_ram_rd_addr),
    .rd_data            (pm_ram_rd_data),
    .we                 (pm_ram_we),
    .wr_addr            (pm_ram_wr_addr),
    .wr_data            (pm_ram_wr_data)
);

reg [2:0]                   state;
localparam IDLE             = 4'd0;
localparam INFO_OUT         = 4'd1;
localparam PARITY_OUT       = 4'd2;
localparam LDPC_END         = 4'd3;
reg                         valid_out;
reg [18:0]                  data_out;
reg [6:0]                   info_group_cnt;
reg [6:0]                   parity_group_cnt;

reg                         input_ram_re_copy;
reg [ADDR_WIDTH-1:0]        input_ram_rd_addr_copy;
wire [DATA_WIDTH-1:0]       input_ram_rd_data_copy;
multiport_ram #(
    .ADDR_WIDTH         (ADDR_WIDTH),
    .DATA_WIDTH         (DATA_WIDTH),
    .DEPTH              (DEPTH),
    .NUM_READ_PORTS     (1),
    .NUM_WRITE_PORTS    (1)
) input_ram_inst_copy (
    .clk                (clk),
    .rst_n              (rst_n),
    .re                 (input_ram_re_copy),
    .rd_addr            (input_ram_rd_addr_copy),
    .rd_data            (input_ram_rd_data_copy),
    .we                 (input_ram_we),
    .wr_addr            (input_ram_wr_addr),
    .wr_data            (input_ram_wr_data)
);

reg [4:0]               bit_idx;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
        valid_out <= 0;
        data_out <= 0;
        info_group_cnt <= 0;
        parity_group_cnt <= 0;

        input_ram_re_copy <= 0;
        input_ram_rd_addr_copy <= 0;
        bit_idx <= 0;

        pm_ram_re <= 0;
        pm_ram_rd_addr <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (pm_calc_end == 1) begin
                    input_ram_re_copy <= 1;
                    state <= INFO_OUT;
                end else begin
                    state <= IDLE;
                end
            end
            INFO_OUT: begin
                valid_out <= 1;
                if (info_group_cnt < 72) begin
                    if (bit_idx < 20-1) begin
                        data_out <= input_ram_rd_data_copy[bit_idx*18 +: 18];
                        bit_idx <= bit_idx + 1;
                    end else begin
                        data_out <= input_ram_rd_data_copy[bit_idx*18 +: 18];
                        bit_idx <= 0;
                        input_ram_rd_addr_copy <= input_ram_rd_addr_copy + 1;
                        info_group_cnt <= info_group_cnt + 1;
                    end
                end else begin
                    bit_idx <= 0;
                    input_ram_re_copy <= 0;
                    input_ram_rd_addr_copy <= 0;
                    info_group_cnt <= 0;
                    // valid_out <= 0;
                    pm_ram_re <= 1;
                    state <= PARITY_OUT;
                end
            end
            PARITY_OUT: begin
                valid_out <= 1;
                if (parity_group_cnt < 108) begin
                    if (bit_idx < 20-1) begin
                        data_out <= pm_ram_rd_data[bit_idx*18 +: 18];
                        bit_idx <= bit_idx + 1;
                    end else begin
                        data_out <= pm_ram_rd_data[bit_idx*18 +: 18];
                        bit_idx <= 0;
                        pm_ram_rd_addr <= pm_ram_rd_addr + 1;
                        parity_group_cnt <= parity_group_cnt + 1;
                    end
                end else begin
                    pm_ram_re <= 0;
                    pm_ram_rd_addr <= 0;
                    parity_group_cnt <= 0;
                    bit_idx <= 0;
                    state <= LDPC_END;
                end
            end
            LDPC_END: begin
                valid_out <= 0;
                data_out <= 0;
            end
        endcase
    end
end

endmodule
