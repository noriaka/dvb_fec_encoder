`timescale 1ns / 1ps
module wrapper_pm_test(
    input           clk,
    input           rst_n
);

wire [107:0]        pm_out;

(* keep_hierarchy="yes" *)
pm_test uut (
    .clk    (clk),
    .rst_n  (rst_n),
    .pm_out (pm_out)
);

endmodule
