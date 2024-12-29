`timescale 1ns / 1ps

module test_ldpc_parallel_encoder (
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
parameter INPUT_DEPTH = 72;             // input_ram 的深度
parameter SM_PM_DEPTH = 108;            // sm_pm_ram 的深度
parameter SM_PM_HALF_DEPTH = 54;
parameter NUM_READ_PORTS = 2;
parameter NUM_WRITE_PORTS = 2;

// 计算Sm矩阵所需的input_ram ports
wire                                    input_ram_re0, input_ram_re1;
wire [ADDR_WIDTH-1:0]                   input_ram_rd_addr0, input_ram_rd_addr1;
wire [DATA_WIDTH-1:0]                   input_ram_rd_data0, input_ram_rd_data1;
reg                                     input_ram_we;
reg [ADDR_WIDTH-1:0]                    input_ram_wr_addr;
reg [DATA_WIDTH-1:0]                    input_ram_wr_data;

// 输出信息位所需的input_ram_ports
reg                                     input_ram_re2, input_ram_re3;
reg [ADDR_WIDTH-1:0]                    input_ram_rd_addr2, input_ram_rd_addr3;
wire [DATA_WIDTH-1:0]                   input_ram_rd_data2, input_ram_rd_data3;


ram_4r1w #(
    .ADDR_WIDTH         (ADDR_WIDTH),
    .DATA_WIDTH         (DATA_WIDTH),
    .DEPTH              (INPUT_DEPTH)
) input_ram_inst (
    .clk                (clk),
    .re0                (input_ram_re0),
    .rd_addr0           (input_ram_rd_addr0),
    .rd_data0           (input_ram_rd_data0),
    .re1                (input_ram_re1),
    .rd_addr1           (input_ram_rd_addr1),
    .rd_data1           (input_ram_rd_data1),
    .re2                (input_ram_re2),
    .rd_addr2           (input_ram_rd_addr2),
    .rd_data2           (input_ram_rd_data2),
    .re3                (input_ram_re3),
    .rd_addr3           (input_ram_rd_addr3),
    .rd_data3           (input_ram_rd_data3),
    .we                 (input_ram_we),
    .wr_addr            (input_ram_wr_addr),
    .wr_data            (input_ram_wr_data)
);

// 将输入比特写入input_ram
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
wire                                    pm_ram_we0, pm_ram_we1;
wire [ADDR_WIDTH-1:0]                   pm_ram_wr_addr;
wire [DATA_WIDTH-1:0]                   pm_ram_wr_data0, pm_ram_wr_data1;
wire                                    pm_calc_end;

parity_core #(
    .ADDR_WIDTH                  (ADDR_WIDTH),
    .MATRIX_DATA_WIDTH           (MATRIX_DATA_WIDTH),
    .DATA_WIDTH                  (DATA_WIDTH),
    .INPUT_DEPTH                 (INPUT_DEPTH),
    .SM_PM_DEPTH                 (SM_PM_DEPTH),
    .SM_PM_HALF_DEPTH            (SM_PM_HALF_DEPTH),
    .NUM_READ_PORTS              (NUM_READ_PORTS)
) parity_core_inst (
    .clk                         (clk),
    .rst_n                       (rst_n),
    .en                          (en),
    .input_ram_rd_data0          (input_ram_rd_data0),
    .input_ram_rd_data1          (input_ram_rd_data1),
    .input_ram_re0               (input_ram_re0),
    .input_ram_re1               (input_ram_re1),
    .input_ram_rd_addr0          (input_ram_rd_addr0),
    .input_ram_rd_addr1          (input_ram_rd_addr1),
    .pm_ram_we0                  (pm_ram_we0),
    .pm_ram_we1                  (pm_ram_we1),
    .pm_ram_wr_addr              (pm_ram_wr_addr),
    .pm_ram_wr_data0             (pm_ram_wr_data0),
    .pm_ram_wr_data1             (pm_ram_wr_data1),
    .pm_calc_end                 (pm_calc_end)
);

reg [2:0]                        state;
localparam WRITE_PM              = 3'd0,
           WAIT_READ             = 3'd1,
           INFO_OUT              = 3'd2,
           PARITY_OUT            = 3'd3,
           LDPC_END              = 3'd4;

// pm mem
reg [DATA_WIDTH-1:0]            pm_mem1 [0:SM_PM_HALF_DEPTH-1];
reg [DATA_WIDTH-1:0]            pm_mem2 [0:SM_PM_HALF_DEPTH-1];

reg [8:0]                       col_cnt;  // 列数(0~359)
reg [0:SM_PM_DEPTH-1]           pm_buffer;
integer i;
always @* begin
    pm_buffer = 108'd0;
    // row=0..53, ram1 -> bit[2*row], ram2 -> bit[2*row+1]
    for (i = 0; i < SM_PM_HALF_DEPTH; i = i + 1) begin
        pm_buffer[2*i]   = pm_mem1[i][DATA_WIDTH-1-col_cnt];
        pm_buffer[2*i+1] = pm_mem2[i][DATA_WIDTH-1-col_cnt];
    end
end

reg                             valid_out;
reg [18:0]                      data_out;
reg [6:0]                       info_group_cnt;
reg [8:0]                       parity_group_cnt;
reg [5:0]                       bit_idx;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= WRITE_PM;
        input_ram_re2 <= 0;
        input_ram_rd_addr2 <= 0;
        col_cnt <= 0;
        valid_out <= 0;
        data_out <= 0;
        info_group_cnt <= 0;
        parity_group_cnt <= 0;
        bit_idx <= 0;
    end else begin
        case (state)
            WRITE_PM: begin
                if (pm_ram_we0 == 1) begin
                    pm_mem1[pm_ram_wr_addr] <= pm_ram_wr_data0;
                end
                if (pm_ram_we1 == 1) begin
                    pm_mem2[pm_ram_wr_addr] <= pm_ram_wr_data1;
                end
                if (pm_calc_end == 1) begin
                    input_ram_re2 <= 1;
                    state <= WAIT_READ;
                end else begin
                    state <= WRITE_PM;
                end
            end
            WAIT_READ: begin
                // 等一拍读
                state <= INFO_OUT;
            end
            INFO_OUT: begin
                valid_out <= 1;
                if (info_group_cnt < INPUT_DEPTH - 1) begin
                    if (bit_idx < 20-1) begin
                        data_out <= input_ram_rd_data2[bit_idx*18 +: 18];
                        bit_idx <= bit_idx + 1;
                    end else begin
                        data_out <= input_ram_rd_data2[bit_idx*18 +: 18];
                        bit_idx <= 0;
                        input_ram_rd_addr2 <= input_ram_rd_addr2 + 1;
                        info_group_cnt <= info_group_cnt + 1;
                    end
                end else if (info_group_cnt == INPUT_DEPTH - 1) begin
                    if (bit_idx < 20-1) begin
                        data_out <= input_ram_rd_data2[bit_idx*18 +: 18];
                        bit_idx <= bit_idx + 1;
                    end else begin
                        data_out <= input_ram_rd_data2[bit_idx*18 +: 18];
                        bit_idx <= 0;
                        input_ram_re2 <= 0;
                        input_ram_rd_addr2 <= 0;
                        info_group_cnt <= 0;
                        state <= PARITY_OUT;
                    end
                end
            end
            PARITY_OUT: begin
                valid_out <= 1;
                if (parity_group_cnt < DATA_WIDTH - 1) begin
                    if (bit_idx < 6-1) begin
                        data_out <= pm_buffer[bit_idx*18 +: 18];
                        bit_idx <= bit_idx + 1;
                    end else begin
                        data_out <= pm_buffer[bit_idx*18 +: 18];
                        bit_idx <= 0;
                        col_cnt <= col_cnt + 1;
                        parity_group_cnt <= parity_group_cnt + 1;
                    end
                end else if (parity_group_cnt == DATA_WIDTH - 1) begin
                    if (bit_idx < 6-1) begin
                        data_out <= pm_buffer[bit_idx*18 +: 18];
                        bit_idx <= bit_idx + 1;
                    end else begin
                        data_out <= pm_buffer[bit_idx*18 +: 18];
                        parity_group_cnt <= 0;
                        bit_idx <= 0;
                        col_cnt <= 0;
                        state <= LDPC_END;
                    end
                end
            end
            LDPC_END: begin
                // valid_out <= 0;
                data_out <= 0;
            end
        endcase
    end
end

// // pm_ram rd端口
// reg                                     pm_ram_re0, pm_ram_re1;
// reg [ADDR_WIDTH-1:0]                    pm_ram_rd_addr;
// wire [DATA_WIDTH-1:0]                   pm_ram_rd_data0, pm_ram_rd_data1;

// ram_1r1w #(
//     .ADDR_WIDTH         (ADDR_WIDTH),
//     .DATA_WIDTH         (DATA_WIDTH),
//     .DEPTH              (PM_DEPTH),
//     .NUM_READ_PORTS     (NUM_READ_PORTS)
// ) pm_ram0_inst (
//     .clk                (clk),
//     .re0                (pm_ram_re0),
//     .rd_addr0           (pm_ram_rd_addr),
//     .rd_data0           (pm_ram_rd_data0),
//     .we                 (pm_ram_we0),
//     .wr_addr            (pm_ram_wr_addr),
//     .wr_data            (pm_ram_wr_data0)
// );

// ram_1r1w #(
//     .ADDR_WIDTH         (ADDR_WIDTH),
//     .DATA_WIDTH         (DATA_WIDTH),
//     .DEPTH              (PM_DEPTH),
//     .NUM_READ_PORTS     (NUM_READ_PORTS)
// ) pm_ram1_inst (
//     .clk                (clk),
//     .re0                (pm_ram_re1),
//     .rd_addr0           (pm_ram_rd_addr),
//     .rd_data0           (pm_ram_rd_data1),
//     .we                 (pm_ram_we1),
//     .wr_addr            (pm_ram_wr_addr),
//     .wr_data            (pm_ram_wr_data1)
// );

// reg [2:0]                   state;
// localparam IDLE             = 4'd0;
// localparam INFO_OUT         = 4'd1;
// localparam PARITY_OUT       = 4'd2;
// localparam LDPC_END         = 4'd3;
// reg                         valid_out;
// reg [18:0]                  data_out;
// reg [6:0]                   info_group_cnt;
// reg [6:0]                   parity_group_cnt;
// reg [5:0]                   bit_idx;
// wire [NUM_READ_PORTS*DATA_WIDTH-1:0]    pm_ram_rd_data;
// assign pm_ram_rd_data = {pm_ram_rd_data1, pm_ram_rd_data0};
// always @(posedge clk or negedge rst_n) begin
//     if (!rst_n) begin
//         state <= IDLE;
//         valid_out <= 0;
//         data_out <= 0;
//         info_group_cnt <= 0;
//         parity_group_cnt <= 0;
//         input_ram_re2 <= 0;
//         // input_ram_re3 <= 0;
//         input_ram_rd_addr2 <= 0;
//         // input_ram_rd_addr3 <= 0;
//         bit_idx <= 0;
//         pm_ram_re0 <= 0;
//         pm_ram_re1 <= 0;
//         pm_ram_rd_addr <= 0;
//     end else begin
//         case (state)
//             IDLE: begin
//                 if (pm_calc_end == 1) begin
//                     input_ram_re2 <= 1;
//                     state <= INFO_OUT;
//                 end else begin
//                     state <= IDLE;
//                 end
//             end
//             INFO_OUT: begin
//                 valid_out <= 1;
//                 if (info_group_cnt < 72) begin
//                     if (bit_idx < 20-1) begin
//                         data_out <= input_ram_rd_data2[bit_idx*18 +: 18];
//                         bit_idx <= bit_idx + 1;
//                     end else begin
//                         data_out <= input_ram_rd_data2[bit_idx*18 +: 18];
//                         bit_idx <= 0;
//                         input_ram_rd_addr2 <= input_ram_rd_addr2 + 1;
//                         info_group_cnt <= info_group_cnt + 1;
//                     end
//                 end else begin
//                     bit_idx <= 0;
//                     input_ram_re2 <= 0;
//                     input_ram_rd_addr2 <= 0;
//                     info_group_cnt <= 0;
//                     // valid_out <= 0;
//                     pm_ram_re0 <= 1;
//                     pm_ram_re1 <= 1;
//                     state <= PARITY_OUT;
//                 end
//             end
//             PARITY_OUT: begin
//                 valid_out <= 1;
//                 if (parity_group_cnt < 54) begin
//                     if (bit_idx < 40-1) begin
//                         data_out <= pm_ram_rd_data[bit_idx*18 +: 18];
//                         bit_idx <= bit_idx + 1;
//                     end else begin
//                         data_out <= pm_ram_rd_data[bit_idx*18 +: 18];
//                         bit_idx <= 0;
//                         pm_ram_rd_addr <= pm_ram_rd_addr + 1;
//                         parity_group_cnt <= parity_group_cnt + 1;
//                     end
//                 end else begin
//                     pm_ram_re0 <= 0;
//                     pm_ram_re1 <= 0;
//                     pm_ram_rd_addr <= 0;
//                     parity_group_cnt <= 0;
//                     bit_idx <= 0;
//                     state <= LDPC_END;
//                 end
//             end
//             LDPC_END: begin
//                 valid_out <= 0;
//                 data_out <= 0;
//             end
//         endcase
//     end
// end

endmodule
