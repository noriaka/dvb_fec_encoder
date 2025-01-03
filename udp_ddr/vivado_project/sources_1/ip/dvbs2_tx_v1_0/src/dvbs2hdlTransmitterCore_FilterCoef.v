// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_FilterCoef.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_FilterCoef
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/RRC Transmit Filter/Discrete FIR Filter/Filter/FilterCoef
// Hierarchy Level: 6
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_FilterCoef
          (CoefOut_0,
           CoefOut_1,
           CoefOut_2,
           CoefOut_3,
           CoefOut_4,
           CoefOut_5,
           CoefOut_6,
           CoefOut_7,
           CoefOut_8,
           CoefOut_9,
           CoefOut_10,
           CoefOut_11,
           CoefOut_12,
           CoefOut_13,
           CoefOut_14,
           CoefOut_15,
           CoefOut_16,
           CoefOut_17,
           CoefOut_18,
           CoefOut_19,
           CoefOut_20,
           CoefOut_21,
           CoefOut_22,
           CoefOut_23,
           CoefOut_24,
           CoefOut_25,
           CoefOut_26,
           CoefOut_27,
           CoefOut_28,
           CoefOut_29,
           CoefOut_30,
           CoefOut_31,
           CoefOut_32,
           CoefOut_33,
           CoefOut_34,
           CoefOut_35,
           CoefOut_36,
           CoefOut_37,
           CoefOut_38,
           CoefOut_39,
           CoefOut_40);


  output  signed [17:0] CoefOut_0;  // sfix18_En17
  output  signed [17:0] CoefOut_1;  // sfix18_En17
  output  signed [17:0] CoefOut_2;  // sfix18_En17
  output  signed [17:0] CoefOut_3;  // sfix18_En17
  output  signed [17:0] CoefOut_4;  // sfix18_En17
  output  signed [17:0] CoefOut_5;  // sfix18_En17
  output  signed [17:0] CoefOut_6;  // sfix18_En17
  output  signed [17:0] CoefOut_7;  // sfix18_En17
  output  signed [17:0] CoefOut_8;  // sfix18_En17
  output  signed [17:0] CoefOut_9;  // sfix18_En17
  output  signed [17:0] CoefOut_10;  // sfix18_En17
  output  signed [17:0] CoefOut_11;  // sfix18_En17
  output  signed [17:0] CoefOut_12;  // sfix18_En17
  output  signed [17:0] CoefOut_13;  // sfix18_En17
  output  signed [17:0] CoefOut_14;  // sfix18_En17
  output  signed [17:0] CoefOut_15;  // sfix18_En17
  output  signed [17:0] CoefOut_16;  // sfix18_En17
  output  signed [17:0] CoefOut_17;  // sfix18_En17
  output  signed [17:0] CoefOut_18;  // sfix18_En17
  output  signed [17:0] CoefOut_19;  // sfix18_En17
  output  signed [17:0] CoefOut_20;  // sfix18_En17
  output  signed [17:0] CoefOut_21;  // sfix18_En17
  output  signed [17:0] CoefOut_22;  // sfix18_En17
  output  signed [17:0] CoefOut_23;  // sfix18_En17
  output  signed [17:0] CoefOut_24;  // sfix18_En17
  output  signed [17:0] CoefOut_25;  // sfix18_En17
  output  signed [17:0] CoefOut_26;  // sfix18_En17
  output  signed [17:0] CoefOut_27;  // sfix18_En17
  output  signed [17:0] CoefOut_28;  // sfix18_En17
  output  signed [17:0] CoefOut_29;  // sfix18_En17
  output  signed [17:0] CoefOut_30;  // sfix18_En17
  output  signed [17:0] CoefOut_31;  // sfix18_En17
  output  signed [17:0] CoefOut_32;  // sfix18_En17
  output  signed [17:0] CoefOut_33;  // sfix18_En17
  output  signed [17:0] CoefOut_34;  // sfix18_En17
  output  signed [17:0] CoefOut_35;  // sfix18_En17
  output  signed [17:0] CoefOut_36;  // sfix18_En17
  output  signed [17:0] CoefOut_37;  // sfix18_En17
  output  signed [17:0] CoefOut_38;  // sfix18_En17
  output  signed [17:0] CoefOut_39;  // sfix18_En17
  output  signed [17:0] CoefOut_40;  // sfix18_En17


  wire signed [17:0] CoefData;  // sfix18_En17
  wire signed [17:0] CoefData_1;  // sfix18_En17
  wire signed [17:0] CoefData_2;  // sfix18_En17
  wire signed [17:0] CoefData_3;  // sfix18_En17
  wire signed [17:0] CoefData_4;  // sfix18_En17
  wire signed [17:0] CoefData_5;  // sfix18_En17
  wire signed [17:0] CoefData_6;  // sfix18_En17
  wire signed [17:0] CoefData_7;  // sfix18_En17
  wire signed [17:0] CoefData_8;  // sfix18_En17
  wire signed [17:0] CoefData_9;  // sfix18_En17
  wire signed [17:0] CoefData_10;  // sfix18_En17
  wire signed [17:0] CoefData_11;  // sfix18_En17
  wire signed [17:0] CoefData_12;  // sfix18_En17
  wire signed [17:0] CoefData_13;  // sfix18_En17
  wire signed [17:0] CoefData_14;  // sfix18_En17
  wire signed [17:0] CoefData_15;  // sfix18_En17
  wire signed [17:0] CoefData_16;  // sfix18_En17
  wire signed [17:0] CoefData_17;  // sfix18_En17
  wire signed [17:0] CoefData_18;  // sfix18_En17
  wire signed [17:0] CoefData_19;  // sfix18_En17
  wire signed [17:0] CoefData_20;  // sfix18_En17
  wire signed [17:0] CoefData_21;  // sfix18_En17
  wire signed [17:0] CoefData_22;  // sfix18_En17
  wire signed [17:0] CoefData_23;  // sfix18_En17
  wire signed [17:0] CoefData_24;  // sfix18_En17
  wire signed [17:0] CoefData_25;  // sfix18_En17
  wire signed [17:0] CoefData_26;  // sfix18_En17
  wire signed [17:0] CoefData_27;  // sfix18_En17
  wire signed [17:0] CoefData_28;  // sfix18_En17
  wire signed [17:0] CoefData_29;  // sfix18_En17
  wire signed [17:0] CoefData_30;  // sfix18_En17
  wire signed [17:0] CoefData_31;  // sfix18_En17
  wire signed [17:0] CoefData_32;  // sfix18_En17
  wire signed [17:0] CoefData_33;  // sfix18_En17
  wire signed [17:0] CoefData_34;  // sfix18_En17
  wire signed [17:0] CoefData_35;  // sfix18_En17
  wire signed [17:0] CoefData_36;  // sfix18_En17
  wire signed [17:0] CoefData_37;  // sfix18_En17
  wire signed [17:0] CoefData_38;  // sfix18_En17
  wire signed [17:0] CoefData_39;  // sfix18_En17
  wire signed [17:0] CoefData_40;  // sfix18_En17


  // CoefReg_1
  assign CoefData = 18'sb000000000111101100;



  assign CoefOut_0 = CoefData;

  // CoefReg_2
  assign CoefData_1 = 18'sb111111111101100100;



  assign CoefOut_1 = CoefData_1;

  // CoefReg_3
  assign CoefData_2 = 18'sb111111110100000110;



  assign CoefOut_2 = CoefData_2;

  // CoefReg_4
  assign CoefData_3 = 18'sb111111110101011111;



  assign CoefOut_3 = CoefData_3;

  // CoefReg_5
  assign CoefData_4 = 18'sb000000000010000110;



  assign CoefOut_4 = CoefData_4;

  // CoefReg_6
  assign CoefData_5 = 18'sb000000001101101001;



  assign CoefOut_5 = CoefData_5;

  // CoefReg_7
  assign CoefData_6 = 18'sb000000001001110011;



  assign CoefOut_6 = CoefData_6;

  // CoefReg_8
  assign CoefData_7 = 18'sb111111110110001110;



  assign CoefOut_7 = CoefData_7;

  // CoefReg_9
  assign CoefData_8 = 18'sb111111100101111100;



  assign CoefOut_8 = CoefData_8;

  // CoefReg_10
  assign CoefData_9 = 18'sb111111110000111000;



  assign CoefOut_9 = CoefData_9;

  // CoefReg_11
  assign CoefData_10 = 18'sb000000011010001111;



  assign CoefOut_10 = CoefData_10;

  // CoefReg_12
  assign CoefData_11 = 18'sb000001000010111011;



  assign CoefOut_11 = CoefData_11;

  // CoefReg_13
  assign CoefData_12 = 18'sb000000111010100000;



  assign CoefOut_12 = CoefData_12;

  // CoefReg_14
  assign CoefData_13 = 18'sb111111101001011001;



  assign CoefOut_13 = CoefData_13;

  // CoefReg_15
  assign CoefData_14 = 18'sb111101110101100101;



  assign CoefOut_14 = CoefData_14;

  // CoefReg_16
  assign CoefData_15 = 18'sb111100111110110101;



  assign CoefOut_15 = CoefData_15;

  // CoefReg_17
  assign CoefData_16 = 18'sb111110101001010001;



  assign CoefOut_16 = CoefData_16;

  // CoefReg_18
  assign CoefData_17 = 18'sb000011010011110110;



  assign CoefOut_17 = CoefData_17;

  // CoefReg_19
  assign CoefData_18 = 18'sb001001101110011010;



  assign CoefOut_18 = CoefData_18;

  // CoefReg_20
  assign CoefData_19 = 18'sb001111010100001011;



  assign CoefOut_19 = CoefData_19;

  // CoefReg_21
  assign CoefData_20 = 18'sb010001100010000001;



  assign CoefOut_20 = CoefData_20;

  // CoefReg_22
  assign CoefData_21 = 18'sb001111010100001011;



  assign CoefOut_21 = CoefData_21;

  // CoefReg_23
  assign CoefData_22 = 18'sb001001101110011010;



  assign CoefOut_22 = CoefData_22;

  // CoefReg_24
  assign CoefData_23 = 18'sb000011010011110110;



  assign CoefOut_23 = CoefData_23;

  // CoefReg_25
  assign CoefData_24 = 18'sb111110101001010001;



  assign CoefOut_24 = CoefData_24;

  // CoefReg_26
  assign CoefData_25 = 18'sb111100111110110101;



  assign CoefOut_25 = CoefData_25;

  // CoefReg_27
  assign CoefData_26 = 18'sb111101110101100101;



  assign CoefOut_26 = CoefData_26;

  // CoefReg_28
  assign CoefData_27 = 18'sb111111101001011001;



  assign CoefOut_27 = CoefData_27;

  // CoefReg_29
  assign CoefData_28 = 18'sb000000111010100000;



  assign CoefOut_28 = CoefData_28;

  // CoefReg_30
  assign CoefData_29 = 18'sb000001000010111011;



  assign CoefOut_29 = CoefData_29;

  // CoefReg_31
  assign CoefData_30 = 18'sb000000011010001111;



  assign CoefOut_30 = CoefData_30;

  // CoefReg_32
  assign CoefData_31 = 18'sb111111110000111000;



  assign CoefOut_31 = CoefData_31;

  // CoefReg_33
  assign CoefData_32 = 18'sb111111100101111100;



  assign CoefOut_32 = CoefData_32;

  // CoefReg_34
  assign CoefData_33 = 18'sb111111110110001110;



  assign CoefOut_33 = CoefData_33;

  // CoefReg_35
  assign CoefData_34 = 18'sb000000001001110011;



  assign CoefOut_34 = CoefData_34;

  // CoefReg_36
  assign CoefData_35 = 18'sb000000001101101001;



  assign CoefOut_35 = CoefData_35;

  // CoefReg_37
  assign CoefData_36 = 18'sb000000000010000110;



  assign CoefOut_36 = CoefData_36;

  // CoefReg_38
  assign CoefData_37 = 18'sb111111110101011111;



  assign CoefOut_37 = CoefData_37;

  // CoefReg_39
  assign CoefData_38 = 18'sb111111110100000110;



  assign CoefOut_38 = CoefData_38;

  // CoefReg_40
  assign CoefData_39 = 18'sb111111111101100100;



  assign CoefOut_39 = CoefData_39;

  // CoefReg_41
  assign CoefData_40 = 18'sb000000000111101100;



  assign CoefOut_40 = CoefData_40;

endmodule  // dvbs2hdlTransmitterCore_FilterCoef

