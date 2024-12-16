// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_ConvertToMux.v
// Created: 2024-01-10 13:49:58
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_ConvertToMux
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/FEC Encoder/DVB-S2 LDPC Encoder/Parity RAM/ConvertToMux
// Hierarchy Level: 6
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_ConvertToMux
          (clk,
           reset,
           enb,
           u1,
           u2,
           u3,
           u4,
           y1_0,
           y1_1,
           y1_2,
           y1_3,
           y1_4,
           y1_5,
           y1_6,
           y1_7,
           y1_8,
           y1_9,
           y1_10,
           y1_11,
           y1_12,
           y1_13,
           y1_14,
           y1_15,
           y1_16,
           y1_17,
           y1_18,
           y1_19,
           y1_20,
           y1_21,
           y1_22,
           y1_23,
           y1_24,
           y1_25,
           y1_26,
           y1_27,
           y1_28,
           y1_29,
           y1_30,
           y1_31,
           y1_32,
           y1_33,
           y1_34,
           y1_35,
           y1_36,
           y1_37,
           y1_38,
           y1_39,
           y1_40,
           y1_41,
           y1_42,
           y1_43,
           y1_44,
           y1_45,
           y1_46,
           y1_47,
           y1_48,
           y1_49,
           y1_50,
           y1_51,
           y1_52,
           y1_53,
           y1_54,
           y1_55,
           y1_56,
           y1_57,
           y1_58,
           y1_59,
           y1_60,
           y1_61,
           y1_62,
           y1_63,
           y1_64,
           y1_65,
           y1_66,
           y1_67,
           y1_68,
           y1_69,
           y1_70,
           y1_71,
           y1_72,
           y1_73,
           y1_74,
           y1_75,
           y1_76,
           y1_77,
           y1_78,
           y1_79,
           y1_80,
           y1_81,
           y1_82,
           y1_83,
           y1_84,
           y1_85,
           y1_86,
           y1_87,
           y1_88,
           y1_89,
           y2_0,
           y2_1,
           y2_2,
           y2_3,
           y2_4,
           y2_5,
           y2_6,
           y2_7,
           y2_8,
           y2_9,
           y2_10,
           y2_11,
           y2_12,
           y2_13,
           y2_14,
           y2_15,
           y2_16,
           y2_17,
           y2_18,
           y2_19,
           y2_20,
           y2_21,
           y2_22,
           y2_23,
           y2_24,
           y2_25,
           y2_26,
           y2_27,
           y2_28,
           y2_29,
           y2_30,
           y2_31,
           y2_32,
           y2_33,
           y2_34,
           y2_35,
           y2_36,
           y2_37,
           y2_38,
           y2_39,
           y2_40,
           y2_41,
           y2_42,
           y2_43,
           y2_44,
           y2_45,
           y2_46,
           y2_47,
           y2_48,
           y2_49,
           y2_50,
           y2_51,
           y2_52,
           y2_53,
           y2_54,
           y2_55,
           y2_56,
           y2_57,
           y2_58,
           y2_59,
           y2_60,
           y2_61,
           y2_62,
           y2_63,
           y2_64,
           y2_65,
           y2_66,
           y2_67,
           y2_68,
           y2_69,
           y2_70,
           y2_71,
           y2_72,
           y2_73,
           y2_74,
           y2_75,
           y2_76,
           y2_77,
           y2_78,
           y2_79,
           y2_80,
           y2_81,
           y2_82,
           y2_83,
           y2_84,
           y2_85,
           y2_86,
           y2_87,
           y2_88,
           y2_89,
           y3_0,
           y3_1,
           y3_2,
           y3_3,
           y3_4,
           y3_5,
           y3_6,
           y3_7,
           y3_8,
           y3_9,
           y3_10,
           y3_11,
           y3_12,
           y3_13,
           y3_14,
           y3_15,
           y3_16,
           y3_17,
           y3_18,
           y3_19,
           y3_20,
           y3_21,
           y3_22,
           y3_23,
           y3_24,
           y3_25,
           y3_26,
           y3_27,
           y3_28,
           y3_29,
           y3_30,
           y3_31,
           y3_32,
           y3_33,
           y3_34,
           y3_35,
           y3_36,
           y3_37,
           y3_38,
           y3_39,
           y3_40,
           y3_41,
           y3_42,
           y3_43,
           y3_44,
           y3_45,
           y3_46,
           y3_47,
           y3_48,
           y3_49,
           y3_50,
           y3_51,
           y3_52,
           y3_53,
           y3_54,
           y3_55,
           y3_56,
           y3_57,
           y3_58,
           y3_59,
           y3_60,
           y3_61,
           y3_62,
           y3_63,
           y3_64,
           y3_65,
           y3_66,
           y3_67,
           y3_68,
           y3_69,
           y3_70,
           y3_71,
           y3_72,
           y3_73,
           y3_74,
           y3_75,
           y3_76,
           y3_77,
           y3_78,
           y3_79,
           y3_80,
           y3_81,
           y3_82,
           y3_83,
           y3_84,
           y3_85,
           y3_86,
           y3_87,
           y3_88,
           y3_89,
           y4_0,
           y4_1,
           y4_2,
           y4_3,
           y4_4,
           y4_5,
           y4_6,
           y4_7,
           y4_8,
           y4_9,
           y4_10,
           y4_11,
           y4_12,
           y4_13,
           y4_14,
           y4_15,
           y4_16,
           y4_17,
           y4_18,
           y4_19,
           y4_20,
           y4_21,
           y4_22,
           y4_23,
           y4_24,
           y4_25,
           y4_26,
           y4_27,
           y4_28,
           y4_29,
           y4_30,
           y4_31,
           y4_32,
           y4_33,
           y4_34,
           y4_35,
           y4_36,
           y4_37,
           y4_38,
           y4_39,
           y4_40,
           y4_41,
           y4_42,
           y4_43,
           y4_44,
           y4_45,
           y4_46,
           y4_47,
           y4_48,
           y4_49,
           y4_50,
           y4_51,
           y4_52,
           y4_53,
           y4_54,
           y4_55,
           y4_56,
           y4_57,
           y4_58,
           y4_59,
           y4_60,
           y4_61,
           y4_62,
           y4_63,
           y4_64,
           y4_65,
           y4_66,
           y4_67,
           y4_68,
           y4_69,
           y4_70,
           y4_71,
           y4_72,
           y4_73,
           y4_74,
           y4_75,
           y4_76,
           y4_77,
           y4_78,
           y4_79,
           y4_80,
           y4_81,
           y4_82,
           y4_83,
           y4_84,
           y4_85,
           y4_86,
           y4_87,
           y4_88,
           y4_89);


  input   clk;
  input   reset;
  input   enb;
  input   [89:0] u1;  // ufix90
  input   [89:0] u2;  // ufix90
  input   [89:0] u3;  // ufix90
  input   [89:0] u4;  // ufix90
  output  y1_0;  // boolean
  output  y1_1;  // boolean
  output  y1_2;  // boolean
  output  y1_3;  // boolean
  output  y1_4;  // boolean
  output  y1_5;  // boolean
  output  y1_6;  // boolean
  output  y1_7;  // boolean
  output  y1_8;  // boolean
  output  y1_9;  // boolean
  output  y1_10;  // boolean
  output  y1_11;  // boolean
  output  y1_12;  // boolean
  output  y1_13;  // boolean
  output  y1_14;  // boolean
  output  y1_15;  // boolean
  output  y1_16;  // boolean
  output  y1_17;  // boolean
  output  y1_18;  // boolean
  output  y1_19;  // boolean
  output  y1_20;  // boolean
  output  y1_21;  // boolean
  output  y1_22;  // boolean
  output  y1_23;  // boolean
  output  y1_24;  // boolean
  output  y1_25;  // boolean
  output  y1_26;  // boolean
  output  y1_27;  // boolean
  output  y1_28;  // boolean
  output  y1_29;  // boolean
  output  y1_30;  // boolean
  output  y1_31;  // boolean
  output  y1_32;  // boolean
  output  y1_33;  // boolean
  output  y1_34;  // boolean
  output  y1_35;  // boolean
  output  y1_36;  // boolean
  output  y1_37;  // boolean
  output  y1_38;  // boolean
  output  y1_39;  // boolean
  output  y1_40;  // boolean
  output  y1_41;  // boolean
  output  y1_42;  // boolean
  output  y1_43;  // boolean
  output  y1_44;  // boolean
  output  y1_45;  // boolean
  output  y1_46;  // boolean
  output  y1_47;  // boolean
  output  y1_48;  // boolean
  output  y1_49;  // boolean
  output  y1_50;  // boolean
  output  y1_51;  // boolean
  output  y1_52;  // boolean
  output  y1_53;  // boolean
  output  y1_54;  // boolean
  output  y1_55;  // boolean
  output  y1_56;  // boolean
  output  y1_57;  // boolean
  output  y1_58;  // boolean
  output  y1_59;  // boolean
  output  y1_60;  // boolean
  output  y1_61;  // boolean
  output  y1_62;  // boolean
  output  y1_63;  // boolean
  output  y1_64;  // boolean
  output  y1_65;  // boolean
  output  y1_66;  // boolean
  output  y1_67;  // boolean
  output  y1_68;  // boolean
  output  y1_69;  // boolean
  output  y1_70;  // boolean
  output  y1_71;  // boolean
  output  y1_72;  // boolean
  output  y1_73;  // boolean
  output  y1_74;  // boolean
  output  y1_75;  // boolean
  output  y1_76;  // boolean
  output  y1_77;  // boolean
  output  y1_78;  // boolean
  output  y1_79;  // boolean
  output  y1_80;  // boolean
  output  y1_81;  // boolean
  output  y1_82;  // boolean
  output  y1_83;  // boolean
  output  y1_84;  // boolean
  output  y1_85;  // boolean
  output  y1_86;  // boolean
  output  y1_87;  // boolean
  output  y1_88;  // boolean
  output  y1_89;  // boolean
  output  y2_0;  // boolean
  output  y2_1;  // boolean
  output  y2_2;  // boolean
  output  y2_3;  // boolean
  output  y2_4;  // boolean
  output  y2_5;  // boolean
  output  y2_6;  // boolean
  output  y2_7;  // boolean
  output  y2_8;  // boolean
  output  y2_9;  // boolean
  output  y2_10;  // boolean
  output  y2_11;  // boolean
  output  y2_12;  // boolean
  output  y2_13;  // boolean
  output  y2_14;  // boolean
  output  y2_15;  // boolean
  output  y2_16;  // boolean
  output  y2_17;  // boolean
  output  y2_18;  // boolean
  output  y2_19;  // boolean
  output  y2_20;  // boolean
  output  y2_21;  // boolean
  output  y2_22;  // boolean
  output  y2_23;  // boolean
  output  y2_24;  // boolean
  output  y2_25;  // boolean
  output  y2_26;  // boolean
  output  y2_27;  // boolean
  output  y2_28;  // boolean
  output  y2_29;  // boolean
  output  y2_30;  // boolean
  output  y2_31;  // boolean
  output  y2_32;  // boolean
  output  y2_33;  // boolean
  output  y2_34;  // boolean
  output  y2_35;  // boolean
  output  y2_36;  // boolean
  output  y2_37;  // boolean
  output  y2_38;  // boolean
  output  y2_39;  // boolean
  output  y2_40;  // boolean
  output  y2_41;  // boolean
  output  y2_42;  // boolean
  output  y2_43;  // boolean
  output  y2_44;  // boolean
  output  y2_45;  // boolean
  output  y2_46;  // boolean
  output  y2_47;  // boolean
  output  y2_48;  // boolean
  output  y2_49;  // boolean
  output  y2_50;  // boolean
  output  y2_51;  // boolean
  output  y2_52;  // boolean
  output  y2_53;  // boolean
  output  y2_54;  // boolean
  output  y2_55;  // boolean
  output  y2_56;  // boolean
  output  y2_57;  // boolean
  output  y2_58;  // boolean
  output  y2_59;  // boolean
  output  y2_60;  // boolean
  output  y2_61;  // boolean
  output  y2_62;  // boolean
  output  y2_63;  // boolean
  output  y2_64;  // boolean
  output  y2_65;  // boolean
  output  y2_66;  // boolean
  output  y2_67;  // boolean
  output  y2_68;  // boolean
  output  y2_69;  // boolean
  output  y2_70;  // boolean
  output  y2_71;  // boolean
  output  y2_72;  // boolean
  output  y2_73;  // boolean
  output  y2_74;  // boolean
  output  y2_75;  // boolean
  output  y2_76;  // boolean
  output  y2_77;  // boolean
  output  y2_78;  // boolean
  output  y2_79;  // boolean
  output  y2_80;  // boolean
  output  y2_81;  // boolean
  output  y2_82;  // boolean
  output  y2_83;  // boolean
  output  y2_84;  // boolean
  output  y2_85;  // boolean
  output  y2_86;  // boolean
  output  y2_87;  // boolean
  output  y2_88;  // boolean
  output  y2_89;  // boolean
  output  y3_0;  // boolean
  output  y3_1;  // boolean
  output  y3_2;  // boolean
  output  y3_3;  // boolean
  output  y3_4;  // boolean
  output  y3_5;  // boolean
  output  y3_6;  // boolean
  output  y3_7;  // boolean
  output  y3_8;  // boolean
  output  y3_9;  // boolean
  output  y3_10;  // boolean
  output  y3_11;  // boolean
  output  y3_12;  // boolean
  output  y3_13;  // boolean
  output  y3_14;  // boolean
  output  y3_15;  // boolean
  output  y3_16;  // boolean
  output  y3_17;  // boolean
  output  y3_18;  // boolean
  output  y3_19;  // boolean
  output  y3_20;  // boolean
  output  y3_21;  // boolean
  output  y3_22;  // boolean
  output  y3_23;  // boolean
  output  y3_24;  // boolean
  output  y3_25;  // boolean
  output  y3_26;  // boolean
  output  y3_27;  // boolean
  output  y3_28;  // boolean
  output  y3_29;  // boolean
  output  y3_30;  // boolean
  output  y3_31;  // boolean
  output  y3_32;  // boolean
  output  y3_33;  // boolean
  output  y3_34;  // boolean
  output  y3_35;  // boolean
  output  y3_36;  // boolean
  output  y3_37;  // boolean
  output  y3_38;  // boolean
  output  y3_39;  // boolean
  output  y3_40;  // boolean
  output  y3_41;  // boolean
  output  y3_42;  // boolean
  output  y3_43;  // boolean
  output  y3_44;  // boolean
  output  y3_45;  // boolean
  output  y3_46;  // boolean
  output  y3_47;  // boolean
  output  y3_48;  // boolean
  output  y3_49;  // boolean
  output  y3_50;  // boolean
  output  y3_51;  // boolean
  output  y3_52;  // boolean
  output  y3_53;  // boolean
  output  y3_54;  // boolean
  output  y3_55;  // boolean
  output  y3_56;  // boolean
  output  y3_57;  // boolean
  output  y3_58;  // boolean
  output  y3_59;  // boolean
  output  y3_60;  // boolean
  output  y3_61;  // boolean
  output  y3_62;  // boolean
  output  y3_63;  // boolean
  output  y3_64;  // boolean
  output  y3_65;  // boolean
  output  y3_66;  // boolean
  output  y3_67;  // boolean
  output  y3_68;  // boolean
  output  y3_69;  // boolean
  output  y3_70;  // boolean
  output  y3_71;  // boolean
  output  y3_72;  // boolean
  output  y3_73;  // boolean
  output  y3_74;  // boolean
  output  y3_75;  // boolean
  output  y3_76;  // boolean
  output  y3_77;  // boolean
  output  y3_78;  // boolean
  output  y3_79;  // boolean
  output  y3_80;  // boolean
  output  y3_81;  // boolean
  output  y3_82;  // boolean
  output  y3_83;  // boolean
  output  y3_84;  // boolean
  output  y3_85;  // boolean
  output  y3_86;  // boolean
  output  y3_87;  // boolean
  output  y3_88;  // boolean
  output  y3_89;  // boolean
  output  y4_0;  // boolean
  output  y4_1;  // boolean
  output  y4_2;  // boolean
  output  y4_3;  // boolean
  output  y4_4;  // boolean
  output  y4_5;  // boolean
  output  y4_6;  // boolean
  output  y4_7;  // boolean
  output  y4_8;  // boolean
  output  y4_9;  // boolean
  output  y4_10;  // boolean
  output  y4_11;  // boolean
  output  y4_12;  // boolean
  output  y4_13;  // boolean
  output  y4_14;  // boolean
  output  y4_15;  // boolean
  output  y4_16;  // boolean
  output  y4_17;  // boolean
  output  y4_18;  // boolean
  output  y4_19;  // boolean
  output  y4_20;  // boolean
  output  y4_21;  // boolean
  output  y4_22;  // boolean
  output  y4_23;  // boolean
  output  y4_24;  // boolean
  output  y4_25;  // boolean
  output  y4_26;  // boolean
  output  y4_27;  // boolean
  output  y4_28;  // boolean
  output  y4_29;  // boolean
  output  y4_30;  // boolean
  output  y4_31;  // boolean
  output  y4_32;  // boolean
  output  y4_33;  // boolean
  output  y4_34;  // boolean
  output  y4_35;  // boolean
  output  y4_36;  // boolean
  output  y4_37;  // boolean
  output  y4_38;  // boolean
  output  y4_39;  // boolean
  output  y4_40;  // boolean
  output  y4_41;  // boolean
  output  y4_42;  // boolean
  output  y4_43;  // boolean
  output  y4_44;  // boolean
  output  y4_45;  // boolean
  output  y4_46;  // boolean
  output  y4_47;  // boolean
  output  y4_48;  // boolean
  output  y4_49;  // boolean
  output  y4_50;  // boolean
  output  y4_51;  // boolean
  output  y4_52;  // boolean
  output  y4_53;  // boolean
  output  y4_54;  // boolean
  output  y4_55;  // boolean
  output  y4_56;  // boolean
  output  y4_57;  // boolean
  output  y4_58;  // boolean
  output  y4_59;  // boolean
  output  y4_60;  // boolean
  output  y4_61;  // boolean
  output  y4_62;  // boolean
  output  y4_63;  // boolean
  output  y4_64;  // boolean
  output  y4_65;  // boolean
  output  y4_66;  // boolean
  output  y4_67;  // boolean
  output  y4_68;  // boolean
  output  y4_69;  // boolean
  output  y4_70;  // boolean
  output  y4_71;  // boolean
  output  y4_72;  // boolean
  output  y4_73;  // boolean
  output  y4_74;  // boolean
  output  y4_75;  // boolean
  output  y4_76;  // boolean
  output  y4_77;  // boolean
  output  y4_78;  // boolean
  output  y4_79;  // boolean
  output  y4_80;  // boolean
  output  y4_81;  // boolean
  output  y4_82;  // boolean
  output  y4_83;  // boolean
  output  y4_84;  // boolean
  output  y4_85;  // boolean
  output  y4_86;  // boolean
  output  y4_87;  // boolean
  output  y4_88;  // boolean
  output  y4_89;  // boolean


  reg  [89:0] y1;  // boolean [90]
  reg  [89:0] y2;  // boolean [90]
  reg  [89:0] y3;  // boolean [90]
  reg  [89:0] y4;  // boolean [90]
  reg  [89:0] mux1;  // boolean [90]
  reg  [89:0] mux2;  // boolean [90]
  reg  [89:0] mux3;  // boolean [90]
  reg  [89:0] mux4;  // boolean [90]
  reg  [89:0] mux1_next;  // boolean [90]
  reg  [89:0] mux2_next;  // boolean [90]
  reg  [89:0] mux3_next;  // boolean [90]
  reg  [89:0] mux4_next;  // boolean [90]
  reg signed [31:0] i;  // int32
  reg [7:0] bit_idx;  // uint8
  reg [7:0] bit_idx_0;  // uint8
  reg [7:0] bit_idx_1;  // uint8
  reg [7:0] bit_idx_2;  // uint8
  reg  slice_temp;
  reg  slice_temp_0;
  reg  slice_temp_1;
  reg  slice_temp_2;
  reg signed [31:0] sub_temp [0:89];  // int32 [90]
  reg signed [31:0] sub_temp_0 [0:89];  // int32 [90]
  reg signed [31:0] sub_temp_1 [0:89];  // int32 [90]
  reg signed [31:0] sub_temp_2 [0:89];  // int32 [90]
  reg signed [31:0] t_0;  // int32
  reg signed [31:0] t_1;  // int32


  always @(posedge clk or posedge reset)
    begin : ConvertToMux_process
      if (reset == 1'b1) begin
        for(t_1 = 32'sd0; t_1 <= 32'sd89; t_1 = t_1 + 32'sd1) begin
          mux1[t_1] <= 1'b0;
          mux2[t_1] <= 1'b0;
          mux3[t_1] <= 1'b0;
          mux4[t_1] <= 1'b0;
        end
      end
      else begin
        if (enb) begin
          for(t_0 = 32'sd0; t_0 <= 32'sd89; t_0 = t_0 + 32'sd1) begin
            mux1[t_0] <= mux1_next[t_0];
            mux2[t_0] <= mux2_next[t_0];
            mux3[t_0] <= mux3_next[t_0];
            mux4[t_0] <= mux4_next[t_0];
          end
        end
      end
    end

  always @(u1, u2, u3, u4) begin
    slice_temp_2 = 1'b0;
    slice_temp_1 = 1'b0;
    slice_temp_0 = 1'b0;
    slice_temp = 1'b0;
    bit_idx = 8'd0;
    bit_idx_0 = 8'd0;
    bit_idx_1 = 8'd0;
    bit_idx_2 = 8'd0;

    for(i = 32'sd0; i <= 32'sd89; i = i + 32'sd1) begin
      sub_temp[i] = 32'sd89 - i;
      bit_idx = sub_temp[i][7:0];
      slice_temp = u1[bit_idx];
      sub_temp_0[i] = 32'sd89 - i;
      bit_idx_0 = sub_temp_0[i][7:0];
      slice_temp_0 = u2[bit_idx_0];
      sub_temp_1[i] = 32'sd89 - i;
      bit_idx_1 = sub_temp_1[i][7:0];
      slice_temp_1 = u3[bit_idx_1];
      sub_temp_2[i] = 32'sd89 - i;
      bit_idx_2 = sub_temp_2[i][7:0];
      slice_temp_2 = u4[bit_idx_2];
      y1[i] = slice_temp;
      y2[i] = slice_temp_0;
      y3[i] = slice_temp_1;
      y4[i] = slice_temp_2;
      mux1_next[i] = slice_temp;
      mux2_next[i] = slice_temp_0;
      mux3_next[i] = slice_temp_1;
      mux4_next[i] = slice_temp_2;
    end

  end



  assign y1_0 = y1[0];

  assign y1_1 = y1[1];

  assign y1_2 = y1[2];

  assign y1_3 = y1[3];

  assign y1_4 = y1[4];

  assign y1_5 = y1[5];

  assign y1_6 = y1[6];

  assign y1_7 = y1[7];

  assign y1_8 = y1[8];

  assign y1_9 = y1[9];

  assign y1_10 = y1[10];

  assign y1_11 = y1[11];

  assign y1_12 = y1[12];

  assign y1_13 = y1[13];

  assign y1_14 = y1[14];

  assign y1_15 = y1[15];

  assign y1_16 = y1[16];

  assign y1_17 = y1[17];

  assign y1_18 = y1[18];

  assign y1_19 = y1[19];

  assign y1_20 = y1[20];

  assign y1_21 = y1[21];

  assign y1_22 = y1[22];

  assign y1_23 = y1[23];

  assign y1_24 = y1[24];

  assign y1_25 = y1[25];

  assign y1_26 = y1[26];

  assign y1_27 = y1[27];

  assign y1_28 = y1[28];

  assign y1_29 = y1[29];

  assign y1_30 = y1[30];

  assign y1_31 = y1[31];

  assign y1_32 = y1[32];

  assign y1_33 = y1[33];

  assign y1_34 = y1[34];

  assign y1_35 = y1[35];

  assign y1_36 = y1[36];

  assign y1_37 = y1[37];

  assign y1_38 = y1[38];

  assign y1_39 = y1[39];

  assign y1_40 = y1[40];

  assign y1_41 = y1[41];

  assign y1_42 = y1[42];

  assign y1_43 = y1[43];

  assign y1_44 = y1[44];

  assign y1_45 = y1[45];

  assign y1_46 = y1[46];

  assign y1_47 = y1[47];

  assign y1_48 = y1[48];

  assign y1_49 = y1[49];

  assign y1_50 = y1[50];

  assign y1_51 = y1[51];

  assign y1_52 = y1[52];

  assign y1_53 = y1[53];

  assign y1_54 = y1[54];

  assign y1_55 = y1[55];

  assign y1_56 = y1[56];

  assign y1_57 = y1[57];

  assign y1_58 = y1[58];

  assign y1_59 = y1[59];

  assign y1_60 = y1[60];

  assign y1_61 = y1[61];

  assign y1_62 = y1[62];

  assign y1_63 = y1[63];

  assign y1_64 = y1[64];

  assign y1_65 = y1[65];

  assign y1_66 = y1[66];

  assign y1_67 = y1[67];

  assign y1_68 = y1[68];

  assign y1_69 = y1[69];

  assign y1_70 = y1[70];

  assign y1_71 = y1[71];

  assign y1_72 = y1[72];

  assign y1_73 = y1[73];

  assign y1_74 = y1[74];

  assign y1_75 = y1[75];

  assign y1_76 = y1[76];

  assign y1_77 = y1[77];

  assign y1_78 = y1[78];

  assign y1_79 = y1[79];

  assign y1_80 = y1[80];

  assign y1_81 = y1[81];

  assign y1_82 = y1[82];

  assign y1_83 = y1[83];

  assign y1_84 = y1[84];

  assign y1_85 = y1[85];

  assign y1_86 = y1[86];

  assign y1_87 = y1[87];

  assign y1_88 = y1[88];

  assign y1_89 = y1[89];

  assign y2_0 = y2[0];

  assign y2_1 = y2[1];

  assign y2_2 = y2[2];

  assign y2_3 = y2[3];

  assign y2_4 = y2[4];

  assign y2_5 = y2[5];

  assign y2_6 = y2[6];

  assign y2_7 = y2[7];

  assign y2_8 = y2[8];

  assign y2_9 = y2[9];

  assign y2_10 = y2[10];

  assign y2_11 = y2[11];

  assign y2_12 = y2[12];

  assign y2_13 = y2[13];

  assign y2_14 = y2[14];

  assign y2_15 = y2[15];

  assign y2_16 = y2[16];

  assign y2_17 = y2[17];

  assign y2_18 = y2[18];

  assign y2_19 = y2[19];

  assign y2_20 = y2[20];

  assign y2_21 = y2[21];

  assign y2_22 = y2[22];

  assign y2_23 = y2[23];

  assign y2_24 = y2[24];

  assign y2_25 = y2[25];

  assign y2_26 = y2[26];

  assign y2_27 = y2[27];

  assign y2_28 = y2[28];

  assign y2_29 = y2[29];

  assign y2_30 = y2[30];

  assign y2_31 = y2[31];

  assign y2_32 = y2[32];

  assign y2_33 = y2[33];

  assign y2_34 = y2[34];

  assign y2_35 = y2[35];

  assign y2_36 = y2[36];

  assign y2_37 = y2[37];

  assign y2_38 = y2[38];

  assign y2_39 = y2[39];

  assign y2_40 = y2[40];

  assign y2_41 = y2[41];

  assign y2_42 = y2[42];

  assign y2_43 = y2[43];

  assign y2_44 = y2[44];

  assign y2_45 = y2[45];

  assign y2_46 = y2[46];

  assign y2_47 = y2[47];

  assign y2_48 = y2[48];

  assign y2_49 = y2[49];

  assign y2_50 = y2[50];

  assign y2_51 = y2[51];

  assign y2_52 = y2[52];

  assign y2_53 = y2[53];

  assign y2_54 = y2[54];

  assign y2_55 = y2[55];

  assign y2_56 = y2[56];

  assign y2_57 = y2[57];

  assign y2_58 = y2[58];

  assign y2_59 = y2[59];

  assign y2_60 = y2[60];

  assign y2_61 = y2[61];

  assign y2_62 = y2[62];

  assign y2_63 = y2[63];

  assign y2_64 = y2[64];

  assign y2_65 = y2[65];

  assign y2_66 = y2[66];

  assign y2_67 = y2[67];

  assign y2_68 = y2[68];

  assign y2_69 = y2[69];

  assign y2_70 = y2[70];

  assign y2_71 = y2[71];

  assign y2_72 = y2[72];

  assign y2_73 = y2[73];

  assign y2_74 = y2[74];

  assign y2_75 = y2[75];

  assign y2_76 = y2[76];

  assign y2_77 = y2[77];

  assign y2_78 = y2[78];

  assign y2_79 = y2[79];

  assign y2_80 = y2[80];

  assign y2_81 = y2[81];

  assign y2_82 = y2[82];

  assign y2_83 = y2[83];

  assign y2_84 = y2[84];

  assign y2_85 = y2[85];

  assign y2_86 = y2[86];

  assign y2_87 = y2[87];

  assign y2_88 = y2[88];

  assign y2_89 = y2[89];

  assign y3_0 = y3[0];

  assign y3_1 = y3[1];

  assign y3_2 = y3[2];

  assign y3_3 = y3[3];

  assign y3_4 = y3[4];

  assign y3_5 = y3[5];

  assign y3_6 = y3[6];

  assign y3_7 = y3[7];

  assign y3_8 = y3[8];

  assign y3_9 = y3[9];

  assign y3_10 = y3[10];

  assign y3_11 = y3[11];

  assign y3_12 = y3[12];

  assign y3_13 = y3[13];

  assign y3_14 = y3[14];

  assign y3_15 = y3[15];

  assign y3_16 = y3[16];

  assign y3_17 = y3[17];

  assign y3_18 = y3[18];

  assign y3_19 = y3[19];

  assign y3_20 = y3[20];

  assign y3_21 = y3[21];

  assign y3_22 = y3[22];

  assign y3_23 = y3[23];

  assign y3_24 = y3[24];

  assign y3_25 = y3[25];

  assign y3_26 = y3[26];

  assign y3_27 = y3[27];

  assign y3_28 = y3[28];

  assign y3_29 = y3[29];

  assign y3_30 = y3[30];

  assign y3_31 = y3[31];

  assign y3_32 = y3[32];

  assign y3_33 = y3[33];

  assign y3_34 = y3[34];

  assign y3_35 = y3[35];

  assign y3_36 = y3[36];

  assign y3_37 = y3[37];

  assign y3_38 = y3[38];

  assign y3_39 = y3[39];

  assign y3_40 = y3[40];

  assign y3_41 = y3[41];

  assign y3_42 = y3[42];

  assign y3_43 = y3[43];

  assign y3_44 = y3[44];

  assign y3_45 = y3[45];

  assign y3_46 = y3[46];

  assign y3_47 = y3[47];

  assign y3_48 = y3[48];

  assign y3_49 = y3[49];

  assign y3_50 = y3[50];

  assign y3_51 = y3[51];

  assign y3_52 = y3[52];

  assign y3_53 = y3[53];

  assign y3_54 = y3[54];

  assign y3_55 = y3[55];

  assign y3_56 = y3[56];

  assign y3_57 = y3[57];

  assign y3_58 = y3[58];

  assign y3_59 = y3[59];

  assign y3_60 = y3[60];

  assign y3_61 = y3[61];

  assign y3_62 = y3[62];

  assign y3_63 = y3[63];

  assign y3_64 = y3[64];

  assign y3_65 = y3[65];

  assign y3_66 = y3[66];

  assign y3_67 = y3[67];

  assign y3_68 = y3[68];

  assign y3_69 = y3[69];

  assign y3_70 = y3[70];

  assign y3_71 = y3[71];

  assign y3_72 = y3[72];

  assign y3_73 = y3[73];

  assign y3_74 = y3[74];

  assign y3_75 = y3[75];

  assign y3_76 = y3[76];

  assign y3_77 = y3[77];

  assign y3_78 = y3[78];

  assign y3_79 = y3[79];

  assign y3_80 = y3[80];

  assign y3_81 = y3[81];

  assign y3_82 = y3[82];

  assign y3_83 = y3[83];

  assign y3_84 = y3[84];

  assign y3_85 = y3[85];

  assign y3_86 = y3[86];

  assign y3_87 = y3[87];

  assign y3_88 = y3[88];

  assign y3_89 = y3[89];

  assign y4_0 = y4[0];

  assign y4_1 = y4[1];

  assign y4_2 = y4[2];

  assign y4_3 = y4[3];

  assign y4_4 = y4[4];

  assign y4_5 = y4[5];

  assign y4_6 = y4[6];

  assign y4_7 = y4[7];

  assign y4_8 = y4[8];

  assign y4_9 = y4[9];

  assign y4_10 = y4[10];

  assign y4_11 = y4[11];

  assign y4_12 = y4[12];

  assign y4_13 = y4[13];

  assign y4_14 = y4[14];

  assign y4_15 = y4[15];

  assign y4_16 = y4[16];

  assign y4_17 = y4[17];

  assign y4_18 = y4[18];

  assign y4_19 = y4[19];

  assign y4_20 = y4[20];

  assign y4_21 = y4[21];

  assign y4_22 = y4[22];

  assign y4_23 = y4[23];

  assign y4_24 = y4[24];

  assign y4_25 = y4[25];

  assign y4_26 = y4[26];

  assign y4_27 = y4[27];

  assign y4_28 = y4[28];

  assign y4_29 = y4[29];

  assign y4_30 = y4[30];

  assign y4_31 = y4[31];

  assign y4_32 = y4[32];

  assign y4_33 = y4[33];

  assign y4_34 = y4[34];

  assign y4_35 = y4[35];

  assign y4_36 = y4[36];

  assign y4_37 = y4[37];

  assign y4_38 = y4[38];

  assign y4_39 = y4[39];

  assign y4_40 = y4[40];

  assign y4_41 = y4[41];

  assign y4_42 = y4[42];

  assign y4_43 = y4[43];

  assign y4_44 = y4[44];

  assign y4_45 = y4[45];

  assign y4_46 = y4[46];

  assign y4_47 = y4[47];

  assign y4_48 = y4[48];

  assign y4_49 = y4[49];

  assign y4_50 = y4[50];

  assign y4_51 = y4[51];

  assign y4_52 = y4[52];

  assign y4_53 = y4[53];

  assign y4_54 = y4[54];

  assign y4_55 = y4[55];

  assign y4_56 = y4[56];

  assign y4_57 = y4[57];

  assign y4_58 = y4[58];

  assign y4_59 = y4[59];

  assign y4_60 = y4[60];

  assign y4_61 = y4[61];

  assign y4_62 = y4[62];

  assign y4_63 = y4[63];

  assign y4_64 = y4[64];

  assign y4_65 = y4[65];

  assign y4_66 = y4[66];

  assign y4_67 = y4[67];

  assign y4_68 = y4[68];

  assign y4_69 = y4[69];

  assign y4_70 = y4[70];

  assign y4_71 = y4[71];

  assign y4_72 = y4[72];

  assign y4_73 = y4[73];

  assign y4_74 = y4[74];

  assign y4_75 = y4[75];

  assign y4_76 = y4[76];

  assign y4_77 = y4[77];

  assign y4_78 = y4[78];

  assign y4_79 = y4[79];

  assign y4_80 = y4[80];

  assign y4_81 = y4[81];

  assign y4_82 = y4[82];

  assign y4_83 = y4[83];

  assign y4_84 = y4[84];

  assign y4_85 = y4[85];

  assign y4_86 = y4[86];

  assign y4_87 = y4[87];

  assign y4_88 = y4[88];

  assign y4_89 = y4[89];

endmodule  // dvbs2hdlTransmitterCore_ConvertToMux
