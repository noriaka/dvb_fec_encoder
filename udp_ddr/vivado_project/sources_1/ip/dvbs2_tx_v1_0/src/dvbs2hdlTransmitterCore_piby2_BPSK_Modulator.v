// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_piby2_BPSK_Modulator.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_piby2_BPSK_Modulator
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/PL Frame Generator/PL Header Generator/piby2 BPSK Modulator
// Hierarchy Level: 5
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_piby2_BPSK_Modulator
          (clk,
           reset,
           enb_1_8_0,
           bitsIn,
           startIn,
           validIn,
           dataOut_re,
           dataOut_im,
           validOut);


  input   clk;
  input   reset;
  input   enb_1_8_0;
  input   bitsIn;
  input   startIn;
  input   validIn;
  output  signed [17:0] dataOut_re;  // sfix18_En16
  output  signed [17:0] dataOut_im;  // sfix18_En16
  output  validOut;


  reg  [1:0] delayMatch_reg;  // ufix1 [2]
  wire startIn_1;
  reg  Delay4_out1;
  wire [6:0] count_step;  // ufix7
  wire [6:0] count_from;  // ufix7
  wire [6:0] count_reset;  // ufix7
  reg [6:0] HDL_Counter_out1;  // ufix7
  wire [6:0] count;  // ufix7
  wire need_to_wrap;
  wire [6:0] count_value;  // ufix7
  wire [6:0] count_1;  // ufix7
  wire [6:0] count_2;  // ufix7
  wire dtc1;  // ufix1
  wire Data_Type_Conversion_out1;
  wire signed [17:0] Constant2_out1_re;  // sfix18_En16
  wire signed [17:0] Constant2_out1_im;  // sfix18_En16
  wire signed [17:0] Constant1_out1_re;  // sfix18_En16
  wire signed [17:0] Constant1_out1_im;  // sfix18_En16
  wire signed [17:0] Switch_out1_re;  // sfix18_En16
  wire signed [17:0] Switch_out1_im;  // sfix18_En16
  wire signed [17:0] Gain_out1_re;  // sfix18_En16
  wire signed [17:0] Gain_out1_im;  // sfix18_En16
  wire signed [17:0] Switch1_out1_re;  // sfix18_En16
  wire signed [17:0] Switch1_out1_im;  // sfix18_En16


  always @(posedge clk or posedge reset)
    begin : delayMatch_process
      if (reset == 1'b1) begin
        delayMatch_reg <= {2{1'b0}};
      end
      else begin
        if (enb_1_8_0) begin
          delayMatch_reg[0] <= startIn;
          delayMatch_reg[1] <= delayMatch_reg[0];
        end
      end
    end

  assign startIn_1 = delayMatch_reg[1];



  always @(posedge clk or posedge reset)
    begin : Delay4_process
      if (reset == 1'b1) begin
        Delay4_out1 <= 1'b0;
      end
      else begin
        if (enb_1_8_0) begin
          Delay4_out1 <= validIn;
        end
      end
    end



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 89
  assign count_step = 7'b0000001;



  assign count_from = 7'b0000000;



  assign count_reset = 7'b0000000;



  assign count = HDL_Counter_out1 + count_step;



  assign need_to_wrap = HDL_Counter_out1 == 7'b1011001;



  assign count_value = (need_to_wrap == 1'b0 ? count :
              count_from);



  assign count_1 = (Delay4_out1 == 1'b0 ? HDL_Counter_out1 :
              count_value);



  assign count_2 = (startIn_1 == 1'b0 ? count_1 :
              count_reset);



  always @(posedge clk or posedge reset)
    begin : HDL_Counter_process
      if (reset == 1'b1) begin
        HDL_Counter_out1 <= 7'b0000000;
      end
      else begin
        if (enb_1_8_0) begin
          HDL_Counter_out1 <= count_2;
        end
      end
    end



  assign dtc1 = HDL_Counter_out1[0];



  assign Data_Type_Conversion_out1 = dtc1;



  assign Constant2_out1_re = 18'sb001011010100000101;
  assign Constant2_out1_im = 18'sb001011010100000101;



  assign Constant1_out1_re = 18'sb110100101011111011;
  assign Constant1_out1_im = 18'sb110100101011111011;



  assign Switch_out1_re = (bitsIn == 1'b0 ? Constant2_out1_re :
              Constant1_out1_re);
  assign Switch_out1_im = (bitsIn == 1'b0 ? Constant2_out1_im :
              Constant1_out1_im);



  assign Gain_out1_re =  - (Switch_out1_im);
  assign Gain_out1_im = Switch_out1_re;



  assign Switch1_out1_re = (Data_Type_Conversion_out1 == 1'b0 ? Switch_out1_re :
              Gain_out1_re);
  assign Switch1_out1_im = (Data_Type_Conversion_out1 == 1'b0 ? Switch_out1_im :
              Gain_out1_im);



  assign dataOut_re = Switch1_out1_re;

  assign dataOut_im = Switch1_out1_im;

  assign validOut = Delay4_out1;

endmodule  // dvbs2hdlTransmitterCore_piby2_BPSK_Modulator

