`timescale 1ns / 1ps
module tb_Test();
//-------------------------test1-------------------------
// reg             clk;
// reg             rst_n;

// reg [6:0]       addr;
// reg [359:0]     bit_in;
// wire [159:0]    dout;

// reg [6:0]       cnt;
// wire [359:0]     sj;
// assign sj = cnt ^ {~dout, 200'b0};

// always #50 clk = ~clk;

// initial begin
//     clk = 0;
//     rst_n = 0;
//     bit_in = 1;
//     #101
//     rst_n = 1;
// end

// reg         s_matrix_begin;
// reg         s_matrix_end;

// always @(posedge clk or negedge rst_n) begin
//     if (!rst_n) begin
//         addr <= 0;
//         cnt <= 0;
//         s_matrix_begin <= 0;
//         s_matrix_end <= 0;
//     end else begin
//         if (cnt < 7'd10)
//             cnt <= cnt + 1;
//         else if (cnt == 7'd125) begin
//             // cnt <= 0;
//             // addr <= 0;
//             s_matrix_end <= 1;
//         end else begin
//             s_matrix_begin <= 1;
//             cnt <= cnt + 1;
//             addr <= addr + 1;
//         end
//     end
// end

// Test Test_inst (
//     .clk            (clk),
//     .rst_n          (rst_n),
//     .addr           (addr),
//     .dout           (dout)
// );

//-------------------------test2-------------------------
// // Parameters
// parameter WIDTH = 360;    // 输入位宽
// parameter STAGES = 4;     // 流水线阶段数

// // Inputs
// reg clk;
// reg rst_n;
// reg [WIDTH-1:0] sc;

// // Outputs
// wire [WIDTH-1:0] p;
// wire done;

// // Instantiate DUT (Device Under Test)
// init_pm #(
//     .WIDTH(WIDTH),
//     .STAGES(STAGES)
// ) dut (
//     .clk(clk),
//     .rst_n(rst_n),
//     .sc(sc),
//     .p(p),
//     .done(done)
// );

// // Clock generation
// initial begin
//     clk = 0;
//     forever #5 clk = ~clk; // 10ns 时钟周期
// end

// // Stimulus
// initial begin
//     // 初始化
//     rst_n = 0;
//     sc = 0;

//     // 复位信号拉高
//     #20 rst_n = 1;

//     // 输入测试数据：sc = 全 1
//     sc = {WIDTH{1'b1}};
//     #10;

//     // 输入测试数据：sc = 递增位
//     sc = 360'b0000000000000000000000000000000000000000000000000000000000000001;
//     #50;

//     // 输入测试数据：随机位
//     sc = $random;
//     #50;

//     // 停止仿真
//     #100;
//     $finish;
// end

// // Monitor outputs
// always @(posedge clk) begin
//     if (done) begin
//         $display("Time: %0t | Input: sc = %h | Output: p = %h | Done = %b",
//                  $time, sc, p, done);
//     end
// end

//-------------------------test3-------------------------

// 参数定义
parameter ADDR_WIDTH = 7;
parameter DATA_WIDTH = 96;
parameter DEPTH = 108;
parameter NUM_READ_PORTS = 2;
reg                                      clk;
reg                                      rst_n;
reg [NUM_READ_PORTS-1:0]                 re;
wire [NUM_READ_PORTS*ADDR_WIDTH-1:0]     rd_addr;
wire [NUM_READ_PORTS*DATA_WIDTH-1:0]     rd_data;

reg [ADDR_WIDTH-1:0]        rd_addr_1;
reg [ADDR_WIDTH-1:0]        rd_addr_2;
assign rd_addr = {rd_addr_2, rd_addr_1};

mutiport_rom_atsc_6_15 #(
    .ADDR_WIDTH         (ADDR_WIDTH),
    .DATA_WIDTH         (DATA_WIDTH),
    .DEPTH              (DEPTH),
    .NUM_READ_PORTS     (NUM_READ_PORTS)
) mutiport_rom_atsc_6_15_inst (
    .clk                (clk),
    .rst_n              (rst_n),
    .re                 (re),
    .rd_addr            (rd_addr),
    .rd_data            (rd_data)
);

always begin
    #5 clk = ~clk; // 时钟周期 10ns
end

initial begin
    clk = 0;
    rst_n = 0;
    re = 0;

    #20;
    rst_n = 1'b1;

    #20;
    re = 2'b11; // 使能两个读端口

    #1000;
    $finish;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        rd_addr_1 <= 7'd0;
        rd_addr_2 <= 7'd0;
    end else begin
        if (re == 2'b11) begin
            if (rd_addr_2 < 107) begin
                rd_addr_1 <= rd_addr_1 + 2;
                rd_addr_2 <= rd_addr_2 + 2;
            end
        end else begin
            rd_addr_1 <= 7'd0;
            rd_addr_2 <= 7'd1;
        end
    end
end

// // 打印数据
// initial begin
//     $monitor("Time = %t, rd_data = %h", $time, rd_data);
// end

endmodule

