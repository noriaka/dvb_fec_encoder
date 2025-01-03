// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/RRC Transmit Filter/Discrete FIR Filter/Filter/subFilter/FilterTapSystolicPreAddWvlIn
// Hierarchy Level: 7
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn
          (clk,
           enb_1_2_0,
           dinReg2_0_re,
           dinPreAdd,
           coefIn_0,
           addin,
           dinRegVld,
           syncReset,
           dinDly2,
           tapout);


  input   clk;
  input   enb_1_2_0;
  input   signed [17:0] dinReg2_0_re;  // sfix18_En16
  input   signed [17:0] dinPreAdd;  // sfix18_En16
  input   signed [17:0] coefIn_0;  // sfix18_En17
  input   signed [47:0] addin;  // sfix48_En33
  input   dinRegVld;
  input   syncReset;
  output  signed [17:0] dinDly2;  // sfix18_En16
  output  signed [47:0] tapout;  // sfix48_En33


  reg signed [36:0] fTap_mult_reg;  // sfix37
  reg signed [17:0] fTap_din1_reg1;  // sfix18
  reg signed [17:0] fTap_din1_reg2;  // sfix18
  reg signed [17:0] fTap_din2_reg1;  // sfix18
  reg signed [18:0] fTap_preAdd_reg;  // sfix19
  reg signed [47:0] fTap_addout_reg;  // sfix48
  reg signed [17:0] fTap_coef_reg1;  // sfix18
  reg signed [17:0] fTap_coef_reg2;  // sfix18
  reg signed [36:0] fTap_mult_reg_next;  // sfix37_En33
  reg signed [17:0] fTap_din1_reg1_next;  // sfix18_En16
  reg signed [17:0] fTap_din1_reg2_next;  // sfix18_En16
  reg signed [17:0] fTap_din2_reg1_next;  // sfix18_En16
  reg signed [18:0] fTap_preAdd_reg_next;  // sfix19_En16
  reg signed [47:0] fTap_addout_reg_next;  // sfix48_En33
  reg signed [17:0] fTap_coef_reg1_next;  // sfix18_En17
  reg signed [17:0] fTap_coef_reg2_next;  // sfix18_En17
  reg signed [17:0] dinDly2_1;  // sfix18_En16
  reg signed [47:0] tapout_1;  // sfix48_En33
  reg signed [47:0] fTap_add_cast;  // sfix48_En33
  reg signed [18:0] fTap_add_cast_0;  // sfix19_En16
  reg signed [18:0] fTap_add_cast_1;  // sfix19_En16

  initial begin
    fTap_din1_reg1 = 18'sb000000000000000000;
    fTap_din1_reg2 = 18'sb000000000000000000;
    fTap_din2_reg1 = 18'sb000000000000000000;
    fTap_preAdd_reg = 19'sb0000000000000000000;
    fTap_coef_reg1 = 18'sb000000000000000000;
    fTap_coef_reg2 = 18'sb000000000000000000;
    fTap_mult_reg = 37'sh0000000000;
    fTap_addout_reg = 48'sh000000000000;
  end

  // FilterTapSystolicPreAddWvldIn
  always @(posedge clk)
    begin : fTap_process
      if (enb_1_2_0) begin
        if (syncReset == 1'b1) begin
          fTap_din1_reg1 <= 18'sb000000000000000000;
          fTap_din1_reg2 <= 18'sb000000000000000000;
          fTap_din2_reg1 <= 18'sb000000000000000000;
          fTap_preAdd_reg <= 19'sb0000000000000000000;
          fTap_coef_reg1 <= 18'sb000000000000000000;
          fTap_coef_reg2 <= 18'sb000000000000000000;
          fTap_mult_reg <= 37'sh0000000000;
          fTap_addout_reg <= 48'sh000000000000;
        end
        else begin
          fTap_mult_reg <= fTap_mult_reg_next;
          fTap_din1_reg1 <= fTap_din1_reg1_next;
          fTap_din1_reg2 <= fTap_din1_reg2_next;
          fTap_din2_reg1 <= fTap_din2_reg1_next;
          fTap_preAdd_reg <= fTap_preAdd_reg_next;
          fTap_addout_reg <= fTap_addout_reg_next;
          fTap_coef_reg1 <= fTap_coef_reg1_next;
          fTap_coef_reg2 <= fTap_coef_reg2_next;
        end
      end
    end

  always @(addin, coefIn_0, dinPreAdd, dinReg2_0_re, dinRegVld, fTap_addout_reg,
       fTap_coef_reg1, fTap_coef_reg2, fTap_din1_reg1, fTap_din1_reg2,
       fTap_din2_reg1, fTap_mult_reg, fTap_preAdd_reg) begin
    fTap_add_cast = 48'sh000000000000;
    fTap_add_cast_0 = 19'sb0000000000000000000;
    fTap_add_cast_1 = 19'sb0000000000000000000;
    fTap_mult_reg_next = fTap_mult_reg;
    fTap_din1_reg1_next = fTap_din1_reg1;
    fTap_din1_reg2_next = fTap_din1_reg2;
    fTap_din2_reg1_next = fTap_din2_reg1;
    fTap_preAdd_reg_next = fTap_preAdd_reg;
    fTap_addout_reg_next = fTap_addout_reg;
    fTap_coef_reg1_next = fTap_coef_reg1;
    fTap_coef_reg2_next = fTap_coef_reg2;
    if (dinRegVld) begin
      fTap_add_cast = {{11{fTap_mult_reg[36]}}, fTap_mult_reg};
      fTap_addout_reg_next = fTap_add_cast + addin;
      fTap_mult_reg_next = fTap_preAdd_reg * fTap_coef_reg2;
      fTap_add_cast_0 = {fTap_din1_reg2[17], fTap_din1_reg2};
      fTap_add_cast_1 = {fTap_din2_reg1[17], fTap_din2_reg1};
      fTap_preAdd_reg_next = fTap_add_cast_0 + fTap_add_cast_1;
      fTap_din1_reg2_next = fTap_din1_reg1;
      fTap_din1_reg1_next = dinReg2_0_re;
      fTap_din2_reg1_next = dinPreAdd;
      fTap_coef_reg2_next = fTap_coef_reg1;
      fTap_coef_reg1_next = coefIn_0;
    end
    dinDly2_1 = fTap_din1_reg2;
    tapout_1 = fTap_addout_reg;
  end



  assign dinDly2 = dinDly2_1;

  assign tapout = tapout_1;

endmodule  // dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn

