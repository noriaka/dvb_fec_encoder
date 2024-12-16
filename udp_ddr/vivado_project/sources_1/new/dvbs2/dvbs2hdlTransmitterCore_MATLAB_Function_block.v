// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_MATLAB_Function_block.v
// Created: 2024-01-10 13:49:57
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_MATLAB_Function_block
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/BB Frame Generator/BB Header and Data CRC Generator/MATLAB Function
// Hierarchy Level: 5
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_MATLAB_Function_block
          (clk,
           reset,
           enb,
           validIn,
           startIn,
           endIn,
           DFL,
           validAppend);


  input   clk;
  input   reset;
  input   enb;
  input   validIn;
  input   startIn;
  input   endIn;
  input   [15:0] DFL;  // uint16
  output  validAppend;


  reg  validAppend_1;
  reg  endAppend;
  reg [15:0] countDFL;  // ufix16
  reg  isEndReceived;
  reg [15:0] countDFL_next;  // ufix16
  reg  isEndReceived_next;
  reg [15:0] countDFL_temp;  // ufix16


  always @(posedge clk or posedge reset)
    begin : MATLAB_Function_process
      if (reset == 1'b1) begin
        countDFL <= 16'b0000000000000000;
        isEndReceived <= 1'b0;
      end
      else begin
        if (enb) begin
          countDFL <= countDFL_next;
          isEndReceived <= isEndReceived_next;
        end
      end
    end

  always @(DFL, countDFL, endIn, isEndReceived, startIn, validIn) begin
    countDFL_temp = countDFL;
    isEndReceived_next = isEndReceived;
    if (startIn) begin
      countDFL_temp = 16'b0000000000000000;
    end
    if (isEndReceived) begin
      validAppend_1 = 1'b1;
      countDFL_temp = countDFL_temp + 16'b0000000000000001;
    end
    else if (validIn) begin
      validAppend_1 = 1'b0;
      countDFL_temp = countDFL_temp + 16'b0000000000000001;
    end
    else begin
      validAppend_1 = 1'b0;
    end
    if (countDFL_temp > DFL) begin
      validAppend_1 = 1'b0;
    end
    if (DFL != 16'd0) begin
      if (countDFL_temp >= DFL) begin
        endAppend = isEndReceived;
        isEndReceived_next = 1'b0;
      end
      else begin
        endAppend = 1'b0;
      end
    end
    else begin
      endAppend = 1'b0;
    end
    if (endIn) begin
      isEndReceived_next = 1'b1;
    end
    countDFL_next = countDFL_temp;
  end



  assign validAppend = validAppend_1;

endmodule  // dvbs2hdlTransmitterCore_MATLAB_Function_block
