// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_90x.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_90x
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/PL Frame Generator/RAM FIFO/PL Header FIFO/90x
// Hierarchy Level: 6
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_90x
          (clk,
           reset,
           enb_1_8_0,
           trigger,
           validOut,
           startOut,
           endOut,
           endOutm1);


  input   clk;
  input   reset;
  input   enb_1_8_0;
  input   trigger;
  output  validOut;
  output  startOut;
  output  endOut;
  output  endOutm1;


  wire stateControl_1;
  reg  [1:0] delayMatch_reg;  // ufix1 [2]
  wire stateControl_2;
  wire enb_1_8_0_gated;
  reg  validOut_1;
  reg  startOut_1;
  reg  endOut_1;
  reg  endOutm1_1;
  reg [6:0] count;  // ufix7
  reg  countActive;
  reg [6:0] count_next;  // ufix7
  reg  countActive_next;
  wire validOut_bypass;
  reg  validOut_last_value;
  wire startOut_bypass;
  reg  startOut_last_value;
  wire endOut_bypass;
  reg  endOut_last_value;
  wire endOutm1_bypass;
  reg  endOutm1_last_value;
  reg [7:0] add_temp;  // ufix8
  reg [7:0] t_0;  // ufix8


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
    begin : alpha90x_process
      if (reset == 1'b1) begin
        count <= 7'b0000000;
        countActive <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          count <= count_next;
          countActive <= countActive_next;
        end
      end
    end

  always @(count, countActive, trigger) begin
    add_temp = 8'b00000000;
    t_0 = 8'b00000000;
    count_next = count;
    countActive_next = countActive;
    endOut_1 = (count == 7'b1011001) && countActive;
    endOutm1_1 = (count == 7'b1011000) && countActive;
    startOut_1 = (count == 7'b0000000) && countActive;
    if (countActive) begin
      if (count == 7'b1011001) begin
        count_next = 7'b0000000;
        countActive_next = 1'b0;
      end
      else begin
        t_0 = {1'b0, count};
        add_temp = t_0 + 8'b00000001;
        if (add_temp[7] != 1'b0) begin
          count_next = 7'b1111111;
        end
        else begin
          count_next = add_temp[6:0];
        end
      end
    end
    if (trigger) begin
      countActive_next = 1'b1;
    end
    validOut_1 = countActive;
  end



  always @(posedge clk or posedge reset)
    begin : out0_bypass_process
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

  always @(posedge clk or posedge reset)
    begin : out1_bypass_process
      if (reset == 1'b1) begin
        startOut_last_value <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          startOut_last_value <= startOut_bypass;
        end
      end
    end



  assign startOut_bypass = (stateControl_2 == 1'b0 ? startOut_last_value :
              startOut_1);



  assign startOut = startOut_bypass;

  always @(posedge clk or posedge reset)
    begin : out2_bypass_process
      if (reset == 1'b1) begin
        endOut_last_value <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          endOut_last_value <= endOut_bypass;
        end
      end
    end



  assign endOut_bypass = (stateControl_2 == 1'b0 ? endOut_last_value :
              endOut_1);



  assign endOut = endOut_bypass;

  always @(posedge clk or posedge reset)
    begin : out3_bypass_process
      if (reset == 1'b1) begin
        endOutm1_last_value <= 1'b0;
      end
      else begin
        if (enb_1_8_0_gated) begin
          endOutm1_last_value <= endOutm1_bypass;
        end
      end
    end



  assign endOutm1_bypass = (stateControl_2 == 1'b0 ? endOutm1_last_value :
              endOutm1_1);



  assign endOutm1 = endOutm1_bypass;

endmodule  // dvbs2hdlTransmitterCore_90x

