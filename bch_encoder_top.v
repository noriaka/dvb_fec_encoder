module bch_encoder_top (
    input wire clk,
    input wire rst_n,
);

parameter WIDTH = 128;

reg [WIDTH-1:0] r_val;
reg [WIDTH-1:0] gx_0 [WIDTH-1:0];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        // initial gx_0
    end
end

genvar i;
generate
    for (i = 0; i < WIDTH; i = i + 1) begin : multi_matrix
        always @(posedge clk or negedge rst_n) begin
            if (!rst_n) begin
                r_val[i] <= 1'b0;
            end else begin
                r_val[i] <= ^(gx_0[i] & r_val);
            end
        end
    end
endgenerate

endmodule