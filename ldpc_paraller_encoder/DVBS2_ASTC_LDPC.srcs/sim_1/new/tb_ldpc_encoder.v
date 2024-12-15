`timescale 1ns/1ps

module tb_ldpc_encoder;

// Parameters
parameter BIT_WIDTH = 360;
parameter TOTAL_BITS = 23040;
parameter ROM_DEPTH = 128;

// Inputs
reg                       clk;
reg                       rst_n;
reg                       ldpc_en;
reg [TOTAL_BITS-1:0]      bit_in;
wire                      sm_end;

ldpc_encoder #(
    .BIT_WIDTH      (BIT_WIDTH),
    .TOTAL_BITS     (TOTAL_BITS),
    .ROM_DEPTH      (ROM_DEPTH)
) dut (
    .clk            (clk),
    .rst_n          (rst_n),
    .ldpc_en        (ldpc_en),
    .bit_in         (bit_in),
    .sm_end         (sm_end)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

integer i;
initial begin
    rst_n = 0;
    bit_in = 1;
    ldpc_en = 0;

    #20 rst_n = 1;

    for (i = 0; i < TOTAL_BITS; i = i + 1) begin
        bit_in[i] = $random % 2; // Random 0 or 1
    end
    
    #500 ldpc_en = 1;

    // Wait for processing to complete
    // #10000;
    // $finish;
end

always @(posedge clk) begin
    if (dut.state == 4'd5) begin // WRITE_RAM state
        $display("Time: %0t | Writing to RAM: Data = %h at Address = %d",
                $time, dut.sm_din, dut.sm_addr);
    end
end

always @(posedge clk) begin
    if (sm_end == 1)
        $finish;
end

endmodule
