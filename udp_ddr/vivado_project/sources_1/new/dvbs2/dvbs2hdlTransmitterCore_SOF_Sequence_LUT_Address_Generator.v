// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_SOF_Sequence_LUT_Address_Generator.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_SOF_Sequence_LUT_Address_Generator
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/PL Frame Generator/PL Header Generator/PL Header Bits Generator/SOF 
// Generator/SOF Sequence LUT Address Generato
// Hierarchy Level: 7
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_SOF_Sequence_LUT_Address_Generator
          (clk,
           reset,
           enb_1_8_0,
           trigger,
           LUTAddr,
           valid);


  input   clk;
  input   reset;
  input   enb_1_8_0;
  input   trigger;
  output  [4:0] LUTAddr;  // ufix5
  output  valid;


  reg [4:0] LUTAddr_1;  // ufix5
  reg  valid_1;
  reg [4:0] count;  // ufix5
  reg  countActive;
  reg [4:0] count_next;  // ufix5
  reg  countActive_next;


  always @(posedge clk or posedge reset)
    begin : SOF_Sequence_LUT_Address_Generator_process
      if (reset == 1'b1) begin
        count <= 5'b00000;
        countActive <= 1'b0;
      end
      else begin
        if (enb_1_8_0) begin
          count <= count_next;
          countActive <= countActive_next;
        end
      end
    end

  always @(count, countActive, trigger) begin
    count_next = count;
    countActive_next = countActive;
    if (countActive) begin
      if (count == 5'b11001) begin
        count_next = 5'b00000;
        countActive_next = 1'b0;
      end
      else begin
        count_next = count + 5'b00001;
      end
    end
    if (trigger) begin
      countActive_next = 1'b1;
    end
    LUTAddr_1 = count;
    valid_1 = countActive;
  end



  assign LUTAddr = LUTAddr_1;

  assign valid = valid_1;

endmodule  // dvbs2hdlTransmitterCore_SOF_Sequence_LUT_Address_Generator

