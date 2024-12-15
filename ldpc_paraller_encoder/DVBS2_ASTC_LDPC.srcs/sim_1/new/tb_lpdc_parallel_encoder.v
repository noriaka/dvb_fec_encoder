`timescale 1ns / 1ps

module tb_lpdc_parallel_encoder();

reg                     clk;
reg                     rst_n;
reg                     clk_enable;
reg                     bit_in;

ldpc_parallel_encoder ldpc_parallel_encoder_inst(
    .clk                (clk),
    .rst_n              (rst_n),
    .clk_enable         (clk_enable),
    .bit_in             (bit_in),

    .valid_out          (),
    .data_out           ()
);



always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;
    rst_n = 0;
    clk_enable = 0;

    #20;
    rst_n = 1'b1;

    #20;
    clk_enable = 1'b1;
    // #1000;
    // $finish;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        bit_in <= 0;
    else begin
        if (clk_enable == 1)
            bit_in <= ~bit_in;
    end
end

endmodule
