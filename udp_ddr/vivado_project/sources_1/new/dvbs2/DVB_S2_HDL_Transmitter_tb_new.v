`timescale 1 ns / 1 ns
module DVB_S2_HDL_Transmitter_tb_new;

reg             clk;
reg             reset;
// reg             clk_enable;
// reg             pktBitsIn;
// reg             pktStartIn;
// reg             pktEndIn;
// reg             pktValidIn;
// reg             frameStartIn;
// reg             frameEndIn;
reg [5:0]       pktIn;
wire            validOut;
wire            ce_out_0;
wire            nextFrame;
wire [18:0]     dataOut_re;
wire [18:0]     dataOut_im;

// reg signed [31:0] fp_pktBitsIn;  // sfix32
// reg signed [31:0] fp_pktStartIn;  // sfix32
// reg signed [31:0] fp_pktEndIn;  // sfix32
// reg signed [31:0] fp_pktValidIn;  // sfix32
// reg signed [31:0] fp_frameStartIn;  // sfix32
// reg signed [31:0] fp_frameEndIn;  // sfix32
reg signed [31:0] fp_pktIn;  // sfix32
// reg signed [31:0] status_pktBitsIn;  // sfix32
// reg signed [31:0] status_pktStartIn;  // sfix32
// reg signed [31:0] status_pktEndIn;  // sfix32
// reg signed [31:0] status_pktValidIn;  // sfix32
// reg signed [31:0] status_frameStartIn;  // sfix32
// reg signed [31:0] status_frameEndIn;  // sfix32
reg signed [31:0] status_pktIn;  // sfix32

initial begin
    reset <= 1'b1;
    // clk_enable <= 1'b0;
    # (20);
    @ (posedge clk)
    # (2);
    reset <= 1'b0;
    // # (8);
    // clk_enable <= 1'b1;
end

always begin : clk_gen
    clk <= 1'b1;
    # (5);
    clk <= 1'b0;
    # (5);
end

initial begin
// cnt<=6'd0;
    // fp_pktBitsIn = $fopen("pktBitsIn.dat", "r");
    // fp_pktStartIn = $fopen("pktStartIn.dat", "r");
    // fp_pktEndIn = $fopen("pktEndIn.dat", "r");
    // fp_pktValidIn = $fopen("pktValidIn.dat", "r");
    // fp_frameStartIn = $fopen("frameStartIn.dat", "r");
    // fp_frameEndIn = $fopen("frameEndIn.dat", "r");
    fp_pktIn = $fopen("pktIn_bin.dat", "r");
    // status_pktBitsIn = $rewind(fp_pktBitsIn);
    // status_pktStartIn = $rewind(fp_pktStartIn);
    // status_pktEndIn = $rewind(fp_pktEndIn);
    // status_pktValidIn = $rewind(fp_pktValidIn);
    // status_frameStartIn = $rewind(fp_frameStartIn);
    // status_frameEndIn = $rewind(fp_frameEndIn);
    status_pktIn = $rewind(fp_pktIn);
end
reg   [3:0]   cnt;
always @(posedge ~clk) begin
    // status_pktBitsIn = $fscanf(fp_pktBitsIn, "%h", pktBitsIn);
    // status_pktStartIn = $fscanf(fp_pktStartIn, "%h", pktStartIn);
    // status_pktEndIn = $fscanf(fp_pktEndIn, "%h", pktEndIn);
    // status_pktValidIn = $fscanf(fp_pktValidIn, "%h", pktValidIn);
    // status_frameStartIn = $fscanf(fp_frameStartIn, "%h", frameStartIn);
    // status_frameEndIn = $fscanf(fp_frameEndIn, "%h", frameEndIn);
//    cnt<=cnt+1;
//    if(cnt>4)
         status_pktIn = $fscanf(fp_pktIn, "%b", pktIn);
//    else
//         pktIn<=6'd0;
         
end

// DVB_S2_HDL_Transmitter_wrapper DVB_S2_HDL_Transmitter_wrapper_inst (
//     .clk                (clk),
//     .reset              (reset),
//     // .clk_enable         (clk_enable),
//     // .pktBitsIn          (pktBitsIn),
//     // .pktStartIn         (pktStartIn),
//     // .pktEndIn           (pktEndIn),
//     // .pktValidIn         (pktValidIn),
//     // .frameStartIn       (frameStartIn),
//     // .frameEndIn         (frameEndIn),
//     .pktIn              (pktIn),
//     .validOut           (validOut),
//     .ce_out_0           (ce_out_0),
//     .nextFrame          (nextFrame),
//     .dataOut_re         (dataOut_re),
//     .dataOut_im         (dataOut_im)
// );
dvbs2_tx_v1_0_0 dvbs2_tx_v1_0_0_inst (
  .clk(clk),                // input wire clk
  .reset(reset),            // input wire reset
  .clk_enable(1'd1),  // input wire clk_enable
  .pktIn(pktIn),            // input wire [5 : 0] pktIn
  .validOut(validOut),      // output wire validOut
  .ce_out_0(ce_out_0),      // output wire ce_out_0
  .nextFrame(nextFrame),    // output wire nextFrame
  .dataOut_re(dataOut_re),  // output wire [18 : 0] dataOut_re
  .dataOut_im(dataOut_im)  // output wire [18 : 0] dataOut_im
);
integer file_out_i;
integer file_out_q;
initial begin
    file_out_i = $fopen("D:\\Workspace\\Xilinx_Project\\Zynq7035\\MATLAB_SOURCE\\SIM\\DVBS2_matlab_sim\\DVBS2_matlab_sim.srcs\\sources_1\\new\\verilog_output2_i.txt", "w");
    file_out_q = $fopen("D:\\Workspace\\Xilinx_Project\\Zynq7035\\MATLAB_SOURCE\\SIM\\DVBS2_matlab_sim\\DVBS2_matlab_sim.srcs\\sources_1\\new\\verilog_output2_q.txt", "w");
end

reg [18:0]          cnt_symb;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cnt_symb <= 0;
    end else if (validOut == 1 && ce_out_0 == 1) begin
        if (cnt_symb == 19'b1010111111000001000) begin
            $fclose(file_out_i);
            $fclose(file_out_q);
            // $finish;
        end else begin
            $fwrite(file_out_i, "%h\n", dataOut_re);
            $fwrite(file_out_q, "%h\n", dataOut_im);
            cnt_symb <= cnt_symb + 1;
        end
    end
end

endmodule