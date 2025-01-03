// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_subFilter.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_subFilter
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/RRC Transmit Filter/Discrete FIR Filter/Filter/subFilter
// Hierarchy Level: 6
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_subFilter
          (clk,
           reset,
           enb_1_2_0,
           dinReg2_0_re,
           coefIn_0,
           coefIn_1,
           coefIn_2,
           coefIn_3,
           coefIn_4,
           coefIn_5,
           coefIn_6,
           coefIn_7,
           coefIn_8,
           coefIn_9,
           coefIn_10,
           coefIn_11,
           coefIn_12,
           coefIn_13,
           coefIn_14,
           coefIn_15,
           coefIn_16,
           coefIn_17,
           coefIn_18,
           coefIn_19,
           coefIn_20,
           coefIn_21,
           coefIn_22,
           coefIn_23,
           coefIn_24,
           coefIn_25,
           coefIn_26,
           coefIn_27,
           coefIn_28,
           coefIn_29,
           coefIn_30,
           coefIn_31,
           coefIn_32,
           coefIn_33,
           coefIn_34,
           coefIn_35,
           coefIn_36,
           coefIn_37,
           coefIn_38,
           coefIn_39,
           coefIn_40,
           dinRegVld,
           syncReset,
           dout_1_re,
           doutVld);


  input   clk;
  input   reset;
  input   enb_1_2_0;
  input   signed [17:0] dinReg2_0_re;  // sfix18_En16
  input   signed [17:0] coefIn_0;  // sfix18_En17
  input   signed [17:0] coefIn_1;  // sfix18_En17
  input   signed [17:0] coefIn_2;  // sfix18_En17
  input   signed [17:0] coefIn_3;  // sfix18_En17
  input   signed [17:0] coefIn_4;  // sfix18_En17
  input   signed [17:0] coefIn_5;  // sfix18_En17
  input   signed [17:0] coefIn_6;  // sfix18_En17
  input   signed [17:0] coefIn_7;  // sfix18_En17
  input   signed [17:0] coefIn_8;  // sfix18_En17
  input   signed [17:0] coefIn_9;  // sfix18_En17
  input   signed [17:0] coefIn_10;  // sfix18_En17
  input   signed [17:0] coefIn_11;  // sfix18_En17
  input   signed [17:0] coefIn_12;  // sfix18_En17
  input   signed [17:0] coefIn_13;  // sfix18_En17
  input   signed [17:0] coefIn_14;  // sfix18_En17
  input   signed [17:0] coefIn_15;  // sfix18_En17
  input   signed [17:0] coefIn_16;  // sfix18_En17
  input   signed [17:0] coefIn_17;  // sfix18_En17
  input   signed [17:0] coefIn_18;  // sfix18_En17
  input   signed [17:0] coefIn_19;  // sfix18_En17
  input   signed [17:0] coefIn_20;  // sfix18_En17
  input   signed [17:0] coefIn_21;  // sfix18_En17
  input   signed [17:0] coefIn_22;  // sfix18_En17
  input   signed [17:0] coefIn_23;  // sfix18_En17
  input   signed [17:0] coefIn_24;  // sfix18_En17
  input   signed [17:0] coefIn_25;  // sfix18_En17
  input   signed [17:0] coefIn_26;  // sfix18_En17
  input   signed [17:0] coefIn_27;  // sfix18_En17
  input   signed [17:0] coefIn_28;  // sfix18_En17
  input   signed [17:0] coefIn_29;  // sfix18_En17
  input   signed [17:0] coefIn_30;  // sfix18_En17
  input   signed [17:0] coefIn_31;  // sfix18_En17
  input   signed [17:0] coefIn_32;  // sfix18_En17
  input   signed [17:0] coefIn_33;  // sfix18_En17
  input   signed [17:0] coefIn_34;  // sfix18_En17
  input   signed [17:0] coefIn_35;  // sfix18_En17
  input   signed [17:0] coefIn_36;  // sfix18_En17
  input   signed [17:0] coefIn_37;  // sfix18_En17
  input   signed [17:0] coefIn_38;  // sfix18_En17
  input   signed [17:0] coefIn_39;  // sfix18_En17
  input   signed [17:0] coefIn_40;  // sfix18_En17
  input   dinRegVld;
  input   syncReset;
  output  signed [17:0] dout_1_re;  // sfix18_En14
  output  doutVld;


  reg  [24:0] intdelay_reg;  // ufix1 [25]
  wire vldShift;
  wire vldOutTmp;
  wire signed [17:0] ZERO_OUT;  // sfix18_En14
  wire signed [47:0] addin;  // sfix48_En33
  wire signed [17:0] dinDly2;  // sfix18_En16
  reg signed [17:0] dinPreAdd;  // sfix18_En16
  wire signed [17:0] dinDly2_1;  // sfix18_En16
  wire signed [47:0] tapout;  // sfix48_En33
  wire signed [17:0] dinDly2_2;  // sfix18_En16
  wire signed [47:0] tapout_1;  // sfix48_En33
  wire signed [17:0] dinDly2_3;  // sfix18_En16
  wire signed [47:0] tapout_2;  // sfix48_En33
  wire signed [17:0] dinDly2_4;  // sfix18_En16
  wire signed [47:0] tapout_3;  // sfix48_En33
  wire signed [17:0] dinDly2_5;  // sfix18_En16
  wire signed [47:0] tapout_4;  // sfix48_En33
  wire signed [17:0] dinDly2_6;  // sfix18_En16
  wire signed [47:0] tapout_5;  // sfix48_En33
  wire signed [17:0] dinDly2_7;  // sfix18_En16
  wire signed [47:0] tapout_6;  // sfix48_En33
  wire signed [17:0] dinDly2_8;  // sfix18_En16
  wire signed [47:0] tapout_7;  // sfix48_En33
  wire signed [17:0] dinDly2_9;  // sfix18_En16
  wire signed [47:0] tapout_8;  // sfix48_En33
  wire signed [17:0] dinDly2_10;  // sfix18_En16
  wire signed [47:0] tapout_9;  // sfix48_En33
  wire signed [17:0] dinDly2_11;  // sfix18_En16
  wire signed [47:0] tapout_10;  // sfix48_En33
  wire signed [17:0] dinDly2_12;  // sfix18_En16
  wire signed [47:0] tapout_11;  // sfix48_En33
  wire signed [17:0] dinDly2_13;  // sfix18_En16
  wire signed [47:0] tapout_12;  // sfix48_En33
  wire signed [17:0] dinDly2_14;  // sfix18_En16
  wire signed [47:0] tapout_13;  // sfix48_En33
  wire signed [17:0] dinDly2_15;  // sfix18_En16
  wire signed [47:0] tapout_14;  // sfix48_En33
  wire signed [17:0] dinDly2_16;  // sfix18_En16
  wire signed [47:0] tapout_15;  // sfix48_En33
  wire signed [17:0] dinDly2_17;  // sfix18_En16
  wire signed [47:0] tapout_16;  // sfix48_En33
  wire signed [17:0] dinDly2_18;  // sfix18_En16
  wire signed [47:0] tapout_17;  // sfix48_En33
  wire signed [17:0] dinDly2_19;  // sfix18_En16
  wire signed [47:0] tapout_18;  // sfix48_En33
  wire signed [47:0] tapout_19;  // sfix48_En33
  wire signed [17:0] ZERO;  // sfix18_En16
  wire signed [17:0] dinDly2deadOutdeadOut;  // sfix18_En16
  wire signed [47:0] tapout_20;  // sfix48_En33
  wire signed [17:0] dout_cast;  // sfix18_En14
  wire signed [17:0] muxOut;  // sfix18_En14
  reg signed [17:0] dout_1_re_1;  // sfix18_En14
  reg  doutVld_1;


  always @(posedge clk or posedge reset)
    begin : intdelay_process
      if (reset == 1'b1) begin
        intdelay_reg <= {25{1'b0}};
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            intdelay_reg <= {25{1'b0}};
          end
          else begin
            if (dinRegVld) begin
              intdelay_reg[0] <= dinRegVld;
              intdelay_reg[32'sd24:32'sd1] <= intdelay_reg[32'sd23:32'sd0];
            end
          end
        end
      end
    end

  assign vldShift = intdelay_reg[24];



  assign vldOutTmp = dinRegVld & vldShift;



  assign ZERO_OUT = 18'sb000000000000000000;



  assign addin = 48'sh000000000000;



  always @(posedge clk or posedge reset)
    begin : intdelay_1_process
      if (reset == 1'b1) begin
        dinPreAdd <= 18'sb000000000000000000;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            dinPreAdd <= 18'sb000000000000000000;
          end
          else begin
            if (dinRegVld) begin
              dinPreAdd <= dinDly2;
            end
          end
        end
      end
    end



  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_1 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinReg2_0_re),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_0),  // sfix18_En17
                                                                      .addin(addin),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_1),  // sfix18_En16
                                                                      .tapout(tapout)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_2 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinDly2_1),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_1),  // sfix18_En17
                                                                      .addin(tapout),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_2),  // sfix18_En16
                                                                      .tapout(tapout_1)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_3 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinDly2_2),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_2),  // sfix18_En17
                                                                      .addin(tapout_1),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_3),  // sfix18_En16
                                                                      .tapout(tapout_2)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_4 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinDly2_3),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_3),  // sfix18_En17
                                                                      .addin(tapout_2),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_4),  // sfix18_En16
                                                                      .tapout(tapout_3)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_5 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinDly2_4),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_4),  // sfix18_En17
                                                                      .addin(tapout_3),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_5),  // sfix18_En16
                                                                      .tapout(tapout_4)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_6 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinDly2_5),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_5),  // sfix18_En17
                                                                      .addin(tapout_4),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_6),  // sfix18_En16
                                                                      .tapout(tapout_5)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_7 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinDly2_6),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_6),  // sfix18_En17
                                                                      .addin(tapout_5),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_7),  // sfix18_En16
                                                                      .tapout(tapout_6)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_8 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinDly2_7),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_7),  // sfix18_En17
                                                                      .addin(tapout_6),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_8),  // sfix18_En16
                                                                      .tapout(tapout_7)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_9 (.clk(clk),
                                                                      .enb_1_2_0(enb_1_2_0),
                                                                      .dinReg2_0_re(dinDly2_8),  // sfix18_En16
                                                                      .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                      .coefIn_0(coefIn_8),  // sfix18_En17
                                                                      .addin(tapout_7),  // sfix48_En33
                                                                      .dinRegVld(dinRegVld),
                                                                      .syncReset(syncReset),
                                                                      .dinDly2(dinDly2_9),  // sfix18_En16
                                                                      .tapout(tapout_8)  // sfix48_En33
                                                                      );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_10 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_9),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_9),  // sfix18_En17
                                                                       .addin(tapout_8),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_10),  // sfix18_En16
                                                                       .tapout(tapout_9)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_11 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_10),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_10),  // sfix18_En17
                                                                       .addin(tapout_9),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_11),  // sfix18_En16
                                                                       .tapout(tapout_10)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_12 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_11),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_11),  // sfix18_En17
                                                                       .addin(tapout_10),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_12),  // sfix18_En16
                                                                       .tapout(tapout_11)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_13 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_12),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_12),  // sfix18_En17
                                                                       .addin(tapout_11),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_13),  // sfix18_En16
                                                                       .tapout(tapout_12)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_14 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_13),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_13),  // sfix18_En17
                                                                       .addin(tapout_12),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_14),  // sfix18_En16
                                                                       .tapout(tapout_13)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_15 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_14),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_14),  // sfix18_En17
                                                                       .addin(tapout_13),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_15),  // sfix18_En16
                                                                       .tapout(tapout_14)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_16 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_15),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_15),  // sfix18_En17
                                                                       .addin(tapout_14),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_16),  // sfix18_En16
                                                                       .tapout(tapout_15)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_17 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_16),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_16),  // sfix18_En17
                                                                       .addin(tapout_15),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_17),  // sfix18_En16
                                                                       .tapout(tapout_16)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_18 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_17),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_17),  // sfix18_En17
                                                                       .addin(tapout_16),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_18),  // sfix18_En16
                                                                       .tapout(tapout_17)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_19 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_18),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_18),  // sfix18_En17
                                                                       .addin(tapout_17),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2_19),  // sfix18_En16
                                                                       .tapout(tapout_18)  // sfix48_En33
                                                                       );

  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_20 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2_19),  // sfix18_En16
                                                                       .dinPreAdd(dinPreAdd),  // sfix18_En16
                                                                       .coefIn_0(coefIn_19),  // sfix18_En17
                                                                       .addin(tapout_18),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2),  // sfix18_En16
                                                                       .tapout(tapout_19)  // sfix48_En33
                                                                       );

  assign ZERO = 18'sb000000000000000000;



  dvbs2hdlTransmitterCore_FilterTapSystolicPreAddWvlIn u_FilterTap_21 (.clk(clk),
                                                                       .enb_1_2_0(enb_1_2_0),
                                                                       .dinReg2_0_re(dinDly2),  // sfix18_En16
                                                                       .dinPreAdd(ZERO),  // sfix18_En16
                                                                       .coefIn_0(coefIn_20),  // sfix18_En17
                                                                       .addin(tapout_19),  // sfix48_En33
                                                                       .dinRegVld(dinRegVld),
                                                                       .syncReset(syncReset),
                                                                       .dinDly2(dinDly2deadOutdeadOut),  // sfix18_En16
                                                                       .tapout(tapout_20)  // sfix48_En33
                                                                       );

  assign dout_cast = tapout_20[36:19];



  assign muxOut = (vldOutTmp == 1'b0 ? ZERO_OUT :
              dout_cast);



  always @(posedge clk or posedge reset)
    begin : intdelay_2_process
      if (reset == 1'b1) begin
        dout_1_re_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            dout_1_re_1 <= 18'sb000000000000000000;
          end
          else begin
            dout_1_re_1 <= muxOut;
          end
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : intdelay_3_process
      if (reset == 1'b1) begin
        doutVld_1 <= 1'b0;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            doutVld_1 <= 1'b0;
          end
          else begin
            doutVld_1 <= vldOutTmp;
          end
        end
      end
    end



  assign dout_1_re = dout_1_re_1;

  assign doutVld = doutVld_1;

endmodule  // dvbs2hdlTransmitterCore_subFilter

