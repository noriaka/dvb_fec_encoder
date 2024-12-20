// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Filter.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Filter
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/RRC Transmit Filter/Discrete FIR Filter/Filter
// Hierarchy Level: 5
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Filter
          (clk,
           reset,
           enb_1_2_0,
           dataIn_re,
           dataIn_im,
           validIn,
           syncReset,
           dataOut_re,
           dataOut_im,
           validOut);


  input   clk;
  input   reset;
  input   enb_1_2_0;
  input   signed [17:0] dataIn_re;  // sfix18_En16
  input   signed [17:0] dataIn_im;  // sfix18_En16
  input   validIn;
  input   syncReset;
  output  signed [17:0] dataOut_re;  // sfix18_En14
  output  signed [17:0] dataOut_im;  // sfix18_En14
  output  validOut;


  reg  dinRegVld;
  reg signed [17:0] dinReg_0_re;  // sfix18_En16
  reg signed [17:0] dinReg2_0_re;  // sfix18_En16
  wire signed [17:0] CoefOut_0;  // sfix18_En17
  wire signed [17:0] CoefOut_1;  // sfix18_En17
  wire signed [17:0] CoefOut_2;  // sfix18_En17
  wire signed [17:0] CoefOut_3;  // sfix18_En17
  wire signed [17:0] CoefOut_4;  // sfix18_En17
  wire signed [17:0] CoefOut_5;  // sfix18_En17
  wire signed [17:0] CoefOut_6;  // sfix18_En17
  wire signed [17:0] CoefOut_7;  // sfix18_En17
  wire signed [17:0] CoefOut_8;  // sfix18_En17
  wire signed [17:0] CoefOut_9;  // sfix18_En17
  wire signed [17:0] CoefOut_10;  // sfix18_En17
  wire signed [17:0] CoefOut_11;  // sfix18_En17
  wire signed [17:0] CoefOut_12;  // sfix18_En17
  wire signed [17:0] CoefOut_13;  // sfix18_En17
  wire signed [17:0] CoefOut_14;  // sfix18_En17
  wire signed [17:0] CoefOut_15;  // sfix18_En17
  wire signed [17:0] CoefOut_16;  // sfix18_En17
  wire signed [17:0] CoefOut_17;  // sfix18_En17
  wire signed [17:0] CoefOut_18;  // sfix18_En17
  wire signed [17:0] CoefOut_19;  // sfix18_En17
  wire signed [17:0] CoefOut_20;  // sfix18_En17
  wire signed [17:0] CoefOut_21;  // sfix18_En17
  wire signed [17:0] CoefOut_22;  // sfix18_En17
  wire signed [17:0] CoefOut_23;  // sfix18_En17
  wire signed [17:0] CoefOut_24;  // sfix18_En17
  wire signed [17:0] CoefOut_25;  // sfix18_En17
  wire signed [17:0] CoefOut_26;  // sfix18_En17
  wire signed [17:0] CoefOut_27;  // sfix18_En17
  wire signed [17:0] CoefOut_28;  // sfix18_En17
  wire signed [17:0] CoefOut_29;  // sfix18_En17
  wire signed [17:0] CoefOut_30;  // sfix18_En17
  wire signed [17:0] CoefOut_31;  // sfix18_En17
  wire signed [17:0] CoefOut_32;  // sfix18_En17
  wire signed [17:0] CoefOut_33;  // sfix18_En17
  wire signed [17:0] CoefOut_34;  // sfix18_En17
  wire signed [17:0] CoefOut_35;  // sfix18_En17
  wire signed [17:0] CoefOut_36;  // sfix18_En17
  wire signed [17:0] CoefOut_37;  // sfix18_En17
  wire signed [17:0] CoefOut_38;  // sfix18_En17
  wire signed [17:0] CoefOut_39;  // sfix18_En17
  wire signed [17:0] CoefOut_40;  // sfix18_En17
  reg  dinReg2Vld;
  wire signed [17:0] dout_1_re;  // sfix18_En14
  wire doutVld;
  reg signed [17:0] dinReg_0_im;  // sfix18_En16
  reg signed [17:0] dinReg2_0_im;  // sfix18_En16
  wire signed [17:0] dout_1_im;  // sfix18_En14
  wire doutVlddeadOutdeadOut;


  always @(posedge clk or posedge reset)
    begin : intdelay_process
      if (reset == 1'b1) begin
        dinRegVld <= 1'b0;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            dinRegVld <= 1'b0;
          end
          else begin
            dinRegVld <= validIn;
          end
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : intdelay_1_process
      if (reset == 1'b1) begin
        dinReg_0_re <= 18'sb000000000000000000;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            dinReg_0_re <= 18'sb000000000000000000;
          end
          else begin
            if (validIn) begin
              dinReg_0_re <= dataIn_re;
            end
          end
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : intdelay_2_process
      if (reset == 1'b1) begin
        dinReg2_0_re <= 18'sb000000000000000000;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            dinReg2_0_re <= 18'sb000000000000000000;
          end
          else begin
            if (dinRegVld) begin
              dinReg2_0_re <= dinReg_0_re;
            end
          end
        end
      end
    end



  dvbs2hdlTransmitterCore_FilterCoef u_CoefTable_1 (.CoefOut_0(CoefOut_0),  // sfix18_En17
                                                    .CoefOut_1(CoefOut_1),  // sfix18_En17
                                                    .CoefOut_2(CoefOut_2),  // sfix18_En17
                                                    .CoefOut_3(CoefOut_3),  // sfix18_En17
                                                    .CoefOut_4(CoefOut_4),  // sfix18_En17
                                                    .CoefOut_5(CoefOut_5),  // sfix18_En17
                                                    .CoefOut_6(CoefOut_6),  // sfix18_En17
                                                    .CoefOut_7(CoefOut_7),  // sfix18_En17
                                                    .CoefOut_8(CoefOut_8),  // sfix18_En17
                                                    .CoefOut_9(CoefOut_9),  // sfix18_En17
                                                    .CoefOut_10(CoefOut_10),  // sfix18_En17
                                                    .CoefOut_11(CoefOut_11),  // sfix18_En17
                                                    .CoefOut_12(CoefOut_12),  // sfix18_En17
                                                    .CoefOut_13(CoefOut_13),  // sfix18_En17
                                                    .CoefOut_14(CoefOut_14),  // sfix18_En17
                                                    .CoefOut_15(CoefOut_15),  // sfix18_En17
                                                    .CoefOut_16(CoefOut_16),  // sfix18_En17
                                                    .CoefOut_17(CoefOut_17),  // sfix18_En17
                                                    .CoefOut_18(CoefOut_18),  // sfix18_En17
                                                    .CoefOut_19(CoefOut_19),  // sfix18_En17
                                                    .CoefOut_20(CoefOut_20),  // sfix18_En17
                                                    .CoefOut_21(CoefOut_21),  // sfix18_En17
                                                    .CoefOut_22(CoefOut_22),  // sfix18_En17
                                                    .CoefOut_23(CoefOut_23),  // sfix18_En17
                                                    .CoefOut_24(CoefOut_24),  // sfix18_En17
                                                    .CoefOut_25(CoefOut_25),  // sfix18_En17
                                                    .CoefOut_26(CoefOut_26),  // sfix18_En17
                                                    .CoefOut_27(CoefOut_27),  // sfix18_En17
                                                    .CoefOut_28(CoefOut_28),  // sfix18_En17
                                                    .CoefOut_29(CoefOut_29),  // sfix18_En17
                                                    .CoefOut_30(CoefOut_30),  // sfix18_En17
                                                    .CoefOut_31(CoefOut_31),  // sfix18_En17
                                                    .CoefOut_32(CoefOut_32),  // sfix18_En17
                                                    .CoefOut_33(CoefOut_33),  // sfix18_En17
                                                    .CoefOut_34(CoefOut_34),  // sfix18_En17
                                                    .CoefOut_35(CoefOut_35),  // sfix18_En17
                                                    .CoefOut_36(CoefOut_36),  // sfix18_En17
                                                    .CoefOut_37(CoefOut_37),  // sfix18_En17
                                                    .CoefOut_38(CoefOut_38),  // sfix18_En17
                                                    .CoefOut_39(CoefOut_39),  // sfix18_En17
                                                    .CoefOut_40(CoefOut_40)  // sfix18_En17
                                                    );

  always @(posedge clk or posedge reset)
    begin : intdelay_3_process
      if (reset == 1'b1) begin
        dinReg2Vld <= 1'b0;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            dinReg2Vld <= 1'b0;
          end
          else begin
            dinReg2Vld <= dinRegVld;
          end
        end
      end
    end



  dvbs2hdlTransmitterCore_subFilter u_subFilter_1_re (.clk(clk),
                                                      .reset(reset),
                                                      .enb_1_2_0(enb_1_2_0),
                                                      .dinReg2_0_re(dinReg2_0_re),  // sfix18_En16
                                                      .coefIn_0(CoefOut_0),  // sfix18_En17
                                                      .coefIn_1(CoefOut_1),  // sfix18_En17
                                                      .coefIn_2(CoefOut_2),  // sfix18_En17
                                                      .coefIn_3(CoefOut_3),  // sfix18_En17
                                                      .coefIn_4(CoefOut_4),  // sfix18_En17
                                                      .coefIn_5(CoefOut_5),  // sfix18_En17
                                                      .coefIn_6(CoefOut_6),  // sfix18_En17
                                                      .coefIn_7(CoefOut_7),  // sfix18_En17
                                                      .coefIn_8(CoefOut_8),  // sfix18_En17
                                                      .coefIn_9(CoefOut_9),  // sfix18_En17
                                                      .coefIn_10(CoefOut_10),  // sfix18_En17
                                                      .coefIn_11(CoefOut_11),  // sfix18_En17
                                                      .coefIn_12(CoefOut_12),  // sfix18_En17
                                                      .coefIn_13(CoefOut_13),  // sfix18_En17
                                                      .coefIn_14(CoefOut_14),  // sfix18_En17
                                                      .coefIn_15(CoefOut_15),  // sfix18_En17
                                                      .coefIn_16(CoefOut_16),  // sfix18_En17
                                                      .coefIn_17(CoefOut_17),  // sfix18_En17
                                                      .coefIn_18(CoefOut_18),  // sfix18_En17
                                                      .coefIn_19(CoefOut_19),  // sfix18_En17
                                                      .coefIn_20(CoefOut_20),  // sfix18_En17
                                                      .coefIn_21(CoefOut_21),  // sfix18_En17
                                                      .coefIn_22(CoefOut_22),  // sfix18_En17
                                                      .coefIn_23(CoefOut_23),  // sfix18_En17
                                                      .coefIn_24(CoefOut_24),  // sfix18_En17
                                                      .coefIn_25(CoefOut_25),  // sfix18_En17
                                                      .coefIn_26(CoefOut_26),  // sfix18_En17
                                                      .coefIn_27(CoefOut_27),  // sfix18_En17
                                                      .coefIn_28(CoefOut_28),  // sfix18_En17
                                                      .coefIn_29(CoefOut_29),  // sfix18_En17
                                                      .coefIn_30(CoefOut_30),  // sfix18_En17
                                                      .coefIn_31(CoefOut_31),  // sfix18_En17
                                                      .coefIn_32(CoefOut_32),  // sfix18_En17
                                                      .coefIn_33(CoefOut_33),  // sfix18_En17
                                                      .coefIn_34(CoefOut_34),  // sfix18_En17
                                                      .coefIn_35(CoefOut_35),  // sfix18_En17
                                                      .coefIn_36(CoefOut_36),  // sfix18_En17
                                                      .coefIn_37(CoefOut_37),  // sfix18_En17
                                                      .coefIn_38(CoefOut_38),  // sfix18_En17
                                                      .coefIn_39(CoefOut_39),  // sfix18_En17
                                                      .coefIn_40(CoefOut_40),  // sfix18_En17
                                                      .dinRegVld(dinReg2Vld),
                                                      .syncReset(syncReset),
                                                      .dout_1_re(dout_1_re),  // sfix18_En14
                                                      .doutVld(doutVld)
                                                      );

  assign dataOut_re = dout_1_re;

  always @(posedge clk or posedge reset)
    begin : intdelay_4_process
      if (reset == 1'b1) begin
        dinReg_0_im <= 18'sb000000000000000000;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            dinReg_0_im <= 18'sb000000000000000000;
          end
          else begin
            if (validIn) begin
              dinReg_0_im <= dataIn_im;
            end
          end
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : intdelay_5_process
      if (reset == 1'b1) begin
        dinReg2_0_im <= 18'sb000000000000000000;
      end
      else begin
        if (enb_1_2_0) begin
          if (syncReset == 1'b1) begin
            dinReg2_0_im <= 18'sb000000000000000000;
          end
          else begin
            if (dinRegVld) begin
              dinReg2_0_im <= dinReg_0_im;
            end
          end
        end
      end
    end



  dvbs2hdlTransmitterCore_subFilter u_subFilter_1_im (.clk(clk),
                                                      .reset(reset),
                                                      .enb_1_2_0(enb_1_2_0),
                                                      .dinReg2_0_re(dinReg2_0_im),  // sfix18_En16
                                                      .coefIn_0(CoefOut_0),  // sfix18_En17
                                                      .coefIn_1(CoefOut_1),  // sfix18_En17
                                                      .coefIn_2(CoefOut_2),  // sfix18_En17
                                                      .coefIn_3(CoefOut_3),  // sfix18_En17
                                                      .coefIn_4(CoefOut_4),  // sfix18_En17
                                                      .coefIn_5(CoefOut_5),  // sfix18_En17
                                                      .coefIn_6(CoefOut_6),  // sfix18_En17
                                                      .coefIn_7(CoefOut_7),  // sfix18_En17
                                                      .coefIn_8(CoefOut_8),  // sfix18_En17
                                                      .coefIn_9(CoefOut_9),  // sfix18_En17
                                                      .coefIn_10(CoefOut_10),  // sfix18_En17
                                                      .coefIn_11(CoefOut_11),  // sfix18_En17
                                                      .coefIn_12(CoefOut_12),  // sfix18_En17
                                                      .coefIn_13(CoefOut_13),  // sfix18_En17
                                                      .coefIn_14(CoefOut_14),  // sfix18_En17
                                                      .coefIn_15(CoefOut_15),  // sfix18_En17
                                                      .coefIn_16(CoefOut_16),  // sfix18_En17
                                                      .coefIn_17(CoefOut_17),  // sfix18_En17
                                                      .coefIn_18(CoefOut_18),  // sfix18_En17
                                                      .coefIn_19(CoefOut_19),  // sfix18_En17
                                                      .coefIn_20(CoefOut_20),  // sfix18_En17
                                                      .coefIn_21(CoefOut_21),  // sfix18_En17
                                                      .coefIn_22(CoefOut_22),  // sfix18_En17
                                                      .coefIn_23(CoefOut_23),  // sfix18_En17
                                                      .coefIn_24(CoefOut_24),  // sfix18_En17
                                                      .coefIn_25(CoefOut_25),  // sfix18_En17
                                                      .coefIn_26(CoefOut_26),  // sfix18_En17
                                                      .coefIn_27(CoefOut_27),  // sfix18_En17
                                                      .coefIn_28(CoefOut_28),  // sfix18_En17
                                                      .coefIn_29(CoefOut_29),  // sfix18_En17
                                                      .coefIn_30(CoefOut_30),  // sfix18_En17
                                                      .coefIn_31(CoefOut_31),  // sfix18_En17
                                                      .coefIn_32(CoefOut_32),  // sfix18_En17
                                                      .coefIn_33(CoefOut_33),  // sfix18_En17
                                                      .coefIn_34(CoefOut_34),  // sfix18_En17
                                                      .coefIn_35(CoefOut_35),  // sfix18_En17
                                                      .coefIn_36(CoefOut_36),  // sfix18_En17
                                                      .coefIn_37(CoefOut_37),  // sfix18_En17
                                                      .coefIn_38(CoefOut_38),  // sfix18_En17
                                                      .coefIn_39(CoefOut_39),  // sfix18_En17
                                                      .coefIn_40(CoefOut_40),  // sfix18_En17
                                                      .dinRegVld(dinReg2Vld),
                                                      .syncReset(syncReset),
                                                      .dout_1_re(dout_1_im),  // sfix18_En14
                                                      .doutVld(doutVlddeadOutdeadOut)
                                                      );

  assign dataOut_im = dout_1_im;

  assign validOut = doutVld;

endmodule  // dvbs2hdlTransmitterCore_Filter

