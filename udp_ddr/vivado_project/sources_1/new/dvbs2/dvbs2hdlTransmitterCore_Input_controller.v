// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_Input_controller.v
// Created: 2024-01-10 13:49:57
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_Input_controller
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/FEC Encoder/DVB-S2 BCH Encoder/Input controller
// Hierarchy Level: 5
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_Input_controller
          (clk,
           reset,
           enb,
           ctrlIn_start,
           ctrlIn_end,
           ctrlIn_valid,
           frameType,
           codeRateIdx,
           iwr_enb,
           iwr_addr,
           ird_addr,
           ird_valid,
           framLenDelayed,
           reset_1,
           parLen);


  input   clk;
  input   reset;
  input   enb;
  input   ctrlIn_start;
  input   ctrlIn_end;
  input   ctrlIn_valid;
  input   frameType;
  input   [3:0] codeRateIdx;  // ufix4
  output  iwr_enb;
  output  [15:0] iwr_addr;  // uint16
  output  [15:0] ird_addr;  // uint16
  output  ird_valid;
  output  [15:0] framLenDelayed;  // uint16
  output  reset_1;
  output  [7:0] parLen;  // uint8


  wire sampledStartIn;  // ufix1
  wire sampledEndIn;  // ufix1
  wire enbBCHEnc;  // ufix1
  wire reset_2;  // ufix1
  wire Data_Type_Conversion6_out1;
  wire valid;
  wire Logical_Operator6_out1;
  reg  Delay3_out1;
  wire Data_Type_Conversion4_out1;
  wire Data_Type_Conversion7_out1;
  wire start;
  wire end_rsvd;
  wire Logical_Operator3_out1;
  wire Logical_Operator_out1;
  wire [15:0] count_step;  // uint16
  wire [15:0] count_from;  // uint16
  wire [15:0] count_reset;  // uint16
  reg [15:0] Input_bit_Count_out1;  // uint16
  wire [15:0] count;  // uint16
  wire need_to_wrap;
  wire [15:0] count_value;  // uint16
  wire [15:0] count_1;  // uint16
  wire [15:0] count_2;  // uint16
  wire [15:0] inpFrameLength;  // uint16
  wire [7:0] inpParityLength;  // uint8
  wire validateFrameFlag;  // ufix1
  reg [15:0] Delay1_out1;  // uint16
  wire Compare_To_Constant5_out1;
  wire [15:0] Constant12_out1;  // uint16
  wire [15:0] Switch6_out1;  // uint16
  wire Relational_Operator_relop1;
  wire Logical_Operator4_out1;
  wire Data_Type_Conversion5_out1;
  reg  Delay2_out1;
  wire Data_Type_Conversion2_out1;
  reg  Delay6_out1;
  wire Logical_Operator1_out1;
  wire count_step_1;  // ufix1
  wire count_from_1;  // ufix1
  wire count_reset_1;  // ufix1
  wire [15:0] count_step_2;  // uint16
  wire [15:0] count_from_2;  // uint16
  wire [15:0] count_reset_2;  // uint16
  reg [15:0] input_bit_read_counter_out1;  // uint16
  wire [15:0] count_3;  // uint16
  wire need_to_wrap_1;
  wire [15:0] count_value_1;  // uint16
  wire Data_Type_Conversion_out1;
  wire [15:0] count_4;  // uint16
  reg  proper_Input_Binary_flag_out1;  // ufix1
  wire count_5;  // ufix1
  wire need_to_wrap_2;
  wire count_value_2;  // ufix1
  wire count_6;  // ufix1
  wire Logical_Operator2_out1;
  wire count_7;  // ufix1
  wire Relational_Operator1_relop1;
  wire Logical_Operator5_out1;
  wire [15:0] count_8;  // uint16
  reg [7:0] Delay4_out1;  // uint8

  // Input Sample Bus Controller
  // Compare input frame length with read Counter 
  // Compare input frame length with write Counter 
  // Sample Frame type and code rate and calculate framelength
  // Write address generation for the input data bits
  // Read address generation for the stored input bits


  dvbs2hdlTransmitterCore_sample_bus_controller_function u_sample_bus_controller_function (.clk(clk),
                                                                                           .reset(reset),
                                                                                           .enb(enb),
                                                                                           .startIn(ctrlIn_start),
                                                                                           .endIn(ctrlIn_end),
                                                                                           .validIn(ctrlIn_valid),
                                                                                           .sampledStartIn(sampledStartIn),  // ufix1
                                                                                           .sampledEndIn(sampledEndIn),  // ufix1
                                                                                           .enbBCHEnc(enbBCHEnc),  // ufix1
                                                                                           .reset_1(reset_2)  // ufix1
                                                                                           );

  assign Data_Type_Conversion6_out1 = enbBCHEnc;



  assign valid = ctrlIn_valid;

  assign Logical_Operator6_out1 = Data_Type_Conversion6_out1 & valid;



  always @(posedge clk or posedge reset)
    begin : Delay3_process
      if (reset == 1'b1) begin
        Delay3_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay3_out1 <= Logical_Operator6_out1;
        end
      end
    end



  assign iwr_enb = Delay3_out1;

  assign Data_Type_Conversion4_out1 = sampledStartIn;



  assign Data_Type_Conversion7_out1 = reset_2;



  assign start = ctrlIn_start;

  assign end_rsvd = ctrlIn_end;

  assign Logical_Operator3_out1 = valid & (start & end_rsvd);



  assign Logical_Operator_out1 = Logical_Operator3_out1 | (Data_Type_Conversion4_out1 | Data_Type_Conversion7_out1);



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 65535
  assign count_step = 16'b0000000000000001;



  assign count_from = 16'b0000000000000000;



  assign count_reset = 16'b0000000000000000;



  assign count = Input_bit_Count_out1 + count_step;



  assign need_to_wrap = Input_bit_Count_out1 == 16'b1111111111111111;



  assign count_value = (need_to_wrap == 1'b0 ? count :
              count_from);



  assign count_1 = (Delay3_out1 == 1'b0 ? Input_bit_Count_out1 :
              count_value);



  assign count_2 = (Logical_Operator_out1 == 1'b0 ? count_1 :
              count_reset);



  always @(posedge clk or posedge reset)
    begin : Input_bit_Count_process
      if (reset == 1'b1) begin
        Input_bit_Count_out1 <= 16'b0000000000000000;
      end
      else begin
        if (enb) begin
          Input_bit_Count_out1 <= count_2;
        end
      end
    end



  assign iwr_addr = Input_bit_Count_out1;

  dvbs2hdlTransmitterCore_Sample_Frame_type_and_code_rate u_Sample_Frame_type_and_code_rate (.clk(clk),
                                                                                             .reset(reset),
                                                                                             .enb(enb),
                                                                                             .Enable(Data_Type_Conversion4_out1),
                                                                                             .frameTypeIn(frameType),
                                                                                             .codeRateIdxIn(codeRateIdx),  // ufix4
                                                                                             .inpFrameLength(inpFrameLength),  // uint16
                                                                                             .inpParityLength(inpParityLength),  // uint8
                                                                                             .validateFrameFlag(validateFrameFlag)  // ufix1
                                                                                             );

  always @(posedge clk or posedge reset)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_out1 <= 16'b0000000000000000;
      end
      else begin
        if (enb) begin
          Delay1_out1 <= inpFrameLength;
        end
      end
    end



  assign Compare_To_Constant5_out1 = Delay1_out1 > 16'b0000000000000000;



  assign Constant12_out1 = 16'b0000000000000000;



  assign Switch6_out1 = (Compare_To_Constant5_out1 == 1'b0 ? Constant12_out1 :
              Delay1_out1);



  assign Relational_Operator_relop1 = Input_bit_Count_out1 == Switch6_out1;



  assign Logical_Operator4_out1 = Relational_Operator_relop1 & Delay3_out1;



  assign Data_Type_Conversion5_out1 = sampledEndIn;



  always @(posedge clk or posedge reset)
    begin : Delay2_process
      if (reset == 1'b1) begin
        Delay2_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay2_out1 <= Data_Type_Conversion5_out1;
        end
      end
    end



  assign Data_Type_Conversion2_out1 = validateFrameFlag;



  always @(posedge clk or posedge reset)
    begin : Delay6_process
      if (reset == 1'b1) begin
        Delay6_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay6_out1 <= Data_Type_Conversion2_out1;
        end
      end
    end



  assign Logical_Operator1_out1 = Delay6_out1 & (Logical_Operator4_out1 & Delay2_out1);



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 1
  assign count_step_1 = 1'b1;



  assign count_from_1 = 1'b0;



  assign count_reset_1 = 1'b0;



  // Count limited, Unsigned Counter
  //  initial value   = 0
  //  step value      = 1
  //  count to value  = 65535
  assign count_step_2 = 16'b0000000000000001;



  assign count_from_2 = 16'b0000000000000000;



  assign count_reset_2 = 16'b0000000000000000;



  assign count_3 = input_bit_read_counter_out1 + count_step_2;



  assign need_to_wrap_1 = input_bit_read_counter_out1 == 16'b1111111111111111;



  assign count_value_1 = (need_to_wrap_1 == 1'b0 ? count_3 :
              count_from_2);



  assign count_4 = (Data_Type_Conversion_out1 == 1'b0 ? input_bit_read_counter_out1 :
              count_value_1);



  assign count_5 = proper_Input_Binary_flag_out1 ^ count_step_1;



  assign need_to_wrap_2 = proper_Input_Binary_flag_out1 == 1'b1;



  assign count_value_2 = (need_to_wrap_2 == 1'b0 ? count_5 :
              count_from_1);



  assign count_6 = (Logical_Operator1_out1 == 1'b0 ? proper_Input_Binary_flag_out1 :
              count_value_2);



  assign count_7 = (Logical_Operator2_out1 == 1'b0 ? count_6 :
              count_reset_1);



  always @(posedge clk or posedge reset)
    begin : proper_Input_Binary_flag_process
      if (reset == 1'b1) begin
        proper_Input_Binary_flag_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          proper_Input_Binary_flag_out1 <= count_7;
        end
      end
    end



  assign Data_Type_Conversion_out1 = proper_Input_Binary_flag_out1;



  assign Relational_Operator1_relop1 = input_bit_read_counter_out1 >= Switch6_out1;



  assign Logical_Operator5_out1 = Relational_Operator1_relop1 & Data_Type_Conversion_out1;



  assign Logical_Operator2_out1 = Logical_Operator5_out1 | Logical_Operator_out1;



  assign count_8 = (Logical_Operator2_out1 == 1'b0 ? count_4 :
              count_reset_2);



  always @(posedge clk or posedge reset)
    begin : input_bit_read_counter_process
      if (reset == 1'b1) begin
        input_bit_read_counter_out1 <= 16'b0000000000000000;
      end
      else begin
        if (enb) begin
          input_bit_read_counter_out1 <= count_8;
        end
      end
    end



  assign ird_addr = input_bit_read_counter_out1;

  assign ird_valid = Data_Type_Conversion_out1;

  assign framLenDelayed = Switch6_out1;

  always @(posedge clk or posedge reset)
    begin : Delay4_process
      if (reset == 1'b1) begin
        Delay4_out1 <= 8'b00000000;
      end
      else begin
        if (enb) begin
          Delay4_out1 <= inpParityLength;
        end
      end
    end



  assign parLen = Delay4_out1;

  assign reset_1 = Logical_Operator_out1;

endmodule  // dvbs2hdlTransmitterCore_Input_controller

