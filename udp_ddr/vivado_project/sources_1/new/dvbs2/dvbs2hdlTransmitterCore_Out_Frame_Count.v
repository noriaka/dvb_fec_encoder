// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Out_Frame_Count.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Out_Frame_Count
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/PL Frame Generator/RAM FIFO/PL Data FIFO/Out Frame Count
// Hierarchy Level: 6
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Out_Frame_Count
          (clk,
           reset,
           enb_1_8_0,
           endOfPLHeader,
           endOfPilotBlk,
           frameLength,
           startOutFrame,
           endOutFrame,
           endOutFramem2,
           endOut16Slots,
           validOut);


  input   clk;
  input   reset;
  input   enb_1_8_0;
  input   endOfPLHeader;
  input   endOfPilotBlk;
  input   [14:0] frameLength;  // ufix15
  output  startOutFrame;
  output  endOutFrame;
  output  endOutFramem2;
  output  endOut16Slots;
  output  validOut;


  wire stateControl_1;
  reg  [1:0] delayMatch_reg;  // ufix1 [2]
  wire stateControl_2;
  wire enb_1_8_0_gated;
  reg  startOutFrame_1;
  reg  endOutFrame_1;
  reg  endOutFramem2_1;
  reg  endOut16Slots_1;
  reg  validOut_1;
  reg [10:0] slotCount;  // ufix11
  reg  countActive;
  reg  slotEnd;
  reg [14:0] frameCount;  // ufix15
  reg [10:0] slotCount_next;  // ufix11
  reg  countActive_next;
  reg  slotEnd_next;
  reg [14:0] frameCount_next;  // ufix15
  wire startOutFrame_bypass;
  reg  startOutFrame_last_value;
  wire endOutFrame_bypass;
  reg  endOutFrame_last_value;
  wire endOutFramem2_bypass;
  reg  endOutFramem2_last_value;
  wire endOut16Slots_bypass;
  reg  endOut16Slots_last_value;
  wire validOut_bypass;
  reg  validOut_last_value;
  reg [10:0] slotCount_temp;  // ufix11
  reg [14:0] frameCount_temp;  // ufix15
  reg signed [16:0] sub_temp;  // sfix17
  reg [15:0] cast;  // ufix16
  reg signed [16:0] sub_temp_0;  // sfix17
  reg [15:0] sub_cast;  // ufix16
  reg signed [17:0] sub_temp_1;  // sfix18
  reg [16:0] cast_0;  // ufix17
  reg signed [16:0] sub_temp_2;  // sfix17
  reg [15:0] cast_1;  // ufix16
  reg [15:0] add_temp;  // ufix16
  reg [11:0] add_temp_0;  // ufix12
  reg [15:0] t_0;  // ufix16
  reg [15:0] t_1;  // ufix16
  reg [16:0] t_2;  // ufix17
  reg [15:0] t_3;  // ufix16
  reg signed [16:0] t_4;  // sfix17
  reg [15:0] t_5;  // ufix16
  reg signed [16:0] t_6;  // sfix17
  reg [16:0] t_7;  // ufix17
  reg signed [17:0] t_8;  // sfix18
  reg [15:0] t_9;  // ufix16
  reg signed [16:0] t_10;  // sfix17
  reg [15:0] t_11;  // ufix16
  reg [11:0] t_12;  // ufix12


  assign stateControl_1 = 1'b1;



  always @(posedge clk or posedge reset)
    begin : delayMatch_process
      if (reset == 1'b1) begin
        delayMatch_reg <= {2{1'b0}};
      end
      else begin
        if (enb_1_8_0) begin
          delayMatch_reg[0] <= stateControl_1;
          delayMatch_reg[1] <= delayMatch_reg[0];
        end
      end
    end

  assign stateControl_2 = delayMatch_reg[1];



  assign enb_1_8_0_gated = stateControl_2 && enb_1_8_0;

  always @(posedge clk or posedge reset)
    begin : Out_Frame_Count_process
      if (reset == 1'b1) begin
        slotCount <= 11'b00000000000;
        countActive <= 1'b0;
        slotEnd <= 1'b0;
        frameCount <= 15'b000000000000000;
      end
      else begin
        if (enb_1_8_0_gated) begin
          slotCount <= slotCount_next;
          countActive <= countActive_next;
          slotEnd <= slotEnd_next;
          frameCount <= frameCount_next;
        end
      end
    end

  always @(countActive, endOfPLHeader, endOfPilotBlk, frameCount, frameLength, slotCount,
       slotEnd) begin
    add_temp = 16'b0000000000000000;
    add_temp_0 = 12'b000000000000;
    t_11 = 16'b0000000000000000;
    t_12 = 12'b000000000000;
    slotCount_temp = slotCount;
    frameCount_temp = frameCount;
    countActive_next = countActive;
    t_3 = {1'b0, frameLength};
    t_4 = {1'b0, t_3};
    sub_temp = t_4 - 17'sb00000000000000001;
    if (sub_temp[16] == 1'b1) begin
      cast = 16'b0000000000000000;
    end
    else begin
      cast = sub_temp[15:0];
    end
    t_1 = {1'b0, frameCount};
    endOutFrame_1 = countActive && (t_1 == cast);
    t_5 = {1'b0, frameLength};
    t_6 = {1'b0, t_5};
    sub_temp_0 = t_6 - 17'sb00000000000000001;
    if (sub_temp_0[16] == 1'b1) begin
      sub_cast = 16'b0000000000000000;
    end
    else begin
      sub_cast = sub_temp_0[15:0];
    end
    t_7 = {1'b0, sub_cast};
    t_8 = {1'b0, t_7};
    sub_temp_1 = t_8 - 18'sb000000000000000010;
    if (sub_temp_1[17] == 1'b1) begin
      cast_0 = 17'b00000000000000000;
    end
    else begin
      cast_0 = sub_temp_1[16:0];
    end
    t_2 = {2'b0, frameCount};
    endOutFramem2_1 = countActive && (t_2 == cast_0);
    startOutFrame_1 = countActive && (frameCount == 15'b000000000000000);
    t_9 = {1'b0, frameLength};
    t_10 = {1'b0, t_9};
    sub_temp_2 = t_10 - 17'sb00000000000000001;
    if (sub_temp_2[16] == 1'b1) begin
      cast_1 = 16'b0000000000000000;
    end
    else begin
      cast_1 = sub_temp_2[15:0];
    end
    t_0 = {1'b0, frameCount};
    if (countActive && (t_0 == cast_1)) begin
      slotCount_temp = 11'b00000000000;
      countActive_next = 1'b0;
      slotEnd_next = 1'b0;
      frameCount_temp = 15'b000000000000000;
    end
    else begin
      if (countActive) begin
        t_11 = {1'b0, frameCount};
        add_temp = t_11 + 16'b0000000000000001;
        if (add_temp[15] != 1'b0) begin
          frameCount_temp = 15'b111111111111111;
        end
        else begin
          frameCount_temp = add_temp[14:0];
        end
        if (slotCount == 11'b10110011111) begin
          slotCount_temp = 11'b00000000000;
          countActive_next = 1'b0;
        end
        else begin
          t_12 = {1'b0, slotCount};
          add_temp_0 = t_12 + 12'b000000000001;
          if (add_temp_0[11] != 1'b0) begin
            slotCount_temp = 11'b11111111111;
          end
          else begin
            slotCount_temp = add_temp_0[10:0];
          end
        end
        slotEnd_next = slotCount_temp == 11'b10110011111;
      end
      else begin
        slotEnd_next = 1'b0;
      end
      if ((endOfPLHeader && (frameCount_temp == 15'b000000000000000)) || (endOfPilotBlk && (frameCount_temp != 15'b000000000000000))) begin
        countActive_next = 1'b1;
      end
    end
    endOut16Slots_1 = slotEnd;
    validOut_1 = countActive;
    slotCount_next = slotCount_temp;
    frameCount_next = frameCount_temp;
  end



  always @(posedge clk or posedge reset)
    begin : out0_bypass_process
      if (reset == 1'b1) begin
        startOutFrame_last_value <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          startOutFrame_last_value <= startOutFrame_bypass;
        end
      end
    end



  assign startOutFrame_bypass = (stateControl_2 == 1'b0 ? startOutFrame_last_value :
              startOutFrame_1);



  assign startOutFrame = startOutFrame_bypass;

  always @(posedge clk or posedge reset)
    begin : out1_bypass_process
      if (reset == 1'b1) begin
        endOutFrame_last_value <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          endOutFrame_last_value <= endOutFrame_bypass;
        end
      end
    end



  assign endOutFrame_bypass = (stateControl_2 == 1'b0 ? endOutFrame_last_value :
              endOutFrame_1);



  assign endOutFrame = endOutFrame_bypass;

  always @(posedge clk or posedge reset)
    begin : out2_bypass_process
      if (reset == 1'b1) begin
        endOutFramem2_last_value <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          endOutFramem2_last_value <= endOutFramem2_bypass;
        end
      end
    end



  assign endOutFramem2_bypass = (stateControl_2 == 1'b0 ? endOutFramem2_last_value :
              endOutFramem2_1);



  assign endOutFramem2 = endOutFramem2_bypass;

  always @(posedge clk or posedge reset)
    begin : out3_bypass_process
      if (reset == 1'b1) begin
        endOut16Slots_last_value <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          endOut16Slots_last_value <= endOut16Slots_bypass;
        end
      end
    end



  assign endOut16Slots_bypass = (stateControl_2 == 1'b0 ? endOut16Slots_last_value :
              endOut16Slots_1);



  assign endOut16Slots = endOut16Slots_bypass;

  always @(posedge clk or posedge reset)
    begin : out4_bypass_process
      if (reset == 1'b1) begin
        validOut_last_value <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          validOut_last_value <= validOut_bypass;
        end
      end
    end



  assign validOut_bypass = (stateControl_2 == 1'b0 ? validOut_last_value :
              validOut_1);



  assign validOut = validOut_bypass;

endmodule  // dvbs2hdlTransmitterCore_Out_Frame_Count

