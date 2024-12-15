`timescale 1ns / 1ps
module sm_matrix_calc_tb();

parameter ADDR_WIDTH = 7;
parameter MATRIX_DATA_WIDTH = 96;
parameter DATA_WIDTH = 360;
parameter DEPTH = 72;
parameter SM_DEPTH = 108;
parameter NUM_READ_PORTS = 2;
parameter NUM_WRITE_PORTS = 2;

reg       clk;
reg       rst_n;
reg       en;

sm_matrix_calc #(
    .ADDR_WIDTH                  (ADDR_WIDTH),
    .MATRIX_DATA_WIDTH           (MATRIX_DATA_WIDTH),
    .DATA_WIDTH                  (DATA_WIDTH),
    .DEPTH                       (DEPTH),
    .SM_DEPTH                    (SM_DEPTH),
    .NUM_READ_PORTS              (NUM_READ_PORTS),
    .NUM_WRITE_PORTS             (NUM_WRITE_PORTS)
) sm_matrix_calc_inst (
    .clk                         (clk),
    .rst_n                       (rst_n),
    .en                          (en)
);

always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;
    rst_n = 0;
    en = 0;

    #20;
    rst_n = 1'b1;

    #20;
    en = 1'b1; // 使能两个读端口

    // #1000;
    // $finish;
end

endmodule
