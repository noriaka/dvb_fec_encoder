`timescale 1ns / 1ps

module ram_1r1w #(
    parameter ADDR_WIDTH = 7,
    parameter DATA_WIDTH = 360,
    parameter DEPTH = 72,
    parameter NUM_READ_PORTS = 2
)(
    input clk,

    // Read ports
    input                           re0,
    input [ADDR_WIDTH-1:0]          rd_addr0,
    output reg [DATA_WIDTH-1:0]     rd_data0,

    // write ports
    input                           we,
    input [ADDR_WIDTH-1:0]          wr_addr,
    input [DATA_WIDTH-1:0]          wr_data
);

    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];

    // Read
    always @(posedge clk) begin
        if (re0) begin
            rd_data0 <= ram[rd_addr0];
        end
    end

    // Write
    always @(posedge clk) begin
        if (we) begin
            ram[wr_addr] <= wr_data;
        end
    end

endmodule
