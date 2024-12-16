// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_RRC_Transmit_Filter.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_RRC_Transmit_Filter
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/RRC Transmit Filter
// Hierarchy Level: 3
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_RRC_Transmit_Filter
          (clk,
           reset,
           enb_1_8_1,
           enb_1_2_0,
           enb_1_2_1,
           dataIn_re,
           dataIn_im,
           validIn,
           dataOut_re,
           dataOut_im,
           validOut);


  input   clk;
  input   reset;
  input   enb_1_8_1;
  input   enb_1_2_0;
  input   enb_1_2_1;
  input   signed [17:0] dataIn_re;  // sfix18_En16
  input   signed [17:0] dataIn_im;  // sfix18_En16
  input   validIn;
  output  signed [17:0] dataOut_re;  // sfix18_En14
  output  signed [17:0] dataOut_im;  // sfix18_En14
  output  validOut;


  wire signed [17:0] Upsample_zero_re;  // sfix18_En16
  wire signed [17:0] Upsample_zero_im;  // sfix18_En16
  wire signed [17:0] Upsample_muxout_re;  // sfix18_En16
  wire signed [17:0] Upsample_muxout_im;  // sfix18_En16
  reg signed [17:0] Upsample_bypass_reg_re;  // sfix18_En16
  reg signed [17:0] Upsample_bypass_reg_im;  // sfix18_En16
  wire signed [17:0] Upsample_bypassout_re;  // sfix18_En16
  wire signed [17:0] Upsample_bypassout_im;  // sfix18_En16
  wire Repeat_out1;
  wire signed [17:0] Discrete_FIR_Filter_out1_re;  // sfix18_En14
  wire signed [17:0] Discrete_FIR_Filter_out1_im;  // sfix18_En14
  wire Discrete_FIR_Filter_out2;


  assign Upsample_zero_re = 18'sb000000000000000000;
  assign Upsample_zero_im = 18'sb000000000000000000;



  // Upsample: Upsample by 4, Sample offset 0 
  assign Upsample_muxout_re = (enb_1_8_1 == 1'b1 ? dataIn_re :
              Upsample_zero_re);
  assign Upsample_muxout_im = (enb_1_8_1 == 1'b1 ? dataIn_im :
              Upsample_zero_im);



  // Upsample bypass register
  always @(posedge clk or posedge reset)
    begin : Upsample_bypass_process
      if (reset == 1'b1) begin
        Upsample_bypass_reg_re <= 18'sb000000000000000000;
        Upsample_bypass_reg_im <= 18'sb000000000000000000;
      end
      else begin
        if (enb_1_2_1) begin
          Upsample_bypass_reg_im <= Upsample_muxout_im;
          Upsample_bypass_reg_re <= Upsample_muxout_re;
        end
      end
    end

  assign Upsample_bypassout_re = (enb_1_2_1 == 1'b1 ? Upsample_muxout_re :
              Upsample_bypass_reg_re);
  assign Upsample_bypassout_im = (enb_1_2_1 == 1'b1 ? Upsample_muxout_im :
              Upsample_bypass_reg_im);



  assign Repeat_out1 = validIn;

  dvbs2hdlTransmitterCore_Discrete_FIR_Filter u_Discrete_FIR_Filter (.clk(clk),
                                                                     .reset(reset),
                                                                     .enb_1_2_0(enb_1_2_0),
                                                                     .dataIn_re(Upsample_bypassout_re),  // sfix18_En16
                                                                     .dataIn_im(Upsample_bypassout_im),  // sfix18_En16
                                                                     .validIn(Repeat_out1),
                                                                     .dataOut_re(Discrete_FIR_Filter_out1_re),  // sfix18_En14
                                                                     .dataOut_im(Discrete_FIR_Filter_out1_im),  // sfix18_En14
                                                                     .validOut(Discrete_FIR_Filter_out2)
                                                                     );

  assign dataOut_re = Discrete_FIR_Filter_out1_re;

  assign dataOut_im = Discrete_FIR_Filter_out1_im;

  assign validOut = Discrete_FIR_Filter_out2;

endmodule  // dvbs2hdlTransmitterCore_RRC_Transmit_Filter

