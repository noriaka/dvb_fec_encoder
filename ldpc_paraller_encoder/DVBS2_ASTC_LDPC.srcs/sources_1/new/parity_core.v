module parity_core #(
    parameter ADDR_WIDTH = 7,
    parameter MATRIX_DATA_WIDTH = 96,
    parameter DATA_WIDTH = 360,
    parameter DEPTH = 72,         // input_ram 的深度
    parameter SM_DEPTH = 108,     // sm_ram 的深度
    parameter NUM_READ_PORTS = 2, // 同时读取两个地址
    parameter NUM_WRITE_PORTS = 2
)(
    input                                       clk,
    input                                       rst_n,
    input                                       en,
    input [NUM_READ_PORTS*DATA_WIDTH-1:0]       input_ram_rd_data,
    output [NUM_READ_PORTS-1:0]                 input_ram_re,
    output [NUM_READ_PORTS*ADDR_WIDTH-1:0]      input_ram_rd_addr,
    output [NUM_WRITE_PORTS-1:0]                pm_ram_we,
    output [NUM_READ_PORTS*ADDR_WIDTH-1:0]      pm_ram_wr_addr,
    output [NUM_READ_PORTS*DATA_WIDTH-1:0]      pm_ram_wr_data,
    output                                      pm_calc_end
);

    // ROM 读取端口
    reg [NUM_READ_PORTS-1:0]                        matrix_rom_re;
    wire [NUM_READ_PORTS*ADDR_WIDTH-1:0]            matrix_rd_addr;
    wire [NUM_READ_PORTS*MATRIX_DATA_WIDTH-1:0]     matrix_rd_data;
    reg [ADDR_WIDTH-1:0]                            matrix_rd_addr_mem [0:NUM_READ_PORTS-1];
    reg [0:MATRIX_DATA_WIDTH-1]                     matrix_rd_data_mem [0:NUM_READ_PORTS-1];
    assign matrix_rd_addr = {matrix_rd_addr_mem[1], matrix_rd_addr_mem[0]};

    // input_ram 端口
    reg [NUM_READ_PORTS-1:0]                input_ram_re;
    reg [NUM_READ_PORTS*ADDR_WIDTH-1:0]     input_ram_rd_addr;
    wire [NUM_READ_PORTS*DATA_WIDTH-1:0]    input_ram_rd_data;
    reg [DATA_WIDTH-1:0]                    shifted_data_mem [0:NUM_READ_PORTS-1];

    // sm_ram wt端口
    reg [NUM_WRITE_PORTS-1:0]               sm_ram_we;      // 写使能信号
    wire [NUM_READ_PORTS*ADDR_WIDTH-1:0]    sm_ram_wr_addr;
    wire [NUM_READ_PORTS*DATA_WIDTH-1:0]    sm_ram_wr_data;
    reg [DATA_WIDTH-1:0]                    sm_wr_data_men [0:NUM_WRITE_PORTS-1];
    assign sm_ram_wr_addr = matrix_rd_addr;
    assign sm_ram_wr_data = {sm_wr_data_men[1], sm_wr_data_men[0]};
    // sm_ram rd端口
    reg [NUM_READ_PORTS-1:0]                sm_ram_re;
    wire [NUM_READ_PORTS*ADDR_WIDTH-1:0]    sm_ram_rd_addr;
    wire [NUM_READ_PORTS*DATA_WIDTH-1:0]    sm_ram_rd_data;
    reg [ADDR_WIDTH-1:0]                    sm_rd_addr_mem [0:NUM_READ_PORTS-1];
    assign sm_ram_rd_addr = {sm_rd_addr_mem[1], sm_rd_addr_mem[0]};
    
    mutiport_rom_atsc_6_15 #(
        .ADDR_WIDTH         (ADDR_WIDTH),
        .DATA_WIDTH         (MATRIX_DATA_WIDTH),
        .DEPTH              (SM_DEPTH),
        .NUM_READ_PORTS     (NUM_READ_PORTS)
    ) matrix_rom_atsc_6_15_inst (
        .clk                (clk),
        .rst_n              (rst_n),
        .re                 (matrix_rom_re),
        .rd_addr            (matrix_rd_addr),
        .rd_data            (matrix_rd_data)
    );

    // multiport_ram #(
    //     .ADDR_WIDTH         (ADDR_WIDTH),
    //     .DATA_WIDTH         (DATA_WIDTH),
    //     .DEPTH              (DEPTH),
    //     .NUM_READ_PORTS     (NUM_READ_PORTS),
    //     .NUM_WRITE_PORTS    (1)
    // ) input_ram_inst (
    //     .clk                (clk),
    //     .rst_n              (rst_n),
    //     .re                 (input_ram_re),
    //     .rd_addr            (input_ram_rd_addr),
    //     .rd_data            (input_ram_rd_data)
    // );

    multiport_ram #(
        .ADDR_WIDTH         (ADDR_WIDTH),
        .DATA_WIDTH         (DATA_WIDTH),
        .DEPTH              (SM_DEPTH),  // 设置 sm_ram 的深度
        .NUM_READ_PORTS     (NUM_READ_PORTS),
        .NUM_WRITE_PORTS    (NUM_WRITE_PORTS)
    ) sm_ram_inst (
        .clk                (clk),
        .rst_n              (rst_n),
        .re                 (sm_ram_re),
        .rd_addr            (sm_ram_rd_addr),
        .rd_data            (sm_ram_rd_data),
        .we                 (sm_ram_we),  // 写使能信号
        .wr_addr            (sm_ram_wr_addr),
        .wr_data            (sm_ram_wr_data)
    );


    reg [3:0]                   state;
    localparam IDLE             = 4'd0;
    localparam READ_ROM         = 4'd1;
    localparam PARSE_DATA       = 4'd2;
    localparam READ_INPUT_RAM   = 4'd3;
    localparam SHIFT_CALC       = 4'd4;
    localparam XOR_CALC         = 4'd5;
    localparam WRITE_RAM        = 4'd6;
    localparam NEXT_ADDR        = 4'd7;
    localparam SC_CALC          = 4'd8;
    localparam PM_INIT          = 4'd9;
    localparam PM_CALC          = 4'd10;
    localparam PM_END           = 4'd11;

    integer i;
    reg [6:0]                   m_mem_1 [0:5];
    reg [8:0]                   alpha_mem_1 [0:5];
    reg [6:0]                   m_mem_2 [0:5];
    reg [8:0]                   alpha_mem_2 [0:5];

    reg [3:0]               calc_idx;
    reg                     sm_matrix_calc_end;
    reg                     wait_flag;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            matrix_rom_re <= 2'b00;
            matrix_rd_addr_mem[0] <= 7'd0;
            matrix_rd_addr_mem[1] <= 7'd0;
            input_ram_re <= 2'b00;
            input_ram_rd_addr <= 0;
            shifted_data_mem[0] <= 0;
            shifted_data_mem[1] <= 0;
            sm_ram_we <= 2'b00;
            sm_wr_data_men[0] <= 0;
            sm_wr_data_men[1] <= 0;
            for (i = 0; i < 6; i = i + 1) begin
                m_mem_1[i] <= 0;
                alpha_mem_1[i] <= 0;
                m_mem_2[i] <= 0;
                alpha_mem_2[i] <= 0;
            end
            calc_idx <= 0;
            sm_matrix_calc_end <= 0;
            wait_flag <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (en == 1 && sm_matrix_calc_end != 1) begin
                        if (wait_flag < 1) begin
                            matrix_rom_re <= 2'b11;
                            input_ram_re <= 2'b11;
                            matrix_rd_addr_mem[0] <= 7'd0;
                            matrix_rd_addr_mem[1] <= 7'd1;
                            wait_flag <= wait_flag + 1;
                        end else begin
                            state <= READ_ROM;
                            wait_flag <= 0;
                        end
                    end
                end
                READ_ROM: begin
                    for (i = 0; i < NUM_READ_PORTS; i = i + 1) begin
                        matrix_rd_data_mem[i] <= matrix_rd_data[MATRIX_DATA_WIDTH*(i+1)-1 -: MATRIX_DATA_WIDTH];
                    end
                    state <= PARSE_DATA;
                end
                PARSE_DATA: begin
                    for (i = 0; i < 6; i = i + 1) begin
                        m_mem_1[i]     <= matrix_rd_data_mem[0][i*16 +: 7];
                        alpha_mem_1[i] <= matrix_rd_data_mem[0][i*16 + 7 +: 9]; 
                        m_mem_2[i]     <= matrix_rd_data_mem[1][i*16 +: 7];
                        alpha_mem_2[i] <= matrix_rd_data_mem[1][i*16 + 7 +: 9]; 
                    end
                    calc_idx  <= 0;
                    state <= READ_INPUT_RAM;
                end
                READ_INPUT_RAM: begin
                    if (calc_idx == 6) begin
                        state <= WRITE_RAM;
                    end else begin
                        input_ram_rd_addr <= {m_mem_2[calc_idx], m_mem_1[calc_idx]};
                        state <= SHIFT_CALC;
                    end
                end
                SHIFT_CALC: begin
                    shifted_data_mem[0] <= input_ram_rd_data[DATA_WIDTH-1:0] << alpha_mem_1[calc_idx] |
                                            input_ram_rd_data[DATA_WIDTH-1:0] >> (DATA_WIDTH - alpha_mem_1[calc_idx]);
                    shifted_data_mem[1] <= input_ram_rd_data[2*DATA_WIDTH-1:DATA_WIDTH] << alpha_mem_2[calc_idx] |
                                            input_ram_rd_data[2*DATA_WIDTH-1:DATA_WIDTH] >> (DATA_WIDTH - alpha_mem_2[calc_idx]);
                    state <= XOR_CALC;
                end
                XOR_CALC: begin
                    if (calc_idx == 6) begin
                        state <= WRITE_RAM;
                    end else begin
                        if (m_mem_1[calc_idx] != 0 && alpha_mem_1[calc_idx] != 0) begin
                            sm_wr_data_men[0] <= sm_wr_data_men[0] ^ shifted_data_mem[0];
                        end
                        if (m_mem_2[calc_idx] != 0 && alpha_mem_2[calc_idx] != 0) begin
                            sm_wr_data_men[1] <= sm_wr_data_men[1] ^ shifted_data_mem[1];
                        end
                        calc_idx <= calc_idx + 1;
                        state <= READ_INPUT_RAM;
                    end
                end
                WRITE_RAM: begin
                    sm_ram_we <= 2'b11;
                    state <= NEXT_ADDR;
                end
                NEXT_ADDR: begin
                    if (wait_flag < 1) begin
                        if (matrix_rd_addr_mem[1] < 107) begin
                            matrix_rd_addr_mem[0] <= matrix_rd_addr_mem[0] + 2;
                            matrix_rd_addr_mem[1] <= matrix_rd_addr_mem[1] + 2;
                            sm_wr_data_men[0] <= 0;
                            sm_wr_data_men[1] <= 0;
                            sm_ram_we <= 2'b00;
                            wait_flag <= wait_flag + 1;
                        end else begin
                            sm_matrix_calc_end <= 1;
                            sm_ram_we <= 2'b00;
                            state <= SC_CALC;
                            wait_flag <= 0;
                        end
                    end else begin
                        state <= READ_ROM;
                        wait_flag <= 0;
                    end
                end
            endcase
        end
    end

    // calc sc vector
    reg [DATA_WIDTH-1:0]    sc_vector;
    reg [DATA_WIDTH-1:0]    shifted_sc_vector;      // 可以n个 TODO
    reg [8:0]               shift_cnt;
    reg                     sc_calc_end;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sc_vector <= 0;
            shifted_sc_vector <= 0;
            shift_cnt <= 0;
            sc_calc_end <= 0;
        end else begin
            case(state)
                WRITE_RAM: begin
                    sc_vector <= sc_vector ^ sm_wr_data_men[0] ^ sm_wr_data_men[1];
                end
                NEXT_ADDR: begin
                    if (matrix_rd_addr_mem[1] >= 107) begin
                        shifted_sc_vector <= sc_vector >> 1;
                    end
                end
                SC_CALC: begin
                    sc_vector <= sc_vector ^ shifted_sc_vector;
                    if (shift_cnt < 360 - 2) begin
                        shifted_sc_vector <= shifted_sc_vector >> 1;
                        shift_cnt <= shift_cnt + 1;
                    end else begin
                        sc_calc_end <= 1;
                        state <= PM_INIT;
                    end
                end
            endcase
        end
    end

    // calc pm
    reg [DATA_WIDTH-1:0]            pm_men1;
    reg [DATA_WIDTH-1:0]            pm_men2;
    wire [NUM_READ_PORTS*ADDR_WIDTH-1:0]    pm_ram_wr_addr;
    wire [NUM_READ_PORTS*DATA_WIDTH-1:0]    pm_ram_wr_data;
    reg [NUM_WRITE_PORTS-1:0]               pm_ram_we;
    assign pm_ram_wr_addr = {sm_rd_addr_mem[1], sm_rd_addr_mem[0]};
    assign pm_ram_wr_data = {pm_men2, pm_men1};
    reg                             sm_rd_flag;
    reg                             pm_calc_end;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pm_men1 <= 0;
            pm_men2 <= 0;
            pm_ram_we <= 0;
            sm_rd_addr_mem[0] <= 0;
            sm_rd_addr_mem[1] <= 0;
            sm_ram_re <= 0;
            sm_rd_flag <= 0;
            pm_calc_end <= 0;
        end else begin
            case (state)
                PM_INIT: begin
                    if (sm_rd_flag < 1) begin
                        if (sc_calc_end == 1 && sm_matrix_calc_end == 1) begin
                            pm_men2 <= sc_vector;
                            sm_ram_re <= 2'b11;
                            sm_rd_addr_mem[0] <= 0;
                            sm_rd_addr_mem[1] <= 1;
                            sm_rd_flag <= sm_rd_flag + 1;
                        end
                    end else begin
                        state <= PM_CALC;
                        pm_ram_we <= 2'b11;            
                        sm_rd_flag <= 0;
                    end
                end
                PM_CALC: begin
                    if (sm_rd_addr_mem[1] < 107) begin
                        pm_men1 <= pm_men2 ^ sm_ram_rd_data[DATA_WIDTH-1:0];
                        pm_men2 <= pm_men2 ^ sm_ram_rd_data[2*DATA_WIDTH-1:DATA_WIDTH] ^
                                    sm_ram_rd_data[DATA_WIDTH-1:0];
                        sm_rd_addr_mem[0] <= sm_rd_addr_mem[0] + 2;
                        sm_rd_addr_mem[1] <= sm_rd_addr_mem[1] + 2;
                    end else begin
                        state <= PM_END;
                        pm_ram_we <= 0;
                        pm_calc_end <= 1;
                    end
                end
                // TODO Parity少最后一组
            endcase
        end
    end
endmodule
