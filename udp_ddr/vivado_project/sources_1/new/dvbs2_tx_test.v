`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/26 10:02:15
// Design Name: 
// Module Name: dvbs2_tx_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dvbs2_tx_test(
        output          [14:0]           DDR3_0_addr,
        output          [2 :0]           DDR3_0_ba,
        output                           DDR3_0_cas_n,
        output          [0 :0]           DDR3_0_ck_n,
        output          [0 :0]           DDR3_0_ck_p,
        output          [0 :0]           DDR3_0_cke,
        output          [0 :0]           DDR3_0_cs_n,
        output          [7 :0]           DDR3_0_dm,
        inout           [63:0]           DDR3_0_dq,
        inout           [7 :0]           DDR3_0_dqs_n,
        inout           [7 :0]           DDR3_0_dqs_p,
        output          [0 :0]           DDR3_0_odt,
        output                           DDR3_0_ras_n,
        output                           DDR3_0_reset_n,
        output                           DDR3_0_we_n,
        input                            sysclk_p,
        input                            sysclk_n,
        output                           O_phy_rst,//以太网芯片复位信号，低电平有?? 
//PHYA        
        input            [3:0]           PHYA_rgmii_rxd,   //RGMII输入数据
        input                            PHYA_rgmii_rx_ctl,//RGMII输入数据有效信号
        input                            PHYA_rgmii_rxc,   //RGMII接收数据时钟
        output           [3:0]           PHYA_rgmii_txd,   //RGMII输出数据 
        output                           PHYA_rgmii_tx_ctl,//RGMII输出数据有效信号
        output                           PHYA_rgmii_txc   //RGMII发送数据时?? 
);

wire [31:0]   fdma_raddr;
reg           fdma_rareq;
wire          fdma_rbusy;
wire [127:0]  fdma_rdata;
wire [15:0]   fdma_rsize;
wire          fdma_rvalid;
 wire [31:0]   fdma_waddr;
reg           fdma_wareq;
wire          fdma_wbusy;
wire [127:0]  fdma_wdata;
wire [15:0]   fdma_wsize;
wire          fdma_wvalid;
wire [0:0]    fdma_rstn;
wire          ui_clk;
wire          I_sysclk;

parameter TEST_MEM_SIZE   = 32'd1024*1024*1024*2;
parameter FDMA_BURST_LEN  = 16'd512;
parameter ADDR_MEM1_OFFSET = 1000;
parameter ADDR_MEM2_OFFSET = 32'h100000;
parameter ADDR_INC = FDMA_BURST_LEN * 16;

reg [31: 0] fdma_waddr_r;
reg [31: 0] fdma_raddr_r;

parameter   IDLE    = 0;
parameter   WRITE1  = 1;
parameter   WRITE2  = 2;
parameter   WAIT    = 3;
parameter   READ1   = 4;
parameter   READ2   = 5;
parameter   ARBIT   = 6;
parameter   WRITE3  = 7;
parameter   WRITE4  = 8;
parameter   READ3   = 9;
parameter   READ4   = 10;   
 (*mark_debug = "true"*)reg     [3:0]  STATE;
reg [8:0]           rst_cnt = 0;
(*mark_debug = "true"*) reg                 ddr_write_end;
(*mark_debug = "true"*) reg                 ddr_read_end;
wire                reset;
wire                locked;

reg [15:0]          delay_cnt;
wire                clk_15_625;
wire                clk_200;
wire                clk_125;
wire                clk_125_90;
wire                clk_25;
wire                core_reset;
(*mark_debug = "true"*)wire   [55:0]       tx_data_len;
wire                dvbs2_fifo_rst;
(*mark_debug = "true"*)wire  [10:0]        dvbs2_fifo_rd_count;
wire                dvbs2_fifo_wr_clk;
wire                dvbs2_fifo_rd_clk;
wire   [63:0]       dvbs2_fifo_wr_din;
(*mark_debug = "true"*)wire   [127:0]      dvbs2_fifo_rd_dout;
(*mark_debug = "true"*)wire                dvbs2_fifo_rd_en;
wire                dvbs2_fifo_wr_en;
 reg       [55:0]    udp_cnt;
wire                ddr_input_fifo_wr_en;
wire   [63:0]       ddr_input_fifo_wr_din;
wire                ddr_input_fifo_wr_clk;
wire                ddr_input_fifo_rd_clk;
wire                ddr_input_fifo_rst;
wire    [10:0]      ddr_input_fifo_rd_count;
wire                ddr_input_fifo_rd_en;
wire    [127:0]     ddr_input_fifo_rd_dout;
wire                ddr_output_fifo_wr_clk;
wire                ddr_output_fifo_rd_clk;
wire                ddr_output_fifo_rst;
(*mark_debug = "true"*)wire                ddr_output_fifo_wr_en;
(*mark_debug = "true"*)wire    [127:0]     ddr_output_fifo_wr_din;
wire    [10:0]      ddr_output_fifo_wr_count;
wire    [11:0]      ddr_output_fifo_rd_count;
(*mark_debug = "true"*)wire                ddr_output_fifo_rd_en;
(*mark_debug = "true"*)wire    [63:0]      ddr_output_fifo_rd_dout;
wire                udp_valid_out;
wire  [63:0]        udp_data_out; 
wire                dvbs2_data_clk;
wire                dvbs2_clk;
reg   [63:0]        dvbs2_data_in;
reg   [5:0]         pktIn;
//  wire                dvbs2_valid_in;
 wire   [18:0]       dvbs2_data_out_re;
 wire   [18:0]       dvbs2_data_out_im;
wire                dvbs2_valid_out; 
wire                dvbs2_ce_out; 
wire                dvbs2_endout;               
reg                 dvbs2_data_req;
reg                 clk_enable;
(*mark_debug = "true"*)reg                 fifo_switch;
 (*mark_debug = "true"*)wire                udp_data_in_req;
wire   [63:0]       udp_data_in;
(*mark_debug = "true"*) reg                 udp_read_ready;
reg   [2:0]         dvbs2_in_state;
reg   [3:0]         dvbs2_in_delay_cnt;
 (*mark_debug = "true"*)wire    [11:0]      udp_packet_fifo_rd_count;  
(*mark_debug = "true"*) reg                 start_flag;
reg                 dvbs2_reset;
(*mark_debug = "true"*)reg                 fifo_change;
 (*mark_debug = "true"*)wire                udp_packet_fifo_rst;
(*mark_debug = "true"*)reg                 ddr_full;
(*mark_debug = "true"*) wire                udp_packet_fifo_wr_en;
(*mark_debug = "true"*) wire   [127:0]      udp_packet_fifo_wr_din;
assign              udp_packet_fifo_rst = core_reset;
assign              udp_packet_fifo_wr_din = (fifo_switch == 1'b1)?fdma_rdata:256'd0;
assign              udp_packet_fifo_wr_en = (fifo_switch==1'b1)?fdma_rvalid:1'b0;
// assign              udp_read_ready=((fifo_switch==1'b1)&(ddr_output_fifo_rd_count>0))?1'b1:1'b0;

// assign              clk_enable = 1'b1;
assign              dvbs2_valid_in = ((dvbs2_data_req==1'b1)&(ddr_read_end==1'b0))?1'b1:1'b0;
// assign              dvbs2_data_in = (dvbs2_valid_in==1'b1)?ddr_output_fifo_rd_dout:64'd0;
assign              dvbs2_clk = clk_25;
// assign              dvbs2_data_clk = clk_15_625;
assign              ddr_input_fifo_rst = ~fdma_rstn;
// assign              ddr_input_fifo_wr_clk = (fifo_switch==1'b0)?clk_15_625:dvbs2_clk;
assign              ddr_input_fifo_wr_clk = clk_15_625;

assign              ddr_input_fifo_rd_clk = ui_clk;   
// assign              ddr_input_fifo_wr_en  =  (fifo_switch==1'b0)?udp_valid_out:_64bit_valid_out;
// assign              ddr_input_fifo_wr_din = (fifo_switch==1'b0)?udp_data_out:_64bit_data_out;  
assign              ddr_input_fifo_wr_en  = udp_valid_out;
assign              ddr_input_fifo_wr_din = udp_data_out;  
assign              ddr_input_fifo_rd_en = (fifo_change==0)?fdma_wvalid:1'b0;
assign              ddr_output_fifo_wr_clk = ui_clk;
// assign              ddr_output_fifo_rd_clk = (fifo_switch==1'b0)?dvbs2_data_clk:clk_15_625;
assign              ddr_output_fifo_rd_clk = ~dvbs2_clk;

assign              ddr_output_fifo_rst = (~fdma_rstn)||ddr_read_end||start_flag;
assign              ddr_output_fifo_wr_en =  (fifo_switch == 1'b0)? fdma_rvalid:1'b0;
assign              ddr_output_fifo_wr_din =  fdma_rdata; 
// assign              ddr_output_fifo_rd_en = (fifo_switch==1'b0)?dvbs2_data_req:udp_data_in_req;
assign              ddr_output_fifo_rd_en = dvbs2_data_req;
assign               dvbs2_fifo_rst = (~fdma_rstn)||start_flag; 
assign               dvbs2_fifo_wr_clk =  dvbs2_clk;
assign               dvbs2_fifo_rd_clk =  ui_clk;
assign               dvbs2_fifo_wr_en  = dvbs2_valid_out & dvbs2_ce_out & ddr_full;
assign               dvbs2_fifo_rd_en  = (fifo_change==1)?fdma_wvalid:1'b0;
assign               dvbs2_fifo_wr_din = {16'd0,{5'd0,dvbs2_data_out_re},{5'd0,dvbs2_data_out_im}};
assign fdma_waddr = (fifo_change==1'b0)?(fdma_waddr_r + ADDR_MEM1_OFFSET):(fdma_waddr_r + ADDR_MEM2_OFFSET);
assign fdma_raddr = (fifo_switch==1'b0)?(fdma_raddr_r + ADDR_MEM1_OFFSET):(fdma_raddr_r + ADDR_MEM2_OFFSET);

assign fdma_wsize = FDMA_BURST_LEN;
assign fdma_rsize = FDMA_BURST_LEN;
assign fdma_wdata = (fifo_change==1'b0)?ddr_input_fifo_rd_dout:dvbs2_fifo_rd_dout; 
  

//上电延迟复位
assign  O_phy_rst = (delay_cnt == 10'd100)? 1'b1 : 1'b0;
//复位计数??
always @(posedge clk_25) begin
   if(!locked) 
         delay_cnt <= 10'd0;
   else begin
		 if(delay_cnt == 10'd100)
			delay_cnt <= delay_cnt;
		 else
		    delay_cnt <= delay_cnt + 1'b1;
   end
end
always @(posedge ui_clk)
    if(~fdma_rstn)begin
        rst_cnt <=0;
    end 
    else begin
        if(rst_cnt[8] == 1'b0)
            rst_cnt <= rst_cnt + 1'b1;
        else 
            rst_cnt <= rst_cnt;
    end

always@(posedge clk_15_625 or posedge core_reset)begin
    if(core_reset)
        ddr_write_end<=1'b0;
    else if(ddr_input_fifo_wr_en)begin
        if(ddr_input_fifo_wr_din[63]==1'b1)
            ddr_write_end<=1'b1;
        else
            ddr_write_end<=ddr_write_end;
    end
    else if(STATE==WAIT)
            ddr_write_end<=1'b0;
    else
        ddr_write_end<=ddr_write_end;
end
always@(negedge dvbs2_clk or posedge core_reset)begin
    if(core_reset)
        ddr_read_end<=1'b0;
    else if(ddr_output_fifo_rd_en)begin
        if(ddr_output_fifo_rd_dout[63]==1'b1)
            ddr_read_end<=1'b1;
        else
            ddr_read_end<=ddr_read_end;
    end
    else if(start_flag)
        ddr_read_end<=1'b0;
    else
        ddr_read_end<=ddr_read_end;
end
always@(posedge clk_15_625 or posedge core_reset)begin
    if(core_reset)begin
        start_flag<=1'b0;
    end
    else if(ddr_input_fifo_wr_en)begin
        if(ddr_input_fifo_wr_din[56]==1'b1)
            start_flag<=1'b1;
        else 
            start_flag<=start_flag;
    end
    else if(ddr_write_end)begin
        start_flag<=1'b0;
    end
    else
        start_flag<=start_flag;
end

reg   [2:0]  bit_cnt;
always@(negedge dvbs2_clk or posedge core_reset)begin
    if(core_reset)begin
        dvbs2_in_state<=3'd0;
        dvbs2_data_req<=1'b0;
        clk_enable<=1'b0;
        dvbs2_reset<=1'b1;
        bit_cnt<=3'd0;
        pktIn<=6'd0;
    end
    else begin
        case(dvbs2_in_state)
            3'd0:begin
                if(start_flag)begin
                    dvbs2_reset<=1'b1;
                    clk_enable<=1'b0;
                    dvbs2_in_state<=3'd1;
                end
                else begin
                    dvbs2_in_state<=3'd0;
                    dvbs2_reset<=1'b0;
                    clk_enable<=clk_enable;
                end
            end
            3'd1:begin
                    dvbs2_reset<=1'b0;
                    if(ddr_output_fifo_rd_count>FDMA_BURST_LEN)begin
                        clk_enable<=1'b1;
                        dvbs2_in_state<=3'd2;
                    end
                    else begin
                        dvbs2_in_state<=3'd1;
                    end
                end
            3'd2:begin
                dvbs2_data_req<=1'b1;
                dvbs2_data_in<=ddr_output_fifo_rd_dout;
                pktIn<=ddr_output_fifo_rd_dout[5:0];
                dvbs2_in_state<=3'd3;
            end
            3'd3:begin
                dvbs2_data_req<=1'b0;
                if(bit_cnt<3'd5)begin
                    dvbs2_data_in<=dvbs2_data_in>>8;
                    bit_cnt<=bit_cnt+1'b1;
                end
                else begin
                    bit_cnt<=3'd0;
                    if(ddr_read_end==1'b1)
                        dvbs2_in_state<=3'd0;
                    else
                        dvbs2_in_state<=3'd2;
                end
                pktIn<=dvbs2_data_in[13:8];
            end
        endcase
    end
end
reg            [18:0]   count;
always@(negedge dvbs2_clk or posedge core_reset)begin
    if(core_reset)
        count<=19'd0;
    else if((dvbs2_valid_out==1)&&(dvbs2_ce_out==1)) begin
        if(count==359944)
            count<=count;
        else
            count<=count+1;
    end
end
always @(posedge ui_clk)begin
    if(rst_cnt[8] == 1'b0)begin
        STATE <=IDLE; 
        fifo_switch<=1'b0;
        fdma_wareq  <= 1'b0; 
        fdma_rareq  <= 1'b0; 
        fdma_waddr_r <=32'd0; 
        fdma_raddr_r <=32'd0; 
        fifo_change<=1'b0;  
        ddr_full<=1'b1;
    end
    else begin
        case(STATE)
        IDLE:begin
            ddr_full<=1'b1;
            if(ddr_write_end==1'b1)begin
                if(ddr_input_fifo_rd_count>0)
                    STATE<=WRITE1;
                else begin
                    fifo_change<=1'b1;
                    STATE<=WAIT;
                    fdma_waddr_r <=32'd0;
                end
            end
            else begin
                fifo_change<=1'b0;
                if(ddr_input_fifo_rd_count>FDMA_BURST_LEN)begin
                    STATE<=WRITE1;
                end
                else begin
                    STATE<=IDLE;
                end
            end          
        end
        WRITE1:begin
            if(!fdma_wbusy)begin
                fdma_wareq<=1'b1;
            end
            if(fdma_wareq&&fdma_wbusy)begin
                fdma_wareq<=1'b0; 
                STATE<= WRITE2;
            end
        end
        WRITE2:begin
            if(!fdma_wbusy) begin
                 STATE<=IDLE;
                 fdma_waddr_r<=fdma_waddr_r+ADDR_INC;
            end 
            else begin
                STATE<= WRITE2;
            end
        end
        WAIT:begin
            if(ddr_read_end)begin
                fdma_raddr_r <=32'd0;
                STATE<=ARBIT;
            end
            else if(dvbs2_fifo_rd_count>FDMA_BURST_LEN)begin
                STATE<=WRITE3;
            end
            else if(ddr_output_fifo_wr_count<FDMA_BURST_LEN-2)
                STATE<=READ1;
            else 
                STATE<=WAIT;
        end

        WRITE3:begin
            if(!fdma_wbusy)begin
                fdma_wareq<=1'b1;
            end
            if(fdma_wareq&&fdma_wbusy)begin
                fdma_wareq<=1'b0; 
                STATE<= WRITE4;
            end
        end
        WRITE4:begin
            if(!fdma_wbusy)begin
                if(ddr_read_end==1)begin
                    STATE<=ARBIT;
                end
                else 
                    STATE<=WAIT;
                fdma_waddr_r<=fdma_waddr_r+ADDR_INC;
            end 
            else begin
                STATE<= WRITE4;
            end
        end
        READ1:begin
            if(!fdma_rbusy)begin
                fdma_rareq  <= 1'b1; 
            end
            if(fdma_rareq&&fdma_rbusy)begin
                 fdma_rareq  <= 1'b0; 
                 STATE <= READ2;
            end 
        end
        READ2:begin
            if(!fdma_rbusy) begin
                if(fifo_switch==1)
                    STATE<=ARBIT;
                else 
                    STATE<=WAIT;
                fdma_raddr_r  <= fdma_raddr_r+ADDR_INC;//128/8=16
            end 
            else begin
                STATE <= READ2;
            end
        end
        ARBIT:begin
            if(fifo_switch==0)
                fdma_raddr_r <=32'd0;           
            if(start_flag)begin
                STATE<=IDLE;
                fifo_switch<=1'b0;
                fdma_waddr_r <=32'd0; 
                fdma_raddr_r <=32'd0; 
            end
            else begin
                if((ddr_full==1'b1)&(dvbs2_fifo_rd_count>FDMA_BURST_LEN))begin
                    fifo_switch<=1'b1;
                    if(fdma_waddr_r[30]==1)
                        ddr_full<=1'b0;
                    else
                        STATE<=WRITE3;
                end
                else if((fifo_switch==1'b1)&(udp_packet_fifo_rd_count<FDMA_BURST_LEN-2))
                    STATE<=READ1;
            end
        end
        endcase
    end
end
fifo_generator_0 ddr_input_fifo(
  .rst(ddr_input_fifo_rst),                      // input wire rst
  .wr_clk(ddr_input_fifo_wr_clk),                // input wire wr_clk
  .rd_clk(ddr_input_fifo_rd_clk),                // input wire rd_clk
  .din(ddr_input_fifo_wr_din),                      // input wire [63 : 0] din
  .wr_en(ddr_input_fifo_wr_en),                  // input wire wr_en
  .rd_en(ddr_input_fifo_rd_en),                  // input wire rd_en
  .dout(ddr_input_fifo_rd_dout),                    // output wire [127 : 0] dout
  .full(),                    // output wire full
  .empty(),                  // output wire empty
  .rd_data_count(ddr_input_fifo_rd_count),  // output wire [9 : 0] rd_data_count
  .wr_data_count()  // output wire [10 : 0] wr_data_count
);
fifo_generator_1 ddr_output_fifo(
  .rst(ddr_output_fifo_rst),                      // input wire rst
  .wr_clk(ddr_output_fifo_wr_clk),                // input wire wr_clk
  .rd_clk(ddr_output_fifo_rd_clk),                // input wire rd_clk
  .din(ddr_output_fifo_wr_din),                      // input wire [127 : 0] din
  .wr_en(ddr_output_fifo_wr_en),                  // input wire wr_en
  .rd_en(ddr_output_fifo_rd_en),                  // input wire rd_en
  .dout(ddr_output_fifo_rd_dout),                    // output wire [63 : 0] dout
  .full(),                    // output wire full
  .empty(),                  // output wire empty
  .rd_data_count(ddr_output_fifo_rd_count),  // output wire [10 : 0] rd_data_count
  .wr_data_count(ddr_output_fifo_wr_count)  // output wire [9 : 0] wr_data_count
);
fifo_generator_0 dvbs2_fifo(
  .rst(dvbs2_fifo_rst||start_flag),                      // input wire rst
  .wr_clk(dvbs2_fifo_wr_clk),                // input wire wr_clk
  .rd_clk(dvbs2_fifo_rd_clk),                // input wire rd_clk
  .din(dvbs2_fifo_wr_din),                      // input wire [63 : 0] din
  .wr_en(dvbs2_fifo_wr_en),                  // input wire wr_en
  .rd_en(dvbs2_fifo_rd_en),                  // input wire rd_en
  .dout(dvbs2_fifo_rd_dout),                    // output wire [127 : 0] dout
  .full(),                    // output wire full
  .empty(),                  // output wire empty
  .rd_data_count(dvbs2_fifo_rd_count),  // output wire [9 : 0] rd_data_count
  .wr_data_count()  // output wire [10 : 0] wr_data_count
);


   IBUFDS #(
      .DIFF_TERM("FALSE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(I_sysclk),  // Buffer output
      .I(sysclk_p),  // Diff_p buffer input (connect directly to top-level port)
      .IB(sysclk_n) // Diff_n buffer input (connect directly to top-level port)
   );

// _1bit_to_128bit _1bit_to_128bit_inst(
//         .clk            (dvbs2_clk),
//         .rst_n          (~core_reset),
//         .valid_in       (dvbs2_valid_out),
//         .data_in        (dvbs2_data_out),
//         .data_in_end    (dvbs2_endout),
//         .valid_out      (_128bit_valid_out),
//         .data_out       (_128bit_data_out)
//     );

// _1bit_to_64bit _1bit_to_64bit_inst(
//         .clk             (dvbs2_clk),
//         .rst_n           (~core_reset),
//         .valid_in        (dvbs2_valid_out),
//         .data_in         (dvbs2_data_out),
//         .data_in_end     (dvbs2_endout),
//         .valid_out       (_64bit_valid_out),
//         .data_out        (_64bit_data_out),
//         .data_out_end    (_64bit_data_end)
//     );

udp_packet_fifo udp_packet_fifo_inst(
        .rst(udp_packet_fifo_rst),                      // input wire rst
        .wr_clk(ddr_output_fifo_wr_clk),                // input wire wr_clk
        .rd_clk(clk_15_625),                // input wire rd_clk
        .din(udp_packet_fifo_wr_din),                      // input wire [127 : 0] din
        .wr_en(udp_packet_fifo_wr_en),                  // input wire wr_en
        .rd_en(udp_data_in_req),                  // input wire rd_en
        .dout(udp_data_in),                    // output wire [63 : 0] dout
        .full(),                    // output wire full
        .empty(empty),                  // output wire empty
        .rd_data_count(udp_packet_fifo_rd_count),  // output wire [12 : 0] rd_data_count
        .wr_data_count(),  // output wire [10 : 0] wr_data_count
        .wr_rst_busy(),      // output wire wr_rst_busy
        .rd_rst_busy()      // output wire rd_rst_busy
);

always@(posedge clk_15_625 or posedge core_reset)begin
    if(core_reset)
        udp_cnt<=56'd0;
    else if(udp_data_in_req==1)begin
        if(udp_cnt ==tx_data_len)
            udp_cnt<=udp_cnt;
        else
            udp_cnt<=udp_cnt+1'b1;
    end
end
always@(posedge clk_15_625 or posedge core_reset)begin
    if(core_reset)begin
        udp_read_ready<=1'b0;
    end
    else if(udp_cnt == tx_data_len)begin
        udp_read_ready<=1'b0;
    end
    else begin
        if(udp_packet_fifo_rd_count>12'd0)begin
            udp_read_ready<=1'b1;
        end
        else begin
            udp_read_ready<=1'b0;
        end
    end
end
  system system_i
       (.DDR3_0_addr(DDR3_0_addr),
        .DDR3_0_ba(DDR3_0_ba),
        .DDR3_0_cas_n(DDR3_0_cas_n),
        .DDR3_0_ck_n(DDR3_0_ck_n),
        .DDR3_0_ck_p(DDR3_0_ck_p),
        .DDR3_0_cke(DDR3_0_cke),
        .DDR3_0_cs_n(DDR3_0_cs_n),
        .DDR3_0_dm(DDR3_0_dm),
        .DDR3_0_dq(DDR3_0_dq),
        .DDR3_0_dqs_n(DDR3_0_dqs_n),
        .DDR3_0_dqs_p(DDR3_0_dqs_p),
        .DDR3_0_odt(DDR3_0_odt),
        .DDR3_0_ras_n(DDR3_0_ras_n),
        .DDR3_0_reset_n(DDR3_0_reset_n),
        .DDR3_0_we_n(DDR3_0_we_n),
        .FDMA_S_0_i_fdma_raddr(fdma_raddr),
        .FDMA_S_0_i_fdma_rareq(fdma_rareq),
        .FDMA_S_0_o_fdma_rbusy(fdma_rbusy),
        .FDMA_S_0_o_fdma_rdata(fdma_rdata),
        .FDMA_S_0_i_fdma_rready(1'b1),
        .FDMA_S_0_i_fdma_rsize(fdma_rsize),
        .FDMA_S_0_o_fdma_rvalid(fdma_rvalid),
        .FDMA_S_0_i_fdma_waddr(fdma_waddr),
        .FDMA_S_0_i_fdma_wareq(fdma_wareq),
        .FDMA_S_0_o_fdma_wbusy(fdma_wbusy),
        .FDMA_S_0_i_fdma_wdata(fdma_wdata),
        .FDMA_S_0_i_fdma_wready(1'b1),
        .FDMA_S_0_i_fdma_wsize(fdma_wsize),
        .FDMA_S_0_o_fdma_wvalid(fdma_wvalid),
        .fdma_rstn(fdma_rstn),
        .I_sysclk(I_sysclk),
        .ui_clk(ui_clk));

clk_wiz_0 clk_wiz_0(
.clk_in1      (I_sysclk),   
.clk_out1       (clk_15_625),
.clk_out2       (clk_200),   
.clk_out3       (clk_125),   
.clk_out4       (clk_125_90),   
.clk_out5       (clk_25),									  
.locked         (locked)
); 

master_ch  udp_inst
(
.clk_15_625   (clk_15_625),
.clk_200      (clk_200),
.clk_125      (clk_125),
.clk_125_90   (clk_125_90),

.data_read_ready (udp_read_ready),
.data_in_req  (udp_data_in_req),
.data_in      (udp_data_in),
.valid_out    (udp_valid_out),
.data_out     (udp_data_out),
.core_reset   (core_reset),
.tx_data_len  (tx_data_len),
.reset        (1'b0),
.dcm_locked   (locked),
   
.rgmii_rxd    (PHYA_rgmii_rxd),
.rgmii_rx_ctl (PHYA_rgmii_rx_ctl),
.rgmii_rxc    (PHYA_rgmii_rxc),
        
.rgmii_txd    (PHYA_rgmii_txd),
.rgmii_tx_ctl (PHYA_rgmii_tx_ctl),
.rgmii_txc    (PHYA_rgmii_txc)                          
);   

// DVB_S2_HDL_Transmitter_wrapper dvbs2_tx_inst (
//   .clk(dvbs2_clk),                // input wire clk
//   .reset(core_reset),            // input wire reset
//   .clk_enable(clk_enable),  // input wire clk_enable
//   .pktIn(pktIn),            // input wire [5 : 0] pktIn
//   .validOut(dvbs2_valid_out),      // output wire validOut
//   .ce_out_0(dvbs2_ce_out),      // output wire ce_out_0
//   .nextFrame(),    // output wire nextFrame
//   .dataOut_re(dvbs2_data_out_re),  // output wire [18 : 0] dataOut_re
//   .dataOut_im(dvbs2_data_out_im)  // output wire [18 : 0] dataOut_im
// );
ldpc_parallel_encoder_wrapper ldpc_parallel_encoder_wrapper_inst (
    .clk                        (dvbs2_clk),
    .reset                      (core_reset),
    .clk_enable                 (clk_enable),
    .pktIn                      (pktIn),
    .valid_out                  (dvbs2_valid_out),
    .ce_out_0                   (dvbs2_ce_out),
    .nextFrame                  (),
    .dataOut_re                 (dvbs2_data_out_re),  // output wire [18 : 0] dataOut_re
    .dataOut_im                 (dvbs2_data_out_im)  // output wire [18 : 0] dataOut_im
);
endmodule
