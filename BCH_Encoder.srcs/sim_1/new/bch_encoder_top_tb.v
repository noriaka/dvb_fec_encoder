`timescale 1ns / 1ps

module bch_encoder_top_tb();

reg clk;
reg rst_n;
wire [3:0] r_val;

always #5000 clk = ~clk;

initial begin
    clk = 0;
    rst_n = 0;


    #2000
    rst_n = 1;
end

bch_encoder_top bch_encoder_top_inst (
    .clk            (clk),
    .rst_n          (rst_n),
    .r_val          (r_val)
);

endmodule
