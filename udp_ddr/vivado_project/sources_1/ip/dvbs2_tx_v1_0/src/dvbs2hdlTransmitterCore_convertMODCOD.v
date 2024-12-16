// -------------------------------------------------------------
// 
// File Name: F:\FileFolder\DVB\dvbs2_tx_new\hdlsrc\dvbs2hdlTransmitter\dvbs2hdlTransmitterCore\dvbs2hdlTransmitterCore_convertMODCOD.v
// Created: 2024-01-10 13:49:59
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: dvbs2hdlTransmitterCore_convertMODCOD
// Source Path: dvbs2hdlTransmitterCore/DVB-S2 Tx/MODCOD Source Coder/convertMODCOD
// Hierarchy Level: 4
// Model version: 4.5
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_convertMODCOD
          (modcod,
           modIdx,
           codIdx);


  input   [4:0] modcod;  // ufix5
  output  [1:0] modIdx;  // ufix2
  output  [3:0] codIdx;  // ufix4


  reg [1:0] modIdx_1;  // ufix2
  reg [3:0] codIdx_1;  // ufix4


  always @(modcod) begin
    if (modcod < 5'b01100) begin
      modIdx_1 = 2'b00;
    end
    else if (modcod < 5'b10010) begin
      modIdx_1 = 2'b01;
    end
    else if (modcod < 5'b11000) begin
      modIdx_1 = 2'b10;
    end
    else begin
      modIdx_1 = 2'b11;
    end
    case ( modcod)
      5'b00001 :
        begin
          codIdx_1 = 4'b0000;
          // 1/4
        end
      5'b00010 :
        begin
          codIdx_1 = 4'b0001;
          // 1/3
        end
      5'b00011 :
        begin
          codIdx_1 = 4'b0010;
          // 2/5
        end
      5'b00100 :
        begin
          codIdx_1 = 4'b0011;
          // 1/2
        end
      5'b00101 :
        begin
          codIdx_1 = 4'b0100;
          // 3/5
        end
      5'b01100 :
        begin
          codIdx_1 = 4'b0100;
          // 3/5
        end
      5'b00110 :
        begin
          codIdx_1 = 4'b0101;
          // 2/3
        end
      5'b01101 :
        begin
          codIdx_1 = 4'b0101;
          // 2/3
        end
      5'b10010 :
        begin
          codIdx_1 = 4'b0101;
          // 2/3
        end
      5'b00111 :
        begin
          codIdx_1 = 4'b0110;
          // 3/4
        end
      5'b01110 :
        begin
          codIdx_1 = 4'b0110;
          // 3/4
        end
      5'b10011 :
        begin
          codIdx_1 = 4'b0110;
          // 3/4
        end
      5'b11000 :
        begin
          codIdx_1 = 4'b0110;
          // 3/4
        end
      5'b01000 :
        begin
          codIdx_1 = 4'b0111;
          // 4/5
        end
      5'b10100 :
        begin
          codIdx_1 = 4'b0111;
          // 4/5
        end
      5'b11001 :
        begin
          codIdx_1 = 4'b0111;
          // 4/5
        end
      5'b01001 :
        begin
          codIdx_1 = 4'b1000;
          // 5/6
        end
      5'b01111 :
        begin
          codIdx_1 = 4'b1000;
          // 5/6
        end
      5'b10101 :
        begin
          codIdx_1 = 4'b1000;
          // 5/6
        end
      5'b11010 :
        begin
          codIdx_1 = 4'b1000;
          // 5/6
        end
      5'b01010 :
        begin
          codIdx_1 = 4'b1001;
          // 8/9
        end
      5'b10000 :
        begin
          codIdx_1 = 4'b1001;
          // 8/9
        end
      5'b10110 :
        begin
          codIdx_1 = 4'b1001;
          // 8/9
        end
      5'b11011 :
        begin
          codIdx_1 = 4'b1001;
          // 8/9
        end
      5'b01011 :
        begin
          codIdx_1 = 4'b1010;
          // 9/10
        end
      5'b10001 :
        begin
          codIdx_1 = 4'b1010;
          // 9/10
        end
      5'b10111 :
        begin
          codIdx_1 = 4'b1010;
          // 9/10
        end
      5'b11100 :
        begin
          codIdx_1 = 4'b1010;
          // 9/10
        end
      default :
        begin
          codIdx_1 = 4'b0000;
          // use this as default
        end
    endcase
  end



  assign modIdx = modIdx_1;

  assign codIdx = codIdx_1;

endmodule  // dvbs2hdlTransmitterCore_convertMODCOD
