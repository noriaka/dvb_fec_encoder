// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Write_Offset_Address.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Write_Offset_Address
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/Interleaver/DVB-S2 HDL Interleaver/RAM Address Generator/Write 
// Offset Addres
// Hierarchy Level: 6
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Write_Offset_Address
          (clk,
           reset,
           enb,
           fecframe,
           enb_1,
           addr);


  input   clk;
  input   reset;
  input   enb;
  input   fecframe;
  input   enb_1;
  output  [15:0] addr;  // uint16


  reg  Delay12_out1;
  reg  Delay11_out1;
  reg  Delay4_out1;
  reg  Delay1_out1;
  reg  Delay10_out1;
  wire [13:0] count_step;  // ufix14
  wire [13:0] count_from;  // ufix14
  reg [13:0] Write_Offset_Address_Short_Frame_out1;  // ufix14
  wire [13:0] count;  // ufix14
  wire need_to_wrap;
  wire [13:0] count_value;  // ufix14
  wire [13:0] count_1;  // ufix14
  reg [13:0] Delay8_out1;  // ufix14
  wire Compare_To_Constant_out1;
  reg  Delay9_out1;
  wire Logical_Operator_out1;
  reg  Delay6_out1;
  reg  Delay7_out1;
  wire [15:0] count_step_1;  // uint16
  wire [15:0] count_from_1;  // uint16
  wire [15:0] count_reset;  // uint16
  reg [15:0] Write_Offset_Address_Normal_Frame_out1;  // uint16
  wire [15:0] count_2;  // uint16
  wire need_to_wrap_1;
  wire [15:0] count_value_1;  // uint16
  wire [15:0] count_3;  // uint16
  wire [15:0] count_4;  // uint16
  reg [15:0] Delay2_out1;  // uint16
  reg [13:0] Delay3_out1;  // ufix14
  wire [15:0] Data_Type_Conversion_out1;  // uint16
  reg [15:0] Delay5_out1;  // uint16
  wire [15:0] Switch_out1;  // uint16


  always @(posedge clk or posedge reset)
    begin : Delay12_process
      if (reset == 1'b1) begin
        Delay12_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay12_out1 <= fecframe;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay11_process
      if (reset == 1'b1) begin
        Delay11_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay11_out1 <= Delay12_out1;
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
          Delay4_out1 <= Delay11_out1;
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
          Delay1_out1 <= Delay4_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay10_process
      if (reset == 1'b1) begin
        Delay10_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay10_out1 <= enb_1;
        end
      end
    end



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 16199
  assign count_step = 14'b00000000000001;



  assign count_from = 14'b00000000000000;



  assign count = Write_Offset_Address_Short_Frame_out1 + count_step;



  assign need_to_wrap = Write_Offset_Address_Short_Frame_out1 == 14'b11111101000111;



  assign count_value = (need_to_wrap == 1'b0 ? count :
              count_from);



  assign count_1 = (Delay10_out1 == 1'b0 ? Write_Offset_Address_Short_Frame_out1 :
              count_value);



  always @(posedge clk or posedge reset)
    begin : Write_Offset_Address_Short_Frame_process
      if (reset == 1'b1) begin
        Write_Offset_Address_Short_Frame_out1 <= 14'b00000000000000;
      end
      else begin
        if (enb) begin
          Write_Offset_Address_Short_Frame_out1 <= count_1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay8_process
      if (reset == 1'b1) begin
        Delay8_out1 <= 14'b00000000000000;
      end
      else begin
        if (enb) begin
          Delay8_out1 <= Write_Offset_Address_Short_Frame_out1;
        end
      end
    end



  assign Compare_To_Constant_out1 = Delay8_out1 == 14'b11111101000111;



  always @(posedge clk or posedge reset)
    begin : Delay9_process
      if (reset == 1'b1) begin
        Delay9_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay9_out1 <= Delay10_out1;
        end
      end
    end



  assign Logical_Operator_out1 = Delay9_out1 & (Delay11_out1 & Compare_To_Constant_out1);



  always @(posedge clk or posedge reset)
    begin : Delay6_process
      if (reset == 1'b1) begin
        Delay6_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay6_out1 <= Logical_Operator_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay7_process
      if (reset == 1'b1) begin
        Delay7_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay7_out1 <= Delay9_out1;
        end
      end
    end



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 64799
  assign count_step_1 = 16'b0000000000000001;



  assign count_from_1 = 16'b0000000000000000;



  assign count_reset = 16'b0000000000000000;



  assign count_2 = Write_Offset_Address_Normal_Frame_out1 + count_step_1;



  assign need_to_wrap_1 = Write_Offset_Address_Normal_Frame_out1 == 16'b1111110100011111;



  assign count_value_1 = (need_to_wrap_1 == 1'b0 ? count_2 :
              count_from_1);



  assign count_3 = (Delay7_out1 == 1'b0 ? Write_Offset_Address_Normal_Frame_out1 :
              count_value_1);



  assign count_4 = (Delay6_out1 == 1'b0 ? count_3 :
              count_reset);



  always @(posedge clk or posedge reset)
    begin : Write_Offset_Address_Normal_Frame_process
      if (reset == 1'b1) begin
        Write_Offset_Address_Normal_Frame_out1 <= 16'b0000000000000000;
      end
      else begin
        if (enb) begin
          Write_Offset_Address_Normal_Frame_out1 <= count_4;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay2_process
      if (reset == 1'b1) begin
        Delay2_out1 <= 16'b0000000000000000;
      end
      else begin
        if (enb) begin
          Delay2_out1 <= Write_Offset_Address_Normal_Frame_out1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay3_process
      if (reset == 1'b1) begin
        Delay3_out1 <= 14'b00000000000000;
      end
      else begin
        if (enb) begin
          Delay3_out1 <= Delay8_out1;
        end
      end
    end



  assign Data_Type_Conversion_out1 = {2'b0, Delay3_out1};



  always @(posedge clk or posedge reset)
    begin : Delay5_process
      if (reset == 1'b1) begin
        Delay5_out1 <= 16'b0000000000000000;
      end
      else begin
        if (enb) begin
          Delay5_out1 <= Data_Type_Conversion_out1;
        end
      end
    end



  assign Switch_out1 = (Delay1_out1 == 1'b0 ? Delay2_out1 :
              Delay5_out1);



  assign addr = Switch_out1;

endmodule  // dvbs2hdlTransmitterCore_Write_Offset_Address

