module DVB_S2_HDL_Transmitter_wrapper (
    input           clk,
    input           reset,
    input           clk_enable,
    // input           pktBitsIn,
    // input           pktStartIn,
    // input           pktEndIn,
    // input           pktValidIn,
    // input           frameStartIn,
    // input           frameEndIn,
    input [5:0]     pktIn,
    output          validOut,
    output          ce_out_0,
    output          nextFrame,
    output [18:0]   dataOut_re,
    output [18:0]   dataOut_im
);

wire    ce_out_1;
wire    ce_out_2;
wire    flag;

DVB_S2_HDL_Transmitter u_DVB_S2_HDL_Transmitter (
    .clk                            (clk),
    .reset                          (reset),
    .clk_enable                     (clk_enable),
    .pktBitsIn                      (pktIn[5]),
    .pktStartIn                     (pktIn[4]),
    .pktEndIn                       (pktIn[3]),
    .pktValidIn                     (pktIn[2]),
    .frameStartIn                   (pktIn[1]),
    .frameEndIn                     (pktIn[0]),
    .TSorGS                         (2'd3),  // ufix2
    .DFL                            (16'ha7d0),  // uint16
    .UPL                            (16'h05e0),  // uint16
    .SYNC                           (8'h47),  // uint8
    .MODCOD                         (5'd6),  // ufix5
    .FECFrame                       (1'd0),
    .ce_out_0                       (ce_out_0),
    .ce_out_1                       (ce_out_1),
    .ce_out_2                       (ce_out_2),
    .dataOut_re                     (dataOut_re),  // sfix18_En14
    .dataOut_im                     (dataOut_im),  // sfix18_En14
    .validOut                       (validOut),
    .flag                           (flag),  // ufix2
    .nextFrame                      (nextFrame)
);

endmodule