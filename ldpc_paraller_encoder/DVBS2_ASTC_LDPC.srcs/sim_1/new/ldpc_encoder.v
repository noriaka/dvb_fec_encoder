module ldpc_encoder #(
    parameter BIT_WIDTH = 360,            // 单组数据的宽度
    parameter TOTAL_BITS = 23040,         // 总数据宽度
    parameter ROM_DEPTH = 128             // ROM 的深度
)(
    input                       clk,
    input                       rst_n,
    input                       ldpc_en,
    input [TOTAL_BITS-1:0]      bit_in,
    output reg                  sm_end
);

// Signals
integer i;
reg [6:0]           hm_addr;            // ROM 地址
wire [0:159]        hm_dout;            // ROM 数据输出

reg                 sm_we;              // RAM 写使能
reg [6:0]           sm_addr;            // RAM 地址
reg [BIT_WIDTH-1:0] sm_din;             // RAM 数据输入
wire [BIT_WIDTH-1:0] sm_dout;           // RAM 数据输出

// 临时寄存器
reg [5:0]           m [0:9];            // 10 组 m 值
reg [8:0]           alpha [0:9];        // 10 组 alpha 值
reg                 flag [0:9];         // 10 组有效标志位
reg [BIT_WIDTH-1:0] temp_shift;          // 临时移位结果
reg [BIT_WIDTH-1:0] temp_xor;            // 临时 XOR 结果

// FSM 状态
reg [3:0]           state;
localparam IDLE       = 4'd0;
localparam READ_ROM   = 4'd1;
localparam PARSE_DATA = 4'd2;
localparam SHIFT_CALC = 4'd3;
localparam XOR_CALC   = 4'd4;
localparam WRITE_RAM  = 4'd5;
localparam NEXT_ADDR  = 4'd6;

reg [3:0]           calc_idx;           // 计算索引

astc_5_15_rom astc_5_15_rom_inst (
    .clka           (clk),
    .rsta           (~rst_n),
    .addra          (hm_addr),
    .douta          (hm_dout)
);

matrix_sm_ram matrix_sm_ram_inst (
    .clka           (clk),
    .rsta           (~rst_n),
    .wea            (sm_we),
    .addra          (sm_addr),
    .dina           (sm_din),
    .douta          (sm_dout)
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        hm_addr   <= 0;
        sm_addr   <= 0;
        sm_we     <= 0;
        state     <= IDLE;
        calc_idx  <= 0;
        temp_xor  <= 0;
        i         <= 0;
        sm_end    <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (ldpc_en == 1)
                    state <= READ_ROM;
                else
                    state <= IDLE;
            end

            READ_ROM: begin
                state <= PARSE_DATA;
            end

            PARSE_DATA: begin
                // 解析 ROM 数据
                for (i = 0; i < 10; i = i + 1) begin
                    m[i]     <= hm_dout[i*16 +: 6];
                    alpha[i] <= hm_dout[i*16 + 6 +: 9];
                    flag[i]  <= hm_dout[i*16 + 15];
                end
                calc_idx  <= 0;
                temp_xor  <= 0;
                state     <= SHIFT_CALC;
            end

            SHIFT_CALC: begin
                if (flag[calc_idx]) begin
                    temp_shift <= (bit_in[m[calc_idx]*BIT_WIDTH +: BIT_WIDTH] << alpha[calc_idx]) |
                                (bit_in[m[calc_idx]*BIT_WIDTH +: BIT_WIDTH] >> (BIT_WIDTH - alpha[calc_idx]));
                    state <= XOR_CALC;
                end else begin
                    calc_idx <= calc_idx + 1;
                    if (calc_idx == 9) state <= WRITE_RAM;
                end
            end

            XOR_CALC: begin
                temp_xor <= temp_xor ^ temp_shift;
                calc_idx <= calc_idx + 1;
                if (calc_idx == 9) begin
                    state <= WRITE_RAM;
                end else begin
                    state <= SHIFT_CALC;
                end
            end

            WRITE_RAM: begin
                sm_din <= temp_xor;
                sm_we  <= 1;
                state  <= NEXT_ADDR;
            end

            NEXT_ADDR: begin
                if (sm_addr == 7'd116) begin
                    sm_we  <= 0;
                    sm_end <= 1;
                end else if (sm_addr == 7'd115) begin
                    sm_addr <= sm_addr + 1;
                    sm_we   <= 0;
                end else begin
                    hm_addr <= hm_addr + 1;
                    sm_addr <= sm_addr + 1;
                    sm_we   <= 0;
                end
                state <= IDLE;
            end

            default: state <= IDLE;
        endcase
    end
end

endmodule
