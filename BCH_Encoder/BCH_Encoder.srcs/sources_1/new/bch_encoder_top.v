`timescale 1ns / 1ps

// module bch_encoder_top(
//     input clk,
//     input rst_n
// );

// reg [3:0] gx_0 [3:0];
// reg [3:0] r_val;

// always @(posedge clk or negedge rst_n) begin
//     if (!rst_n) begin
//         gx_0[0] <= 4'b1100;
//         gx_0[1] <= 4'b1010;
//         gx_0[2] <= 4'b0001;
//         gx_0[3] <= 4'b1000;
//         r_val <= 4'b1000;
//     end else begin
//         r_val[0] <= ^(gx_0[0] & r_val);
//         r_val[1] <= ^(gx_0[1] & r_val);
//         r_val[2] <= ^(gx_0[2] & r_val);
//         r_val[3] <= ^(gx_0[3] & r_val);
//     end
// end

// endmodule
module bch_encoder_top (
    input wire clk,
    input wire rst_n,
    output reg [3:0] r_val
);

parameter WIDTH = 4;

// output reg [WIDTH-1:0] r_val;
reg [WIDTH-1:0] gx_0 [WIDTH-1:0];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // initial gx_0
        gx_0[0] <= 4'b1100;
        gx_0[1] <= 4'b1010;
        gx_0[2] <= 4'b0001;
        gx_0[3] <= 4'b1000;
    end
end

genvar i;
generate
    for (i = 0; i < WIDTH; i = i + 1) begin : multi_matrix
        always @(posedge clk or negedge rst_n) begin
            if (!rst_n) begin
                r_val <= 4'b1000;
            end else begin
                r_val[i] <= ^(gx_0[i] & r_val);
            end
        end
    end
endgenerate

endmodule