// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Subsystem_block.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Subsystem_block
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/Interleaver/DVB-S2 HDL Interleaver/RAM Address Generator/Read Offset 
// Address/Read Offset Address Signals Generator/Subsyste
// Hierarchy Level: 8
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Subsystem_block
          (chkwrAddrEnd,
           Out1);


  input   [15:0] chkwrAddrEnd;  // uint16
  output  [15:0] Out1;  // uint16


  wire Constant1_out1;  // ufix1
  wire Constant_out1;  // ufix1
  wire Switch_out1;  // ufix1
  wire signed [16:0] Subtract_sub_temp;  // sfix17
  wire signed [16:0] Subtract_1;  // sfix17
  wire signed [16:0] Subtract_2;  // sfix17
  wire [15:0] Subtract_out1;  // uint16


  assign Constant1_out1 = 1'b0;



  assign Constant_out1 = 1'b1;



  assign Switch_out1 = (chkwrAddrEnd == 16'b0000000000000000 ? Constant1_out1 :
              Constant_out1);



  assign Subtract_1 = {1'b0, chkwrAddrEnd};
  assign Subtract_2 = {16'b0, Switch_out1};
  assign Subtract_sub_temp = Subtract_1 - Subtract_2;
  assign Subtract_out1 = Subtract_sub_temp[15:0];



  assign Out1 = Subtract_out1;

endmodule  // dvbs2hdlTransmitterCore_Subsystem_block

