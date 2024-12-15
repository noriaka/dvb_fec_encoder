`timescale 1ns / 1ps

module Test(
    input           clk,
    input           rst_n,
    input [6:0]     addr,
    output [159:0]  dout
);

astc_5_15_rom astc_5_15_rom_inst (
    .clka                 (clk),            // input wire clka
    .rsta                 (~rst_n),            // input wire rsta
    .addra                (addr),          // input wire [6 : 0] addra
    .douta                (dout)          // output wire [159 : 0] douta
    // .rsta_busy            (rsta_busy)  // output wire rsta_busy
);




endmodule
