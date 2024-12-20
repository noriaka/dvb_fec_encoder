// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_SimpleDualPortRAM_generic_block2.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_SimpleDualPortRAM_generic_block2
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/PL Frame Generator/RAM FIFO/PL Data FIFO/Frame Length FIFO/SimpleDualPortRAM_generic
// Hierarchy Level: 7
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_SimpleDualPortRAM_generic_block2
          (clk,
           enb_1_8_0,
           wr_din,
           wr_addr,
           wr_en,
           rd_addr,
           dout);

  parameter integer AddrWidth  = 1;
  parameter integer DataWidth  = 1;

  input   clk;
  input   enb_1_8_0;
  input   [DataWidth - 1:0] wr_din;  // parameterized width
  input   [AddrWidth - 1:0] wr_addr;  // parameterized width
  input   wr_en;  // ufix1
  input   [AddrWidth - 1:0] rd_addr;  // parameterized width
  output  [DataWidth - 1:0] dout;  // parameterized width


  reg  [DataWidth - 1:0] ram [2**AddrWidth - 1:0];
  reg  [DataWidth - 1:0] data_int;
  integer i;

  initial begin
    for (i=0; i<=2**AddrWidth - 1; i=i+1) begin
      ram[i] = 0;
    end
    data_int = 0;
  end


  always @(posedge clk)
    begin : SimpleDualPortRAM_generic_process
      if (enb_1_8_0 == 1'b1) begin
        if (wr_en == 1'b1) begin
          ram[wr_addr] <= wr_din;
        end
        data_int <= ram[rd_addr];
      end
    end

  assign dout = data_int;

endmodule  // dvbs2hdlTransmitterCore_SimpleDualPortRAM_generic_block2

