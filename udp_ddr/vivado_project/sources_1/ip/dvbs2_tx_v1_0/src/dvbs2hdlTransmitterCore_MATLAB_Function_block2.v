// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_MATLAB_Function_block2.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_MATLAB_Function_block2
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/Interleaver/DVB-S2 HDL Interleaver/MATLAB Function
// Hierarchy Level: 5
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_MATLAB_Function_block2
          (clk,
           reset,
           enb,
           valid,
           start,
           fecFrameIn,
           modIn,
           ready);


  input   clk;
  input   reset;
  input   enb;
  input   valid;
  input   start;
  input   fecFrameIn;
  input   [1:0] modIn;  // ufix2
  output  ready;


  reg  ready_1;
  reg [17:0] cnt;  // ufix18
  reg [17:0] cntval;  // ufix18
  reg [17:0] count;  // ufix18
  reg  countActive;
  reg [15:0] countToFrameLength;  // ufix16
  reg [17:0] countToFinalValue;  // ufix18
  reg  readyReg;
  reg [17:0] count_next;  // ufix18
  reg  countActive_next;
  reg [15:0] countToFrameLength_next;  // ufix16
  reg [17:0] countToFinalValue_next;  // ufix18
  reg  readyReg_next;
  reg  countActive_temp;
  reg [15:0] countToFrameLength_temp;  // ufix16
  reg [17:0] countToFinalValue_temp;  // ufix18
  reg [17:0] t_0;  // ufix18


  always @(posedge clk or posedge reset)
    begin : MATLAB_Function_process
      if (reset == 1'b1) begin
        count <= 18'b000000000000000000;
        countActive <= 1'b0;
        readyReg <= 1'b1;
        countToFrameLength <= 16'b1111110100100000;
        countToFinalValue <= 18'b111111010010000000;
      end
      else begin
        if (enb) begin
          count <= count_next;
          countActive <= countActive_next;
          countToFrameLength <= countToFrameLength_next;
          countToFinalValue <= countToFinalValue_next;
          readyReg <= readyReg_next;
        end
      end
    end

  always @(count, countActive, countToFinalValue, countToFrameLength, fecFrameIn, modIn,
       readyReg, start, valid) begin
    t_0 = 18'b000000000000000000;
    countActive_temp = countActive;
    countToFrameLength_temp = countToFrameLength;
    countToFinalValue_temp = countToFinalValue;
    count_next = count;
    readyReg_next = readyReg;
    if (start) begin
      if (fecFrameIn) begin
        countToFrameLength_temp = 16'b0011111101001000;
        case ( modIn)
          2'b00 :
            begin
              countToFinalValue_temp = 18'b001111110100100000;
            end
          2'b01 :
            begin
              countToFinalValue_temp = 18'b001010100011000000;
            end
          2'b10 :
            begin
              countToFinalValue_temp = 18'b000111111010010000;
            end
          2'b11 :
            begin
              countToFinalValue_temp = 18'b000110010101000000;
            end
        endcase
      end
      else begin
        countToFrameLength_temp = 16'b1111110100100000;
        case ( modIn)
          2'b00 :
            begin
              countToFinalValue_temp = 18'b111111010010000000;
            end
          2'b01 :
            begin
              countToFinalValue_temp = 18'b101010001100000000;
            end
          2'b10 :
            begin
              countToFinalValue_temp = 18'b011111101001000000;
            end
          2'b11 :
            begin
              countToFinalValue_temp = 18'b011001010100000000;
            end
        endcase
      end
      countActive_temp = 1'b1;
    end
    if (countActive_temp) begin
      t_0 = {2'b0, countToFrameLength_temp};
      if (count < t_0) begin
        if (valid) begin
          count_next = count + 18'b000000000000000001;
        end
        readyReg_next = 1'b1;
      end
      else if (count == countToFinalValue_temp) begin
        count_next = 18'b000000000000000000;
        countActive_temp = 1'b0;
        readyReg_next = 1'b1;
      end
      else begin
        count_next = count + 18'b000000000000000001;
        readyReg_next = 1'b0;
      end
    end
    ready_1 = readyReg;
    cnt = count;
    cntval = countToFinalValue;
    countActive_next = countActive_temp;
    countToFrameLength_next = countToFrameLength_temp;
    countToFinalValue_next = countToFinalValue_temp;
  end



  assign ready = ready_1;

endmodule  // dvbs2hdlTransmitterCore_MATLAB_Function_block2

