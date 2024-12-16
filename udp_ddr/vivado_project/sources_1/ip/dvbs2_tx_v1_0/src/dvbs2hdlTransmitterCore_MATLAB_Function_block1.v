// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_MATLAB_Function_block1.v
// Created: 2024-01-10 13:49:57
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_MATLAB_Function_block1
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/BB Frame Generator/Data Store FIFO/MATLAB Function
// Hierarchy Level: 5
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_MATLAB_Function_block1
          (clk,
           reset,
           enb,
           wr,
           startIn,
           DFL,
           validOut,
           endOut);


  input   clk;
  input   reset;
  input   enb;
  input   wr;
  input   startIn;
  input   [15:0] DFL;  // uint16
  output  validOut;
  output  endOut;


  reg  validOut_1;
  reg  endOut_1;
  reg [15:0] countDFL;  // uint16
  reg  countActive;
  reg [7:0] countSamplesInRAM;  // ufix8
  reg [15:0] countDFL_next;  // uint16
  reg  countActive_next;
  reg [7:0] countSamplesInRAM_next;  // ufix8
  reg  empty;
  reg  enb1;
  reg  validOut1;
  reg [15:0] countDFL_temp;  // uint16
  reg  countActive_temp;
  reg [7:0] countSamplesInRAM_temp;  // ufix8
  reg [16:0] add_temp;  // ufix17
  reg [16:0] t_0;  // ufix17


  always @(posedge clk or posedge reset)
    begin : MATLAB_Function_process
      if (reset == 1'b1) begin
        countDFL <= 16'd0;
        countActive <= 1'b0;
        countSamplesInRAM <= 8'b00000000;
      end
      else begin
        if (enb) begin
          countDFL <= countDFL_next;
          countActive <= countActive_next;
          countSamplesInRAM <= countSamplesInRAM_next;
        end
      end
    end

  always @(DFL, countActive, countDFL, countSamplesInRAM, startIn, wr) begin
    add_temp = 17'b00000000000000000;
    t_0 = 17'b00000000000000000;
    countDFL_temp = countDFL;
    countActive_temp = countActive;
    countSamplesInRAM_temp = countSamplesInRAM;
    empty = countSamplesInRAM == 8'b00000000;
    enb1 =  ! empty;
    // cntActive = countActive;
    // cnt = countDFL;
    validOut1 = countActive && enb1;
    endOut_1 = countActive && (countDFL == DFL);
    if (((DFL != 16'd0) && (countDFL == DFL)) && enb1) begin
      countActive_temp = 1'b0;
    end
    if (startIn) begin
      countDFL_temp = 16'd0;
      countActive_temp = 1'b1;
    end
    if (countActive_temp && enb1) begin
      t_0 = {1'b0, countDFL_temp};
      add_temp = t_0 + 17'b00000000000000001;
      if (add_temp[16] != 1'b0) begin
        countDFL_temp = 16'b1111111111111111;
      end
      else begin
        countDFL_temp = add_temp[15:0];
      end
    end
    if (wr) begin
      countSamplesInRAM_temp = countSamplesInRAM + 8'b00000001;
    end
    if (validOut1) begin
      // rd
      countSamplesInRAM_temp = countSamplesInRAM_temp - 8'b00000001;
    end
    validOut_1 = validOut1;
    countDFL_next = countDFL_temp;
    countActive_next = countActive_temp;
    countSamplesInRAM_next = countSamplesInRAM_temp;
  end



  assign validOut = validOut_1;

  assign endOut = endOut_1;

endmodule  // dvbs2hdlTransmitterCore_MATLAB_Function_block1

