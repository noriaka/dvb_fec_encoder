module parity_core #(
    parameter ADDR_WIDTH = 7,
    parameter MATRIX_DATA_WIDTH = 96,
    parameter DATA_WIDTH = 360,
    parameter INPUT_DEPTH = 72,         // input_ram 的深度
    parameter SM_PM_DEPTH = 108,        // sm_pm_ram 的深度
    parameter SM_PM_HALF_DEPTH = 54,    // sm_pm_ram 深度一半
    parameter NUM_READ_PORTS = 2        // 同时读取两个地址
)(
    input                                       clk,
    input                                       rst_n,
    input                                       en,
    input [DATA_WIDTH-1:0]                      input_ram_rd_data0,
    input [DATA_WIDTH-1:0]                      input_ram_rd_data1,
    output                                      input_ram_re0,
    output                                      input_ram_re1,
    output [ADDR_WIDTH-1:0]                     input_ram_rd_addr0,
    output [ADDR_WIDTH-1:0]                     input_ram_rd_addr1,
    output                                      pm_ram_we0,
    output                                      pm_ram_we1,
    output [ADDR_WIDTH-1:0]                     pm_ram_wr_addr,
    output [DATA_WIDTH-1:0]                     pm_ram_wr_data0,
    output [DATA_WIDTH-1:0]                     pm_ram_wr_data1,
    output                                      pm_calc_end
);

// 校验矩阵rom 端口
reg [NUM_READ_PORTS-1:0]                        matrix_rom_re;
wire [NUM_READ_PORTS*ADDR_WIDTH-1:0]            matrix_rd_addr;
wire [NUM_READ_PORTS*MATRIX_DATA_WIDTH-1:0]     matrix_rd_data;
reg [ADDR_WIDTH-1:0]                            matrix_rd_addr_mem [0:NUM_READ_PORTS-1];
reg [0:MATRIX_DATA_WIDTH-1]                     matrix_rd_data_mem [0:NUM_READ_PORTS-1];
assign matrix_rd_addr = {matrix_rd_addr_mem[1], matrix_rd_addr_mem[0]};

// input_ram 端口
reg                                             input_ram_re0, input_ram_re1;
reg [ADDR_WIDTH-1:0]                            input_ram_rd_addr0, input_ram_rd_addr1;
wire [DATA_WIDTH-1:0]                           input_ram_rd_data0, input_ram_rd_data1;
reg [DATA_WIDTH-1:0]                            shifted_data_mem [0:NUM_READ_PORTS-1];

// sm_ram wt端口
reg                                             sm_ram_we0, sm_ram_we1;
wire [ADDR_WIDTH-1:0]                           sm_ram_wr_addr;             // 分为两个ram地址相同
reg [DATA_WIDTH-1:0]                            sm_ram_wr_data0, sm_ram_wr_data1;
assign sm_ram_wr_addr = matrix_rd_addr_mem[0] >> 1;
// sm_ram rd端口
reg                                             sm_ram_re0, sm_ram_re1;
reg [ADDR_WIDTH-1:0]                            sm_ram_rd_addr;             // 读也是依次读因此地址也相同
wire [DATA_WIDTH-1:0]                           sm_ram_rd_data0, sm_ram_rd_data1;

mutiport_rom_atsc_6_15 #(
    .ADDR_WIDTH         (ADDR_WIDTH),
    .DATA_WIDTH         (MATRIX_DATA_WIDTH),
    .DEPTH              (SM_PM_DEPTH),
    .NUM_READ_PORTS     (NUM_READ_PORTS)
) matrix_rom_atsc_6_15_inst (
    .clk                (clk),
    .rst_n              (rst_n),
    .re                 (matrix_rom_re),
    .rd_addr            (matrix_rd_addr),
    .rd_data            (matrix_rd_data)
);

ram_1r1w #(
    .ADDR_WIDTH         (ADDR_WIDTH),
    .DATA_WIDTH         (DATA_WIDTH),
    .DEPTH              (SM_PM_HALF_DEPTH),
    .NUM_READ_PORTS     (NUM_READ_PORTS)
) sm_ram0_inst (
    .clk                (clk),
    .re0                (sm_ram_re0),
    .rd_addr0           (sm_ram_rd_addr),
    .rd_data0           (sm_ram_rd_data0),
    .we                 (sm_ram_we0),
    .wr_addr            (sm_ram_wr_addr),
    .wr_data            (sm_ram_wr_data0)
);

