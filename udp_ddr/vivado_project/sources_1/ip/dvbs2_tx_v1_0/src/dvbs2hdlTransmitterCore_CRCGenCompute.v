// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_CRCGenCompute.v
// Created: 2024-01-10 13:49:57
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_CRCGenCompute
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/BB Frame Generator/BB Header and Data CRC Generator/BB Header Generator/BB 
// Header CRC Generator/CRCGenComput
// Hierarchy Level: 7
// Model version: 4.5
// 
// Compute the CRC CheckSum
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_CRCGenCompute
          (clk,
           reset,
           enb,
           datainReg,
           validIn,
           processMsg,
           padZero,
           counter,
           crcChecksum_0,
           crcChecksum_1,
           crcChecksum_2,
           crcChecksum_3,
           crcChecksum_4,
           crcChecksum_5,
           crcChecksum_6,
           crcChecksum_7);


  input   clk;
  input   reset;
  input   enb;
  input   datainReg;  // ufix1
  input   validIn;  // ufix1
  input   processMsg;  // ufix1
  input   padZero;  // ufix1
  input   [2:0] counter;  // ufix3
  output  crcChecksum_0;  // ufix1
  output  crcChecksum_1;  // ufix1
  output  crcChecksum_2;  // ufix1
  output  crcChecksum_3;  // ufix1
  output  crcChecksum_4;  // ufix1
  output  crcChecksum_5;  // ufix1
  output  crcChecksum_6;  // ufix1
  output  crcChecksum_7;  // ufix1


  wire xoredSel;  // ufix1
  reg  dvalidin;  // ufix1
  wire tcsSel;  // ufix1
  wire csSel;  // ufix1
  wire rpadZero;  // ufix1
  wire dataSel;  // ufix1
  wire [7:0] padingzeros;  // ufix1 [8]
  wire [6:0] inputzeros;  // ufix1 [7]
  wire [7:0] datamux;  // ufix1 [8]
  wire [7:0] datacpt;  // ufix1 [8]
  wire datacpt_7;  // ufix1
  wire datacpt_6;  // ufix1
  wire datacpt_5;  // ufix1
  wire datacpt_4;  // ufix1
  wire datacpt_3;  // ufix1
  wire datacpt_2;  // ufix1
  wire datacpt_1;  // ufix1
  wire datacpt_0;  // ufix1
  wire [7:0] finalXorValue;  // ufix1 [8]
  wire finalXorValue_0;  // ufix1
  wire finalXorValue_1;  // ufix1
  wire finalXorValue_2;  // ufix1
  wire finalXorValue_3;  // ufix1
  wire finalXorValue_4;  // ufix1
  wire finalXorValue_5;  // ufix1
  wire finalXorValue_6;  // ufix1
  wire finalXorValue_7;  // ufix1
  wire [7:0] newChecksum;  // ufix1 [8]
  wire newChecksum_0;  // ufix1
  wire refelctCheckSum_7;  // ufix1
  wire newChecksum_1;  // ufix1
  wire refelctCheckSum_6;  // ufix1
  wire newChecksum_2;  // ufix1
  wire refelctCheckSum_5;  // ufix1
  wire newChecksum_3;  // ufix1
  wire refelctCheckSum_4;  // ufix1
  wire newChecksum_4;  // ufix1
  wire refelctCheckSum_3;  // ufix1
  wire newChecksum_5;  // ufix1
  wire refelctCheckSum_2;  // ufix1
  wire newChecksum_6;  // ufix1
  wire refelctCheckSum_1;  // ufix1
  wire newChecksum_7;  // ufix1
  wire refelctCheckSum_0;  // ufix1
  wire [7:0] xoredChecksum;  // ufix1 [8]
  reg  [7:0] checksumReg;  // ufix1 [8]
  wire checksumReg_6;  // ufix1
  wire checksumReg_7;  // ufix1
  wire tcs_entry7;  // ufix1
  wire checksumReg_5;  // ufix1
  wire tcs_entry6;  // ufix1
  wire checksumReg_4;  // ufix1
  wire tcs_entry5;  // ufix1
  wire checksumReg_3;  // ufix1
  wire tcs_entry4;  // ufix1
  wire checksumReg_2;  // ufix1
  wire tcs_entry3;  // ufix1
  wire checksumReg_1;  // ufix1
  wire tcs_entry2;  // ufix1
  wire checksumReg_0;  // ufix1
  wire tcs_entry1;  // ufix1
  wire tcs_entry0;  // ufix1
  wire [7:0] tchecksum;  // ufix1 [8]
  wire [7:0] finalChecksum;  // ufix1 [8]
  reg  [7:0] crcChecksum;  // ufix1 [8]


  assign xoredSel = counter == 3'b111;



  always @(posedge clk or posedge reset)
    begin : validin_register_process
      if (reset == 1'b1) begin
        dvalidin <= 1'b0;
      end
      else begin
        if (enb) begin
          dvalidin <= validIn;
        end
      end
    end



  assign tcsSel = processMsg & dvalidin;



  assign csSel = tcsSel | padZero;



  assign rpadZero =  ~ padZero;



  // Selection signal: Select input data or pad zeros
  assign dataSel = rpadZero & dvalidin;



  // Padding zeros
  assign padingzeros[0] = 1'b0;
  assign padingzeros[1] = 1'b0;
  assign padingzeros[2] = 1'b0;
  assign padingzeros[3] = 1'b0;
  assign padingzeros[4] = 1'b0;
  assign padingzeros[5] = 1'b0;
  assign padingzeros[6] = 1'b0;
  assign padingzeros[7] = 1'b0;



  assign inputzeros[0] = 1'b0;
  assign inputzeros[1] = 1'b0;
  assign inputzeros[2] = 1'b0;
  assign inputzeros[3] = 1'b0;
  assign inputzeros[4] = 1'b0;
  assign inputzeros[5] = 1'b0;
  assign inputzeros[6] = 1'b0;



  // Prepare inputs for parallel CRC computation
  assign datamux[0] = inputzeros[0];
  assign datamux[1] = inputzeros[1];
  assign datamux[2] = inputzeros[2];
  assign datamux[3] = inputzeros[3];
  assign datamux[4] = inputzeros[4];
  assign datamux[5] = inputzeros[5];
  assign datamux[6] = inputzeros[6];
  assign datamux[7] = datainReg;

  // Switch between input data and padded zeros
  assign datacpt = (dataSel == 1'b0 ? padingzeros :
              datamux);



  assign datacpt_7 = datacpt[7];

  assign datacpt_6 = datacpt[6];

  assign datacpt_5 = datacpt[5];

  assign datacpt_4 = datacpt[4];

  assign datacpt_3 = datacpt[3];

  assign datacpt_2 = datacpt[2];

  assign datacpt_1 = datacpt[1];

  assign datacpt_0 = datacpt[0];

  // Compute finalXor
  assign finalXorValue[0] = 1'b0;
  assign finalXorValue[1] = 1'b0;
  assign finalXorValue[2] = 1'b0;
  assign finalXorValue[3] = 1'b0;
  assign finalXorValue[4] = 1'b0;
  assign finalXorValue[5] = 1'b0;
  assign finalXorValue[6] = 1'b0;
  assign finalXorValue[7] = 1'b0;



  assign finalXorValue_0 = finalXorValue[0];

  assign finalXorValue_1 = finalXorValue[1];

  assign finalXorValue_2 = finalXorValue[2];

  assign finalXorValue_3 = finalXorValue[3];

  assign finalXorValue_4 = finalXorValue[4];

  assign finalXorValue_5 = finalXorValue[5];

  assign finalXorValue_6 = finalXorValue[6];

  assign finalXorValue_7 = finalXorValue[7];

  assign newChecksum_0 = newChecksum[0];

  assign refelctCheckSum_7 = newChecksum_0 ^ finalXorValue_7;



  assign newChecksum_1 = newChecksum[1];

  assign refelctCheckSum_6 = newChecksum_1 ^ finalXorValue_6;



  assign newChecksum_2 = newChecksum[2];

  assign refelctCheckSum_5 = newChecksum_2 ^ finalXorValue_5;



  assign newChecksum_3 = newChecksum[3];

  assign refelctCheckSum_4 = newChecksum_3 ^ finalXorValue_4;



  assign newChecksum_4 = newChecksum[4];

  assign refelctCheckSum_3 = newChecksum_4 ^ finalXorValue_3;



  assign newChecksum_5 = newChecksum[5];

  assign refelctCheckSum_2 = newChecksum_5 ^ finalXorValue_2;



  assign newChecksum_6 = newChecksum[6];

  assign refelctCheckSum_1 = newChecksum_6 ^ finalXorValue_1;



  // Reflect Checksum and make checksum LSB first
  assign newChecksum_7 = newChecksum[7];

  assign refelctCheckSum_0 = newChecksum_7 ^ finalXorValue_0;



  assign xoredChecksum[0] = refelctCheckSum_0;
  assign xoredChecksum[1] = refelctCheckSum_1;
  assign xoredChecksum[2] = refelctCheckSum_2;
  assign xoredChecksum[3] = refelctCheckSum_3;
  assign xoredChecksum[4] = refelctCheckSum_4;
  assign xoredChecksum[5] = refelctCheckSum_5;
  assign xoredChecksum[6] = refelctCheckSum_6;
  assign xoredChecksum[7] = refelctCheckSum_7;

  assign checksumReg_6 = checksumReg[6];

  // Compute checksum element8
  assign tcs_entry7 = datacpt_0 ^ (checksumReg_7 ^ checksumReg_6);



  assign checksumReg_5 = checksumReg[5];

  // Compute checksum element7
  assign tcs_entry6 = datacpt_1 ^ (checksumReg_7 ^ checksumReg_5);



  assign checksumReg_4 = checksumReg[4];

  // Compute checksum element6
  assign tcs_entry5 = checksumReg_4 ^ datacpt_2;



  assign checksumReg_3 = checksumReg[3];

  // Compute checksum element5
  assign tcs_entry4 = datacpt_3 ^ (checksumReg_7 ^ checksumReg_3);



  assign checksumReg_2 = checksumReg[2];

  // Compute checksum element4
  assign tcs_entry3 = checksumReg_2 ^ datacpt_4;



  assign checksumReg_1 = checksumReg[1];

  // Compute checksum element3
  assign tcs_entry2 = datacpt_5 ^ (checksumReg_7 ^ checksumReg_1);



  assign checksumReg_0 = checksumReg[0];

  // Compute checksum element2
  assign tcs_entry1 = checksumReg_0 ^ datacpt_6;



  assign checksumReg_7 = checksumReg[7];

  // Compute checksum element1
  // Checksum selection signal
  assign tcs_entry0 = checksumReg_7 ^ datacpt_7;



  assign tchecksum[0] = tcs_entry0;
  assign tchecksum[1] = tcs_entry1;
  assign tchecksum[2] = tcs_entry2;
  assign tchecksum[3] = tcs_entry3;
  assign tchecksum[4] = tcs_entry4;
  assign tchecksum[5] = tcs_entry5;
  assign tchecksum[6] = tcs_entry6;
  assign tchecksum[7] = tcs_entry7;

  always @(posedge clk or posedge reset)
    begin : checksum_register_process
      if (reset == 1'b1) begin
        checksumReg <= {8{1'b0}};
      end
      else begin
        if (enb) begin
          if (xoredSel == 1'b1) begin
            checksumReg <= {8{1'b0}};
          end
          else begin
            checksumReg <= finalChecksum;
          end
        end
      end
    end



  // Update checksum register for valid inputs
  assign newChecksum = (csSel == 1'b0 ? checksumReg :
              tchecksum);



  // Xor after computing the checksum
  assign finalChecksum = (xoredSel == 1'b0 ? newChecksum :
              xoredChecksum);



  // 1
  always @(posedge clk or posedge reset)
    begin : outputchecksum_register_process
      if (reset == 1'b1) begin
        crcChecksum <= {8{1'b0}};
      end
      else begin
        if (enb && xoredSel) begin
          crcChecksum <= finalChecksum;
        end
      end
    end



  assign crcChecksum_0 = crcChecksum[0];

  assign crcChecksum_1 = crcChecksum[1];

  assign crcChecksum_2 = crcChecksum[2];

  assign crcChecksum_3 = crcChecksum[3];

  assign crcChecksum_4 = crcChecksum[4];

  assign crcChecksum_5 = crcChecksum[5];

  assign crcChecksum_6 = crcChecksum[6];

  assign crcChecksum_7 = crcChecksum[7];

endmodule  // dvbs2hdlTransmitterCore_CRCGenCompute

