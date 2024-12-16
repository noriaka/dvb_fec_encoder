// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Compare_To_Zero.v
// Created: 2024-01-10 13:49:57
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Compare_To_Zero
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/FEC Encoder/DVB-S2 BCH Encoder/Output Controller/Compare To Zero
// Hierarchy Level: 6
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Compare_To_Zero
          (u,
           y);


  input   [15:0] u;  // uint16
  output  y;


  wire [15:0] Constant_out1;  // uint16
  wire Compare_relop1;


  assign Constant_out1 = 16'b0000000000000000;



  assign Compare_relop1 = u == Constant_out1;



  assign y = Compare_relop1;

endmodule  // dvbs2hdlTransmitterCore_Compare_To_Zero
