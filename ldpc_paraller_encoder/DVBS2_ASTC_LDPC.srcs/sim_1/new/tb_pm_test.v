`timescale 1ns/1ps

module tb_pm_test();

//-----------------------------
// 1. 申明仿真用的信号
//-----------------------------
reg clk;
reg rst_n;
wire [107:0] pm_out;

//-----------------------------
// 2. 生成时钟
//-----------------------------
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;  // 时钟周期10ns
end

//-----------------------------
// 3. 复位信号
//-----------------------------
initial begin
    rst_n = 1'b0;
    #30;            // 保持复位30ns，保证各寄存器初始化
    rst_n = 1'b1;
end

//-----------------------------
// 4. 实例化被测模块
//-----------------------------
pm_test uut (
    .clk    (clk),
    .rst_n  (rst_n),
    .pm_out (pm_out)
);

//-----------------------------
// 5. 仿真结束条件
//-----------------------------
initial begin
    // 在此处给出一个足够长的仿真时间，以便观察输出
    // 若我们知道状态机走完大概需要多少拍，可设置更合理的结束时间。
    #100000;  // 100,000ns = 100µs
    $finish;
end

endmodule
