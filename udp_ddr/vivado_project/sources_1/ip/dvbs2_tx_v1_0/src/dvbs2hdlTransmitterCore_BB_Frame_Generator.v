// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_BB_Frame_Generator.v
// Created: 2024-01-10 13:49:57
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_BB_Frame_Generator
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/BB Frame Generator
// Hierarchy Level: 3
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_BB_Frame_Generator
          (clk,
           reset,
           enb,
           pktBitsIn,
           pktStartIn,
           pktEndIn,
           pktValidIn,
           frameStartIn,
           frameEndIn,
           TSorGS,
           DFL,
           UPL,
           SYNC,
           pMODCOD,
           pFECFrame,
           dataOut,
           startOut,
           endOut,
           validOut,
           MODCOD,
           FECFrame);


  input   clk;
  input   reset;
  input   enb;
  input   pktBitsIn;
  input   pktStartIn;
  input   pktEndIn;
  input   pktValidIn;
  input   frameStartIn;
  input   frameEndIn;
  input   [1:0] TSorGS;  // ufix2
  input   [15:0] DFL;  // uint16
  input   [15:0] UPL;  // uint16
  input   [7:0] SYNC;  // uint8
  input   [4:0] pMODCOD;  // ufix5
  input   pFECFrame;
  output  dataOut;
  output  startOut;
  output  endOut;
  output  validOut;
  output  [4:0] MODCOD;  // ufix5
  output  FECFrame;


  reg  Delay5_out1;
  reg  Delay4_out1;
  reg  Delay3_out1;
  reg  Delay1_out1;
  reg  Delay_out1;
  reg  Delay2_out1;
  reg [1:0] Unit_Delay_Enabled_Synchronous1_out1;  // ufix2
  wire [1:0] Unit_Delay_Enabled_Synchronous1_ectrl;  // ufix2
  reg [15:0] Unit_Delay_Enabled_Synchronous_out1;  // uint16
  wire [15:0] Unit_Delay_Enabled_Synchronous_ectrl;  // uint16
  reg [15:0] Unit_Delay_Enabled_Synchronous2_out1;  // uint16
  wire [15:0] Unit_Delay_Enabled_Synchronous2_ectrl;  // uint16
  reg [7:0] Unit_Delay_Enabled_Synchronous3_out1;  // uint8
  wire [7:0] Unit_Delay_Enabled_Synchronous3_ectrl;  // uint8
  reg [4:0] Unit_Delay_Enabled_Synchronous4_out1;  // ufix5
  wire [4:0] Unit_Delay_Enabled_Synchronous4_ectrl;  // ufix5
  reg  Unit_Delay_Enabled_Synchronous5_out1;
  wire Unit_Delay_Enabled_Synchronous5_ectrl;
  wire BB_Header_and_Data_CRC_Generator_out1;
  wire BB_Header_and_Data_CRC_Generator_out2;
  wire [15:0] BB_Header_and_Data_CRC_Generator_out3;  // uint16
  wire BB_Header_and_Data_CRC_Generator_out4;
  wire BB_Header_and_Data_CRC_Generator_out5;
  wire BB_Header_and_Data_CRC_Generator_out6;
  wire BB_Header_and_Data_CRC_Generator_out7;
  wire [4:0] BB_Header_and_Data_CRC_Generator_out8;  // ufix5
  wire BB_Header_and_Data_CRC_Generator_out9;
  wire Data_Store_FIFO_out1;
  wire Data_Store_FIFO_out2;
  wire Data_Store_FIFO_out3;
  wire Data_Store_FIFO_out4;
  wire Data_Store_FIFO_out5;
  wire Data_Store_FIFO_out6;
  wire [4:0] Data_Store_FIFO_out7;  // ufix5
  wire Data_Store_FIFO_out8;
  wire Multiplexer_out1;
  wire Multiplexer_out2;
  wire Multiplexer_out3;
  wire Multiplexer_out4;
  wire [4:0] Multiplexer_out5;  // ufix5
  wire Multiplexer_out6;
  wire BB_Scrambler_out1;
  wire BB_Scrambler_out2;
  wire BB_Scrambler_out3;
  wire BB_Scrambler_out4;
  wire [4:0] BB_Scrambler_out5;  // ufix5
  wire BB_Scrambler_out6;


  always @(posedge clk or posedge reset)
    begin : Delay5_process
      if (reset == 1'b1) begin
        Delay5_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay5_out1 <= pktBitsIn;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay4_process
      if (reset == 1'b1) begin
        Delay4_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay4_out1 <= pktStartIn;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay3_process
      if (reset == 1'b1) begin
        Delay3_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay3_out1 <= pktEndIn;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay1_out1 <= pktValidIn;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay_process
      if (reset == 1'b1) begin
        Delay_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay_out1 <= frameEndIn;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay2_process
      if (reset == 1'b1) begin
        Delay2_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay2_out1 <= frameStartIn;
        end
      end
    end



  assign Unit_Delay_Enabled_Synchronous1_ectrl = (frameStartIn == 1'b0 ? Unit_Delay_Enabled_Synchronous1_out1 :
              TSorGS);



  always @(posedge clk or posedge reset)
    begin : Unit_Delay_Enabled_Synchronous1_lowered_process
      if (reset == 1'b1) begin
        Unit_Delay_Enabled_Synchronous1_out1 <= 2'b00;
      end
      else begin
        if (enb) begin
          Unit_Delay_Enabled_Synchronous1_out1 <= Unit_Delay_Enabled_Synchronous1_ectrl;
        end
      end
    end



  assign Unit_Delay_Enabled_Synchronous_ectrl = (frameStartIn == 1'b0 ? Unit_Delay_Enabled_Synchronous_out1 :
              DFL);



  always @(posedge clk or posedge reset)
    begin : Unit_Delay_Enabled_Synchronous_lowered_process
      if (reset == 1'b1) begin
        Unit_Delay_Enabled_Synchronous_out1 <= 16'b0000000000000000;
      end
      else begin
        if (enb) begin
          Unit_Delay_Enabled_Synchronous_out1 <= Unit_Delay_Enabled_Synchronous_ectrl;
        end
      end
    end



  assign Unit_Delay_Enabled_Synchronous2_ectrl = (frameStartIn == 1'b0 ? Unit_Delay_Enabled_Synchronous2_out1 :
              UPL);



  always @(posedge clk or posedge reset)
    begin : Unit_Delay_Enabled_Synchronous2_lowered_process
      if (reset == 1'b1) begin
        Unit_Delay_Enabled_Synchronous2_out1 <= 16'b0000000000000000;
      end
      else begin
        if (enb) begin
          Unit_Delay_Enabled_Synchronous2_out1 <= Unit_Delay_Enabled_Synchronous2_ectrl;
        end
      end
    end



  assign Unit_Delay_Enabled_Synchronous3_ectrl = (frameStartIn == 1'b0 ? Unit_Delay_Enabled_Synchronous3_out1 :
              SYNC);



  always @(posedge clk or posedge reset)
    begin : Unit_Delay_Enabled_Synchronous3_lowered_process
      if (reset == 1'b1) begin
        Unit_Delay_Enabled_Synchronous3_out1 <= 8'b00000000;
      end
      else begin
        if (enb) begin
          Unit_Delay_Enabled_Synchronous3_out1 <= Unit_Delay_Enabled_Synchronous3_ectrl;
        end
      end
    end



  assign Unit_Delay_Enabled_Synchronous4_ectrl = (frameStartIn == 1'b0 ? Unit_Delay_Enabled_Synchronous4_out1 :
              pMODCOD);



  always @(posedge clk or posedge reset)
    begin : Unit_Delay_Enabled_Synchronous4_lowered_process
      if (reset == 1'b1) begin
        Unit_Delay_Enabled_Synchronous4_out1 <= 5'b00000;
      end
      else begin
        if (enb) begin
          Unit_Delay_Enabled_Synchronous4_out1 <= Unit_Delay_Enabled_Synchronous4_ectrl;
        end
      end
    end



  assign Unit_Delay_Enabled_Synchronous5_ectrl = (frameStartIn == 1'b0 ? Unit_Delay_Enabled_Synchronous5_out1 :
              pFECFrame);



  always @(posedge clk or posedge reset)
    begin : Unit_Delay_Enabled_Synchronous5_lowered_process
      if (reset == 1'b1) begin
        Unit_Delay_Enabled_Synchronous5_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Unit_Delay_Enabled_Synchronous5_out1 <= Unit_Delay_Enabled_Synchronous5_ectrl;
        end
      end
    end



  dvbs2hdlTransmitterCore_BB_Header_and_Data_CRC_Generator u_BB_Header_and_Data_CRC_Generator (.clk(clk),
                                                                                               .reset(reset),
                                                                                               .enb(enb),
                                                                                               .dataIn(Delay5_out1),
                                                                                               .startIn(Delay4_out1),
                                                                                               .endIn(Delay3_out1),
                                                                                               .validIn(Delay1_out1),
                                                                                               .frameEnd(Delay_out1),
                                                                                               .frameStart(Delay2_out1),
                                                                                               .TSorGS(Unit_Delay_Enabled_Synchronous1_out1),  // ufix2
                                                                                               .DFL(Unit_Delay_Enabled_Synchronous_out1),  // uint16
                                                                                               .UPL(Unit_Delay_Enabled_Synchronous2_out1),  // uint16
                                                                                               .SYNC(Unit_Delay_Enabled_Synchronous3_out1),  // uint8
                                                                                               .MODCOD(Unit_Delay_Enabled_Synchronous4_out1),  // ufix5
                                                                                               .FECFrame(Unit_Delay_Enabled_Synchronous5_out1),
                                                                                               .pktBits(BB_Header_and_Data_CRC_Generator_out1),
                                                                                               .pktValid(BB_Header_and_Data_CRC_Generator_out2),
                                                                                               .DFLOut(BB_Header_and_Data_CRC_Generator_out3),  // uint16
                                                                                               .bitsOut(BB_Header_and_Data_CRC_Generator_out4),
                                                                                               .startOut(BB_Header_and_Data_CRC_Generator_out5),
                                                                                               .endOut(BB_Header_and_Data_CRC_Generator_out6),
                                                                                               .validOut(BB_Header_and_Data_CRC_Generator_out7),
                                                                                               .MODCODOut(BB_Header_and_Data_CRC_Generator_out8),  // ufix5
                                                                                               .FECFrameOut(BB_Header_and_Data_CRC_Generator_out9)
                                                                                               );

  dvbs2hdlTransmitterCore_Data_Store_FIFO u_Data_Store_FIFO (.clk(clk),
                                                             .reset(reset),
                                                             .enb(enb),
                                                             .pktBits(BB_Header_and_Data_CRC_Generator_out1),
                                                             .pktValid(BB_Header_and_Data_CRC_Generator_out2),
                                                             .DFLOut(BB_Header_and_Data_CRC_Generator_out3),  // uint16
                                                             .bitsOut(BB_Header_and_Data_CRC_Generator_out4),
                                                             .startOut(BB_Header_and_Data_CRC_Generator_out5),
                                                             .endOut(BB_Header_and_Data_CRC_Generator_out6),
                                                             .validOut(BB_Header_and_Data_CRC_Generator_out7),
                                                             .MODCOD(BB_Header_and_Data_CRC_Generator_out8),  // ufix5
                                                             .FECFrame(BB_Header_and_Data_CRC_Generator_out9),
                                                             .dataBits(Data_Store_FIFO_out1),
                                                             .dataValid(Data_Store_FIFO_out2),
                                                             .dataEnd(Data_Store_FIFO_out3),
                                                             .headerBits(Data_Store_FIFO_out4),
                                                             .headerStart(Data_Store_FIFO_out5),
                                                             .headerValid(Data_Store_FIFO_out6),
                                                             .MODCODOut(Data_Store_FIFO_out7),  // ufix5
                                                             .FECFrameOut(Data_Store_FIFO_out8)
                                                             );

  dvbs2hdlTransmitterCore_Multiplexer u_Multiplexer (.clk(clk),
                                                     .reset(reset),
                                                     .enb(enb),
                                                     .dataBits(Data_Store_FIFO_out1),
                                                     .dataValid(Data_Store_FIFO_out2),
                                                     .dataEnd(Data_Store_FIFO_out3),
                                                     .headerBits(Data_Store_FIFO_out4),
                                                     .headerStart(Data_Store_FIFO_out5),
                                                     .headerValid(Data_Store_FIFO_out6),
                                                     .MODCOD(Data_Store_FIFO_out7),  // ufix5
                                                     .FECFrame(Data_Store_FIFO_out8),
                                                     .dataOut(Multiplexer_out1),
                                                     .startOut(Multiplexer_out2),
                                                     .endOut(Multiplexer_out3),
                                                     .validOut(Multiplexer_out4),
                                                     .MODCODOut(Multiplexer_out5),  // ufix5
                                                     .FECFrameOut(Multiplexer_out6)
                                                     );

  dvbs2hdlTransmitterCore_BB_Scrambler u_BB_Scrambler (.clk(clk),
                                                       .reset(reset),
                                                       .enb(enb),
                                                       .bitsIn(Multiplexer_out1),
                                                       .startIn(Multiplexer_out2),
                                                       .endIn(Multiplexer_out3),
                                                       .validIn(Multiplexer_out4),
                                                       .MODCOD(Multiplexer_out5),  // ufix5
                                                       .FECFrame(Multiplexer_out6),
                                                       .bitsOut(BB_Scrambler_out1),
                                                       .startOut(BB_Scrambler_out2),
                                                       .endOut(BB_Scrambler_out3),
                                                       .validOut(BB_Scrambler_out4),
                                                       .MODCODOut(BB_Scrambler_out5),  // ufix5
                                                       .FECFrameOut(BB_Scrambler_out6)
                                                       );

  assign dataOut = BB_Scrambler_out1;

  assign startOut = BB_Scrambler_out2;

  assign endOut = BB_Scrambler_out3;

  assign validOut = BB_Scrambler_out4;

  assign MODCOD = BB_Scrambler_out5;

  assign FECFrame = BB_Scrambler_out6;

endmodule  // dvbs2hdlTransmitterCore_BB_Frame_Generator