ram_1r1w #(
    .ADDR_WIDTH         (ADDR_WIDTH),
    .DATA_WIDTH         (DATA_WIDTH),
    .DEPTH              (SM_PM_HALF_DEPTH),
    .NUM_READ_PORTS     (NUM_READ_PORTS)
) sm_ram1_inst (
    .clk                (clk),
    .re0                (sm_ram_re1),
    .rd_addr0           (sm_ram_rd_addr),
    .rd_data0           (sm_ram_rd_data1),
    .we                 (sm_ram_we1),
    .wr_addr            (sm_ram_wr_addr),
    .wr_data            (sm_ram_wr_data1)
);


reg [3:0]                       state;
localparam  IDLE                = 4'd0,
            READ_ROM            = 4'd1,
            PARSE_DATA          = 4'd2,
            READ_INPUT_RAM      = 4'd3,
            SHIFT_CALC          = 4'd4,
            XOR_CALC            = 4'd5,
            WRITE_RAM           = 4'd6,
            NEXT_ADDR           = 4'd7,
            SC_CALC             = 4'd8,
            PM_INIT             = 4'd9,
            PM_CALC             = 4'd10,
            PM_WAIT_WRITE       = 4'd11,
            PM_END              = 4'd12;

integer i;
reg [6:0]                       m_mem_0 [0:5];
reg [8:0]                       alpha_mem_0 [0:5];
reg [6:0]                       m_mem_1 [0:5];
reg [8:0]                       alpha_mem_1 [0:5];
reg [3:0]                       calc_idx;
reg                             sm_matrix_calc_end;
reg                             wait_flag;

// sc vector 端口
reg [DATA_WIDTH-1:0]            sc_vector;
reg [DATA_WIDTH-1:0]            shifted_sc_vector;      // 可以n个 TODO
reg [8:0]                       shift_cnt;
reg                             sc_calc_end;

// pm ram 端口
reg                             pm_ram_we0, pm_ram_we1;
reg [ADDR_WIDTH-1:0]            pm_ram_wr_addr;
reg [DATA_WIDTH-1:0]            pm_ram_wr_data0;
reg [DATA_WIDTH-1:0]            pm_ram_wr_data1;

