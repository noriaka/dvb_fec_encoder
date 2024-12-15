module init_pm #(
    parameter WIDTH = 360,    // 数据位宽
    parameter STAGES = 4      // 流水线阶段数
)(
    input  wire clk,                  // 时钟信号
    input  wire rst_n,                // 复位信号
    input  wire [WIDTH-1:0] sc,       // 输入 sc
    output reg  [WIDTH-1:0] p,        // 输出 p
    output reg done                   // 表示结果是否有效
);

localparam CHUNK_SIZE = WIDTH / STAGES; // 每个阶段处理的位数

reg [WIDTH-1:0] stage_reg [0:STAGES-1]; // 流水线寄存器
reg [STAGES-1:0] stage_valid;           // 标志各阶段数据有效性
integer i;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < STAGES; i = i + 1) begin
            stage_reg[i] <= 0;
            stage_valid[i] <= 0;
        end
        done <= 0;
    end else begin
        for (i = 0; i < STAGES; i = i + 1) begin
            if (i == 0) begin
                stage_reg[i] <= sc;
                stage_valid[i] <= 1;
            end else begin
                stage_reg[i] <= stage_reg[i-1] ^ (stage_reg[i-1] >> CHUNK_SIZE);
                stage_valid[i] <= stage_valid[i-1];
            end
        end
        p <= stage_reg[STAGES-1];
        done <= stage_valid[STAGES-1];
    end
end

endmodule
