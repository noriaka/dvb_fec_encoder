// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Sample_Control_Bus_Creator_block1.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Sample_Control_Bus_Creator_block1
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/FEC Encoder/Sample Control Bus Creator
// Hierarchy Level: 4
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Sample_Control_Bus_Creator_block1
          (In1,
           In2,
           In3,
           Out1_start,
           Out1_end,
           Out1_valid);


  input   In1;
  input   In2;
  input   In3;
  output  Out1_start;
  output  Out1_end;
  output  Out1_valid;




  assign Out1_start = In1;

  assign Out1_end = In2;

  assign Out1_valid = In3;

endmodule  // dvbs2hdlTransmitterCore_Sample_Control_Bus_Creator_block1