reg                             sm_rd_flag;
reg                             pm_wait_flag; 
reg                             pm_calc_end;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;

        // 校验矩阵
        matrix_rom_re <= 2'b00;
        matrix_rd_addr_mem[0] <= 7'd0;
        matrix_rd_addr_mem[1] <= 7'd0;

        // input_ram
        input_ram_re0 <= 0;
        input_ram_re1 <= 0;
        input_ram_rd_addr0 <= 0;
        input_ram_rd_addr1 <= 0;
        shifted_data_mem[0] <= 0;
        shifted_data_mem[1] <= 0;

        // sm_ram
        sm_ram_we0 <= 0;
        sm_ram_we1 <= 0;
        sm_ram_wr_data0 <= 0;
        sm_ram_wr_data1 <= 0;
        for (i = 0; i < 6; i = i + 1) begin
            m_mem_0[i] <= 0;
            alpha_mem_0[i] <= 0;
            m_mem_1[i] <= 0;
            alpha_mem_1[i] <= 0;
        end
        calc_idx <= 0;
        sm_matrix_calc_end <= 0;
        wait_flag <= 0;

        // sc vector
        sc_vector <= 0;
        shifted_sc_vector <= 0;
        shift_cnt <= 0;
        sc_calc_end <= 0;

        // pm ram
        pm_ram_we0 <= 0;
        pm_ram_we1 <= 0;
        pm_ram_wr_addr <= 0;
        pm_ram_wr_data0 <= 0;
        pm_ram_wr_data1 <= 0;
        sm_ram_re0 <= 0;
        sm_ram_re1 <= 0;
        sm_ram_rd_addr <= 0;
        sm_rd_flag <= 0;
        pm_wait_flag <= 0;
        pm_calc_end <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (en == 1 && sm_matrix_calc_end != 1) begin
                    if (wait_flag < 1) begin
                        // 提前一拍打开re
                        matrix_rom_re <= 2'b11;
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
                    m_mem_0[i]     <= matrix_rd_data_mem[0][i*16 +: 7];
                    alpha_mem_0[i] <= matrix_rd_data_mem[0][i*16 + 7 +: 9]; 
                    m_mem_1[i]     <= matrix_rd_data_mem[1][i*16 +: 7];
                    alpha_mem_1[i] <= matrix_rd_data_mem[1][i*16 + 7 +: 9]; 
                end
                calc_idx  <= 0;
                input_ram_re0 <= 1;
                input_ram_re1 <= 1;
                state <= READ_INPUT_RAM;
            end
            READ_INPUT_RAM: begin
                if (calc_idx == 6) begin
                    state <= WRITE_RAM;
                end else begin
                    input_ram_rd_addr0 <= m_mem_0[calc_idx];
                    input_ram_rd_addr1 <= m_mem_1[calc_idx];
                    state <= SHIFT_CALC;
                end
            end
            SHIFT_CALC: begin
                // shifted_data_mem[0] <= input_ram_rd_data0 << alpha_mem_0[calc_idx] |
                //                         input_ram_rd_data0 >> (DATA_WIDTH - alpha_mem_0[calc_idx]);
                // shifted_data_mem[1] <= input_ram_rd_data1 << alpha_mem_1[calc_idx] |
                //                         input_ram_rd_data1 >> (DATA_WIDTH - alpha_mem_1[calc_idx]);
                // 循环右移
                shifted_data_mem[0] <= input_ram_rd_data0 >> alpha_mem_0[calc_idx] |
                                        input_ram_rd_data0 << (DATA_WIDTH - alpha_mem_0[calc_idx]);
                shifted_data_mem[1] <= input_ram_rd_data1 >> alpha_mem_1[calc_idx] |
                                        input_ram_rd_data1 << (DATA_WIDTH - alpha_mem_1[calc_idx]);
                state <= XOR_CALC;
            end
            XOR_CALC: begin
                if (calc_idx == 6) begin
                    state <= WRITE_RAM;
                end else begin
                    if (m_mem_0[calc_idx] != 0 || alpha_mem_0[calc_idx] != 0) begin
                        sm_ram_wr_data0 <= sm_ram_wr_data0 ^ shifted_data_mem[0];
                    end
                    if (m_mem_1[calc_idx] != 0 || alpha_mem_1[calc_idx] != 0) begin
                        sm_ram_wr_data1 <= sm_ram_wr_data1 ^ shifted_data_mem[1];
                    end
                    calc_idx <= calc_idx + 1;
                    state <= READ_INPUT_RAM;
                end
            end
            WRITE_RAM: begin
                sm_ram_we0 <= 1;
                sm_ram_we1 <= 1;
                state <= NEXT_ADDR;

                // 此处同时初始化sc_vector
                sc_vector <= sc_vector ^ sm_ram_wr_data0 ^ sm_ram_wr_data1;
            end
            NEXT_ADDR: begin
                if (wait_flag < 1) begin
                    if (matrix_rd_addr_mem[1] < 107) begin
                        matrix_rd_addr_mem[0] <= matrix_rd_addr_mem[0] + 2;
                        matrix_rd_addr_mem[1] <= matrix_rd_addr_mem[1] + 2;
                        sm_ram_wr_data0 <= 0;
                        sm_ram_wr_data1 <= 0;
                        sm_ram_we0 <= 0;
                        sm_ram_we1 <= 0;
                        wait_flag <= wait_flag + 1;
                    end else begin
                        sm_matrix_calc_end <= 1;
                        sm_ram_we0 <= 0;
                        sm_ram_we1 <= 0;
                        state <= SC_CALC;
                        wait_flag <= 0;

                        // 初始化shifted_sc_vector
                        shifted_sc_vector <= sc_vector >> 1;
                    end
                end else begin
                    state <= READ_ROM;
                    wait_flag <= 0;
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
            PM_INIT: begin
                if (sm_rd_flag < 1) begin
                    if (sc_calc_end == 1 && sm_matrix_calc_end == 1) begin
                        // 提前一拍打开re
                        pm_ram_wr_data1 <= sc_vector >> 1;
                        sm_ram_re0 <= 1;
                        sm_ram_re1 <= 1;
                        sm_ram_rd_addr <= 0;
                        sm_rd_flag <= sm_rd_flag + 1;
                    end
                end else begin
                    state <= PM_CALC;
                    sm_ram_rd_addr <= sm_ram_rd_addr + 1;
                    sm_rd_flag <= 0;
                end
            end
            PM_CALC: begin
                if (sm_ram_rd_addr < SM_PM_HALF_DEPTH - 1) begin
                    pm_ram_we0 <= 1;
                    pm_ram_we1 <= 1;
                    if (pm_ram_we0 == 1 && pm_ram_we1 ==1) begin
                        pm_ram_wr_addr <= pm_ram_wr_addr + 1;
                    end
                    pm_ram_wr_data0 <= pm_ram_wr_data1 ^ sm_ram_rd_data0;
                    pm_ram_wr_data1 <= pm_ram_wr_data1 ^ sm_ram_rd_data1 ^ sm_ram_rd_data0;
                    sm_ram_rd_addr <= sm_ram_rd_addr + 1;
                end else if (sm_ram_rd_addr == SM_PM_HALF_DEPTH - 1) begin
                    pm_ram_we0 <= 1;
                    pm_ram_we1 <= 1;
                    if (pm_ram_we0 == 1 && pm_ram_we1 ==1) begin
                        pm_ram_wr_addr <= pm_ram_wr_addr + 1;
                    end
                    pm_ram_wr_data0 <= pm_ram_wr_data1 ^ sm_ram_rd_data0;
                    pm_ram_wr_data1 <= pm_ram_wr_data1 ^ sm_ram_rd_data1 ^ sm_ram_rd_data0;
                    sm_ram_rd_addr <= 0;
                    sm_rd_flag <= 0;
                    state <= PM_WAIT_WRITE;
                end
            end
            PM_WAIT_WRITE: begin
                if (pm_wait_flag < 1) begin
                    pm_ram_wr_addr <= pm_ram_wr_addr + 1;
                    pm_ram_wr_data0 <= pm_ram_wr_data1 ^ sm_ram_rd_data0;
                    pm_ram_wr_data1 <= pm_ram_wr_data1 ^ sm_ram_rd_data1 ^ sm_ram_rd_data0;
                    pm_wait_flag <= pm_wait_flag + 1;
                end else begin
                    state <= PM_END;
                    pm_wait_flag <= 0;
                end
            end
            PM_END: begin
                pm_ram_we0 <= 0;
                pm_ram_we1 <= 0;
                pm_ram_wr_data0 <= 0;
                pm_ram_wr_data1 <= 0;
                sm_ram_re0 <= 0;
                sm_ram_re1 <= 0;
                pm_calc_end <= 1;
            end
        endcase
    end
