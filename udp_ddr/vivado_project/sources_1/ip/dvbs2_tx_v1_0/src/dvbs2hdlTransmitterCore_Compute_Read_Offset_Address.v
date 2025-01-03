// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Compute_Read_Offset_Address.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Compute_Read_Offset_Address
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/Interleaver/DVB-S2 HDL Interleaver/RAM Address Generator/Read Offset 
// Address/Compute Read Offset Addres
// Hierarchy Level: 7
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Compute_Read_Offset_Address
          (clk,
           enb,
           curR,
           maxC,
           curC,
           addr);


  input   clk;
  input   enb;
  input   [2:0] curR;  // ufix3
  input   [15:0] maxC;  // uint16
  input   [15:0] curC;  // uint16
  output  [16:0] addr;  // ufix17


  reg [2:0] Delay8_reg [0:1];  // ufix3 [2]
  wire [2:0] Delay8_reg_next [0:1];  // ufix3 [2]
  wire [2:0] Delay8_out1;  // ufix3
  reg [15:0] Delay2_reg [0:1];  // ufix16 [2]
  wire [15:0] Delay2_reg_next [0:1];  // ufix16 [2]
  wire [15:0] Delay2_out1;  // uint16
  wire [18:0] Product_mul_temp;  // ufix19
  wire [16:0] Product_out1;  // ufix17
  reg [16:0] Delay1_out1;  // ufix17
  reg [15:0] Delay3_reg [0:1];  // ufix16 [2]
  wire [15:0] Delay3_reg_next [0:1];  // ufix16 [2]
  wire [15:0] Delay3_out1;  // uint16
  reg [15:0] Delay4_out1;  // uint16
  wire [16:0] Add_1;  // ufix17
  wire [16:0] Add_out1;  // ufix17
  reg [16:0] Delay5_out1;  // ufix17
  reg signed [31:0] Delay8_t_0_0;  // int32
  reg signed [31:0] Delay8_t_1;  // int32
  reg signed [31:0] Delay2_t_0_0;  // int32
  reg signed [31:0] Delay2_t_1;  // int32
  reg signed [31:0] Delay3_t_0_0;  // int32
  reg signed [31:0] Delay3_t_1;  // int32

  initial begin

    for(Delay8_t_1 = 32'sd0; Delay8_t_1 <= 32'sd1; Delay8_t_1 = Delay8_t_1 + 32'sd1) begin
      Delay8_reg[Delay8_t_1] = 3'b000;
    end


    for(Delay2_t_1 = 32'sd0; Delay2_t_1 <= 32'sd1; Delay2_t_1 = Delay2_t_1 + 32'sd1) begin
      Delay2_reg[Delay2_t_1] = 16'b0000000000000000;
    end

    Delay1_out1 = 17'b00000000000000000;

    for(Delay3_t_1 = 32'sd0; Delay3_t_1 <= 32'sd1; Delay3_t_1 = Delay3_t_1 + 32'sd1) begin
      Delay3_reg[Delay3_t_1] = 16'b0000000000000000;
    end

    Delay4_out1 = 16'b0000000000000000;
    Delay5_out1 = 17'b00000000000000000;
  end

  always @(posedge clk)
    begin : Delay8_process
      if (enb) begin
        for(Delay8_t_0_0 = 32'sd0; Delay8_t_0_0 <= 32'sd1; Delay8_t_0_0 = Delay8_t_0_0 + 32'sd1) begin
          Delay8_reg[Delay8_t_0_0] <= Delay8_reg_next[Delay8_t_0_0];
        end
      end
    end

  assign Delay8_out1 = Delay8_reg[1];
  assign Delay8_reg_next[0] = curR;
  assign Delay8_reg_next[1] = Delay8_reg[0];



  always @(posedge clk)
    begin : Delay2_process
      if (enb) begin
        for(Delay2_t_0_0 = 32'sd0; Delay2_t_0_0 <= 32'sd1; Delay2_t_0_0 = Delay2_t_0_0 + 32'sd1) begin
          Delay2_reg[Delay2_t_0_0] <= Delay2_reg_next[Delay2_t_0_0];
        end
      end
    end

  assign Delay2_out1 = Delay2_reg[1];
  assign Delay2_reg_next[0] = maxC;
  assign Delay2_reg_next[1] = Delay2_reg[0];



  assign Product_mul_temp = Delay8_out1 * Delay2_out1;
  assign Product_out1 = Product_mul_temp[16:0];



  always @(posedge clk)
    begin : Delay1_process
      if (enb) begin
        Delay1_out1 <= Product_out1;
      end
    end



  always @(posedge clk)
    begin : Delay3_process
      if (enb) begin
        for(Delay3_t_0_0 = 32'sd0; Delay3_t_0_0 <= 32'sd1; Delay3_t_0_0 = Delay3_t_0_0 + 32'sd1) begin
          Delay3_reg[Delay3_t_0_0] <= Delay3_reg_next[Delay3_t_0_0];
        end
      end
    end

  assign Delay3_out1 = Delay3_reg[1];
  assign Delay3_reg_next[0] = curC;
  assign Delay3_reg_next[1] = Delay3_reg[0];



  always @(posedge clk)
    begin : Delay4_process
      if (enb) begin
        Delay4_out1 <= Delay3_out1;
      end
    end



  assign Add_1 = {1'b0, Delay4_out1};
  assign Add_out1 = Delay1_out1 + Add_1;



  always @(posedge clk)
    begin : Delay5_process
      if (enb) begin
        Delay5_out1 <= Add_out1;
      end
    end



  assign addr = Delay5_out1;

endmodule  // dvbs2hdlTransmitterCore_Compute_Read_Offset_Address

