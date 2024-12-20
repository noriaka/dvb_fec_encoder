// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_PN_Sequence_Generator.v
// Created: 2024-01-10 13:49:57
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_PN_Sequence_Generator
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/BB Frame Generator/BB Scrambler/Subsystem/PN Sequence Generator
// Hierarchy Level: 6
// Model version: 4.5
// 
// PN Sequence Generator
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_PN_Sequence_Generator
          (clk,
           reset,
           enb,
           inportReset,
           PN_Sequence);


  input   clk;
  input   reset;
  input   enb;
  input   inportReset;
  output  PN_Sequence;  // ufix1


  wire [14:0] InitStates;  // boolean [15]
  wire [14:0] TDL;  // boolean [15]
  wire TDL_14;
  wire TDL_13;
  wire PNSeqOut;
  wire [14:0] TDL_1;  // boolean [15]
  reg  [14:0] VectorTDL_1;  // ufix1 [15]
  reg  [14:0] TDLPrevious;  // boolean [15]
  wire [14:0] OutputMask;  // boolean [15]
  wire [14:0] MaskANDtoXOR;  // boolean [15]
  wire MaskANDtoXOR_0;
  wire MaskANDtoXOR_1;
  wire MaskANDtoXOR_2;
  wire MaskANDtoXOR_3;
  wire MaskANDtoXOR_4;
  wire MaskANDtoXOR_5;
  wire MaskANDtoXOR_6;
  wire MaskANDtoXOR_7;
  wire MaskANDtoXOR_8;
  wire MaskANDtoXOR_9;
  wire MaskANDtoXOR_10;
  wire MaskANDtoXOR_11;
  wire MaskANDtoXOR_12;
  wire MaskANDtoXOR_13;
  wire MaskANDtoXOR_14;
  wire PNSeqBits;
  wire PNUfix;  // ufix1
  reg signed [31:0] VectorTDL_t_0_0;  // int32


  assign InitStates[0] = 1'b1;
  assign InitStates[1] = 1'b0;
  assign InitStates[2] = 1'b0;
  assign InitStates[3] = 1'b1;
  assign InitStates[4] = 1'b0;
  assign InitStates[5] = 1'b1;
  assign InitStates[6] = 1'b0;
  assign InitStates[7] = 1'b1;
  assign InitStates[8] = 1'b0;
  assign InitStates[9] = 1'b0;
  assign InitStates[10] = 1'b0;
  assign InitStates[11] = 1'b0;
  assign InitStates[12] = 1'b0;
  assign InitStates[13] = 1'b0;
  assign InitStates[14] = 1'b0;



  assign TDL_14 = TDL[14];

  assign TDL_13 = TDL[13];

  assign PNSeqOut = TDL_13 ^ TDL_14;



  assign TDL_1[0] = PNSeqOut;
  assign TDL_1[1] = TDL[0];
  assign TDL_1[2] = TDL[1];
  assign TDL_1[3] = TDL[2];
  assign TDL_1[4] = TDL[3];
  assign TDL_1[5] = TDL[4];
  assign TDL_1[6] = TDL[5];
  assign TDL_1[7] = TDL[6];
  assign TDL_1[8] = TDL[7];
  assign TDL_1[9] = TDL[8];
  assign TDL_1[10] = TDL[9];
  assign TDL_1[11] = TDL[10];
  assign TDL_1[12] = TDL[11];
  assign TDL_1[13] = TDL[12];
  assign TDL_1[14] = TDL[13];

  always @(posedge clk or posedge reset)
    begin : VectorTDL_process
      if (reset == 1'b1) begin
        VectorTDL_1[0] <= 1'b1;
        VectorTDL_1[1] <= 1'b0;
        VectorTDL_1[2] <= 1'b0;
        VectorTDL_1[3] <= 1'b1;
        VectorTDL_1[4] <= 1'b0;
        VectorTDL_1[5] <= 1'b1;
        VectorTDL_1[6] <= 1'b0;
        VectorTDL_1[7] <= 1'b1;
        VectorTDL_1[8] <= 1'b0;
        VectorTDL_1[9] <= 1'b0;
        VectorTDL_1[10] <= 1'b0;
        VectorTDL_1[11] <= 1'b0;
        VectorTDL_1[12] <= 1'b0;
        VectorTDL_1[13] <= 1'b0;
        VectorTDL_1[14] <= 1'b0;

        for(VectorTDL_t_0_0 = 32'sd0; VectorTDL_t_0_0 <= 32'sd14; VectorTDL_t_0_0 = VectorTDL_t_0_0 + 32'sd1) begin
          TDLPrevious[VectorTDL_t_0_0] <= VectorTDL_1[VectorTDL_t_0_0];
        end

      end
      else begin
        if (enb) begin
          TDLPrevious <= TDL_1;
        end
      end
    end



  assign TDL = (inportReset == 1'b0 ? TDLPrevious :
              InitStates);



  assign OutputMask[0] = 1'b0;
  assign OutputMask[1] = 1'b0;
  assign OutputMask[2] = 1'b0;
  assign OutputMask[3] = 1'b0;
  assign OutputMask[4] = 1'b0;
  assign OutputMask[5] = 1'b0;
  assign OutputMask[6] = 1'b0;
  assign OutputMask[7] = 1'b0;
  assign OutputMask[8] = 1'b0;
  assign OutputMask[9] = 1'b0;
  assign OutputMask[10] = 1'b0;
  assign OutputMask[11] = 1'b0;
  assign OutputMask[12] = 1'b0;
  assign OutputMask[13] = 1'b1;
  assign OutputMask[14] = 1'b1;




  genvar t_01;
  generate
    for(t_01 = 32'sd0; t_01 <= 32'sd14; t_01 = t_01 + 32'sd1) begin:MaskANDtoXOR_gen
      assign MaskANDtoXOR[t_01] = TDL[t_01] & OutputMask[t_01];
    end
  endgenerate




  assign MaskANDtoXOR_0 = MaskANDtoXOR[0];

  assign MaskANDtoXOR_1 = MaskANDtoXOR[1];

  assign MaskANDtoXOR_2 = MaskANDtoXOR[2];

  assign MaskANDtoXOR_3 = MaskANDtoXOR[3];

  assign MaskANDtoXOR_4 = MaskANDtoXOR[4];

  assign MaskANDtoXOR_5 = MaskANDtoXOR[5];

  assign MaskANDtoXOR_6 = MaskANDtoXOR[6];

  assign MaskANDtoXOR_7 = MaskANDtoXOR[7];

  assign MaskANDtoXOR_8 = MaskANDtoXOR[8];

  assign MaskANDtoXOR_9 = MaskANDtoXOR[9];

  assign MaskANDtoXOR_10 = MaskANDtoXOR[10];

  assign MaskANDtoXOR_11 = MaskANDtoXOR[11];

  assign MaskANDtoXOR_12 = MaskANDtoXOR[12];

  assign MaskANDtoXOR_13 = MaskANDtoXOR[13];

  assign MaskANDtoXOR_14 = MaskANDtoXOR[14];

  assign PNSeqBits = MaskANDtoXOR_14 ^ (MaskANDtoXOR_13 ^ (MaskANDtoXOR_12 ^ (MaskANDtoXOR_11 ^ (MaskANDtoXOR_10 ^ (MaskANDtoXOR_9 ^ (MaskANDtoXOR_8 ^ (MaskANDtoXOR_7 ^ (MaskANDtoXOR_6 ^ (MaskANDtoXOR_5 ^ (MaskANDtoXOR_4 ^ (MaskANDtoXOR_3 ^ (MaskANDtoXOR_2 ^ (MaskANDtoXOR_0 ^ MaskANDtoXOR_1)))))))))))));



  assign PNUfix = PNSeqBits;



  assign PN_Sequence = PNUfix;



endmodule  // dvbs2hdlTransmitterCore_PN_Sequence_Generator