end


// always @(posedge clk or negedge rst_n) begin
//     if (!rst_n) begin

//     end else begin
//         case(state)
//             WRITE_RAM: begin

//             end
//             NEXT_ADDR: begin
//                 if (matrix_rd_addr_mem[1] >= 107) begin
//                     shifted_sc_vector <= sc_vector >> 1;
//                 end
//             end
//             SC_CALC: begin
//                 sc_vector <= sc_vector ^ shifted_sc_vector;
//                 if (shift_cnt < 360 - 2) begin
//                     shifted_sc_vector <= shifted_sc_vector >> 1;
//                     shift_cnt <= shift_cnt + 1;
//                 end else begin
//                     sc_calc_end <= 1;
//                     state <= PM_INIT;
//                 end
//             end
//         endcase
//     end
// end

// // calc pm
// reg                             pm_ram_we0, pm_ram_we1;
// wire [ADDR_WIDTH-1:0]           pm_ram_wr_addr;
// reg [DATA_WIDTH-1:0]            pm_ram_wr_data0;
// reg [DATA_WIDTH-1:0]            pm_ram_wr_data1;
// assign pm_ram_wr_addr = sm_ram_rd_addr;
// reg                             sm_rd_flag;
// reg                             pm_calc_end;
// always @(posedge clk or negedge rst_n) begin
//     if (!rst_n) begin
//         pm_ram_we0 <= 0;
//         pm_ram_we1 <= 0;
//         pm_ram_wr_data0 <= 0;
//         pm_ram_wr_data1 <= 0;
//         sm_ram_re0 <= 0;
//         sm_ram_re1 <= 0;
//         sm_ram_rd_addr <= 0;
//         sm_rd_flag <= 0;
//         pm_calc_end <= 0;
//     end else begin
//         case (state)
//             PM_INIT: begin
//                 if (sm_rd_flag < 1) begin
//                     if (sc_calc_end == 1 && sm_matrix_calc_end == 1) begin
//                         // 提前一拍打开re
//                         pm_ram_wr_data1 <= sc_vector;
//                         sm_ram_re0 <= 1;
//                         sm_ram_re1 <= 1;
//                         sm_ram_rd_addr <= 0;
//                         sm_rd_flag <= sm_rd_flag + 1;
//                     end
//                 end else begin
//                     state <= PM_CALC;
//                     // 写入第一组数据
//                     pm_ram_we0 <= 1;
//                     pm_ram_we1 <= 1;
//                     sm_rd_flag <= 0;
//                 end
//             end
//             PM_CALC: begin
//                 if (sm_ram_rd_addr < 53) begin
//                     pm_ram_wr_data0 <= pm_ram_wr_data1 ^ sm_ram_rd_data0;
//                     pm_ram_wr_data1 <= pm_ram_wr_data1 ^ sm_ram_rd_data1 ^ sm_ram_rd_data0;
//                     sm_ram_rd_addr <= sm_ram_rd_addr + 1;
//                 end else begin
//                     state <= PM_END;
//                     pm_ram_we0 <= 0;
//                     pm_ram_we1 <= 0;
//                     pm_ram_wr_data0 <= 0;
//                     pm_ram_wr_data1 <= 0;
//                     sm_ram_re0 <= 0;
//                     sm_ram_re1 <= 0;
//                     sm_ram_rd_addr <= 0;
//                     sm_rd_flag <= 0;
//                     pm_calc_end <= 1;
//                 end
//             end
//             // TODO Parity少最后一组
//         endcase
//     end
// end
endmodule
