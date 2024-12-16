// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_BB_Header_Packetizer.v
// Created: 2024-01-10 13:49:57
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_BB_Header_Packetizer
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/BB Frame Generator/BB Header and Data CRC Generator/BB Header Generator/BB 
// Header Packetize
// Hierarchy Level: 6
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_BB_Header_Packetizer
          (clk,
           reset,
           enb,
           startIn,
           TSorGS,
           DFL,
           UPL,
           SYNC,
           dataOut,
           startOut,
           endOut,
           validOut);


  input   clk;
  input   reset;
  input   enb;
  input   startIn;
  input   [1:0] TSorGS;  // ufix2
  input   [15:0] DFL;  // uint16
  input   [15:0] UPL;  // uint16
  input   [7:0] SYNC;  // uint8
  output  dataOut;
  output  startOut;
  output  endOut;
  output  validOut;


  reg  dataOut_1;
  reg  startOut_1;
  reg  endOut_1;
  reg  validOut_1;
  reg [6:0] countOut;  // ufix7
  reg [6:0] count;  // ufix7
  reg  dataReg;
  reg  startReg;
  reg  endReg;
  reg  validReg;
  reg [6:0] count_next;  // ufix7
  reg  dataReg_next;
  reg  startReg_next;
  reg  endReg_next;
  reg  validReg_next;
  reg [7:0] bm1;  // uint8
  reg [7:0] bm1_0;  // uint8
  reg [7:0] bm1_1;  // uint8
  reg [6:0] count_temp;  // ufix7
  reg [7:0] t_0;  // ufix8
  reg [7:0] t_1;  // ufix8
  reg [7:0] t_2;  // ufix8


  always @(posedge clk or posedge reset)
    begin : BB_Header_Packetizer_process
      if (reset == 1'b1) begin
        count <= 7'b1001000;
        dataReg <= 1'b0;
        startReg <= 1'b0;
        endReg <= 1'b0;
        validReg <= 1'b0;
      end
      else begin
        if (enb) begin
          count <= count_next;
          dataReg <= dataReg_next;
          startReg <= startReg_next;
          endReg <= endReg_next;
          validReg <= validReg_next;
        end
      end
    end

  always @(DFL, SYNC, TSorGS, UPL, count, dataReg, endReg, startIn, startReg, validReg) begin
    bm1 = 8'd0;
    bm1_0 = 8'd0;
    bm1_1 = 8'd0;
    t_0 = 8'b00000000;
    t_1 = 8'b00000000;
    t_2 = 8'b00000000;
    count_temp = count;
    dataReg_next = 1'b0;
    startReg_next = 1'b0;
    endReg_next = 1'b0;
    if (startIn) begin
      count_temp = 7'b0000000;
    end
    if (count_temp < 7'b1001000) begin
      validReg_next = 1'b1;
      if (count_temp == 7'b0000000) begin
        dataReg_next = TSorGS[1] != 1'b0;
        // MSB of TS/GS
        startReg_next = 1'b1;
        // start of header
      end
      else if (count_temp == 7'b0000001) begin
        dataReg_next = TSorGS[0] != 1'b0;
        // LSB of TS/GS
      end
      else if ((count_temp == 7'b0000010) || (count_temp == 7'b0000011)) begin
        dataReg_next = 1'b1;
        // SIS/MIS, CCM/ACM
        //            elseif (count >= 4) && (count <= 15)           % ISSYI, NPD, RO, MATTYPE-2
      end
      else if ((count_temp >= 7'b0010000) && (count_temp <= 7'b0011111)) begin
        t_0 = {1'b0, count_temp};
        bm1 = (8'b00100000 - t_0) - 8'd1;
        dataReg_next = UPL[bm1] != 1'b0;
        // UPL
      end
      else if ((count_temp >= 7'b0100000) && (count_temp <= 7'b0101111)) begin
        // DFL
        t_1 = {1'b0, count_temp};
        bm1_0 = (8'b00110000 - t_1) - 8'd1;
        dataReg_next = DFL[bm1_0] != 1'b0;
        // DFL
      end
      else if ((count_temp >= 7'b0110000) && (count_temp <= 7'b0110111)) begin
        // SYNC
        t_2 = {1'b0, count_temp};
        bm1_1 = (8'b00111000 - t_2) - 8'd1;
        dataReg_next = SYNC[bm1_1] != 1'b0;
        //            elseif (count >= 56) && (count <= 71)          % SYNCD
      end
      else if (count_temp == 7'b1000111) begin
        endReg_next = 1'b1;
        // end of header
      end
      count_temp = count_temp + 7'b0000001;
    end
    else begin
      validReg_next = 1'b0;
    end
    dataOut_1 = dataReg;
    startOut_1 = startReg;
    endOut_1 = endReg;
    validOut_1 = validReg;
    countOut = count;
    count_next = count_temp;
  end



  assign dataOut = dataOut_1;

  assign startOut = startOut_1;

  assign endOut = endOut_1;

  assign validOut = validOut_1;

endmodule  // dvbs2hdlTransmitterCore_BB_Header_Packetizer
