`timescale 1ns / 1ps

module ldpc_parallel_encoder_wrapper(
    input           clk,
    input           reset,
    input           clk_enable,
    input [5:0]     pktIn,
    output          validOut,
    output          ce_out_0,
    output          nextFrame,
    output [18:0]   dataOut_re,
    output [18:0]   dataOut_im
);
wire                nextFrame;
wire                ldpc_valid_out;
assign valid_out = ldpc_valid_out;
assign ce_out_0 = ldpc_valid_out;
assign dataOut_im = 19'd0;

ldpc_parallel_encoder ldpc_parallel_encoder_inst (
    .clk            (clk),
    .rst_n          (~reset),
    .clk_enable     (clk_enable),
    .bit_in         (pkt[5]),
    .valid_out      (ldpc_valid_out),
    .data_out       (dataOut_re)
);

endmodule