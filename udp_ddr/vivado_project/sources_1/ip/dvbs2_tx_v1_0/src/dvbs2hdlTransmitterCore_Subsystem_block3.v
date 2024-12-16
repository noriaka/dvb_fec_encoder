// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Subsystem_block3.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Subsystem_block3
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/PL Frame Generator/Subsystem
// Hierarchy Level: 4
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Subsystem_block3
          (clk,
           reset,
           enb,
           data_re,
           data_im,
           start,
           endIn,
           validIn,
           dataOut_re,
           dataOut_im,
           startOut,
           validOut);


  input   clk;
  input   reset;
  input   enb;
  input   signed [17:0] data_re;  // sfix18_En16
  input   signed [17:0] data_im;  // sfix18_En16
  input   start;
  input   endIn;
  input   validIn;
  output  signed [17:0] dataOut_re;  // sfix18_En16
  output  signed [17:0] dataOut_im;  // sfix18_En16
  output  startOut;
  output  validOut;


  reg signed [17:0] Unit_Delay_Enabled_Synchronous_out1_re;  // sfix18_En16
  reg signed [17:0] Unit_Delay_Enabled_Synchronous_out1_im;  // sfix18_En16
  wire signed [17:0] Unit_Delay_Enabled_Synchronous_ectrl_re;  // sfix18_En16
  wire signed [17:0] Unit_Delay_Enabled_Synchronous_ectrl_im;  // sfix18_En16
  reg signed [17:0] Delay2_out1_re;  // sfix18_En16
  reg signed [17:0] Delay2_out1_im;  // sfix18_En16
  reg  [7:0] Delay_reg;  // ufix1 [8]
  wire Delay_out1;
  reg  [7:0] Delay1_reg;  // ufix1 [8]
  wire Delay1_out1;


  assign Unit_Delay_Enabled_Synchronous_ectrl_re = (validIn == 1'b0 ? Unit_Delay_Enabled_Synchronous_out1_re :
              data_re);
  assign Unit_Delay_Enabled_Synchronous_ectrl_im = (validIn == 1'b0 ? Unit_Delay_Enabled_Synchronous_out1_im :
              data_im);



  always @(posedge clk or posedge reset)
    begin : Unit_Delay_Enabled_Synchronous_lowered_process
      if (reset == 1'b1) begin
        Unit_Delay_Enabled_Synchronous_out1_re <= 18'sb000000000000000000;
        Unit_Delay_Enabled_Synchronous_out1_im <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          Unit_Delay_Enabled_Synchronous_out1_re <= Unit_Delay_Enabled_Synchronous_ectrl_re;
          Unit_Delay_Enabled_Synchronous_out1_im <= Unit_Delay_Enabled_Synchronous_ectrl_im;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay2_process
      if (reset == 1'b1) begin
        Delay2_out1_re <= 18'sb000000000000000000;
        Delay2_out1_im <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          Delay2_out1_re <= Unit_Delay_Enabled_Synchronous_out1_re;
          Delay2_out1_im <= Unit_Delay_Enabled_Synchronous_out1_im;
        end
      end
    end



  assign dataOut_re = Delay2_out1_re;

  assign dataOut_im = Delay2_out1_im;

  always @(posedge clk or posedge reset)
    begin : Delay_process
      if (reset == 1'b1) begin
        Delay_reg <= {8{1'b0}};
      end
      else begin
        if (enb) begin
          Delay_reg[0] <= start;
          Delay_reg[32'sd7:32'sd1] <= Delay_reg[32'sd6:32'sd0];
        end
      end
    end

  assign Delay_out1 = Delay_reg[7];



  always @(posedge clk or posedge reset)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_reg <= {8{1'b0}};
      end
      else begin
        if (enb) begin
          Delay1_reg[0] <= endIn;
          Delay1_reg[32'sd7:32'sd1] <= Delay1_reg[32'sd6:32'sd0];
        end
      end
    end

  assign Delay1_out1 = Delay1_reg[7];



  dvbs2hdlTransmitterCore_8x u_8x (.clk(clk),
                                   .reset(reset),
                                   .enb(enb),
                                   .startIn(Delay_out1),
                                   .endIn(Delay1_out1),
                                   .startOut(startOut),
                                   .validOut(validOut)
                                   );

endmodule  // dvbs2hdlTransmitterCore_Subsystem_block3

