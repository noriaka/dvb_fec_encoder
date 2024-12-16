`timescale 1ns / 1ps
/*******************************MILIANKE*******************************
*Company : MiLianKe Electronic Technology Co., Ltd.
*WebSite:https://www.milianke.com
*TechWeb:https://www.uisrc.com
*tmall-shop:https://milianke.tmall.com
*jd-shop:https://milianke.jd.com
*taobao-shop1: https://milianke.taobao.com
*Create Date: 2019/12/17
*Module Name:udp_loop_back
*File Name:udp_loop_back.v
*Description: 
*The reference demo provided by Milianke is only used for learning. 
*We cannot ensure that the demo itself is free of bugs, so users 
*should be responsible for the technical problems and consequences
*caused by the use of their own products.
*Copyright: Copyright (c) MiLianKe
*All rights reserved.
*Revision: 1.0
*Signal description
*1) _i input
*2) _o output
*3) _n activ low
*4) _dg debug signal 
*5) _r delay or register
*6) _s state mechine
*********************************************************************/
module slave_ch(
input               clk_15_625,
input               clk_125,  
input               clk_125_90,
input               reset,
input          	    dcm_locked,

input [3:0]         rgmii_rxd,
input               rgmii_rx_ctl,
input               rgmii_rxc,
    
output wire[3:0]   rgmii_txd,
output wire        rgmii_tx_ctl,
output wire        rgmii_txc
);

localparam  WAIT_UDP_DATA   = 2'd0;
localparam  WAIT_ACK        = 2'd1;
localparam  SEND_UDP_DATA   = 2'd2;
localparam  DELAY           = 2'd3;

reg             data_valid;
reg             app_data_request;

reg [15:0]      udp_port;
reg [31:0]      ip_address;
reg [15:0]      packet_length;

wire            app_rx_data_valid;
wire [63:0]     app_rx_data;
wire [7:0]      app_rx_data_keep;
wire            app_rx_data_last;
wire [15:0]     app_rx_data_length;
wire [15:0]     app_rx_port_num;


wire            udp_tx_ready;
wire            app_tx_ack;
reg             app_tx_data_request;
reg             app_tx_data_valid;
wire [63:0]     app_tx_data;
reg  [7:0]      app_tx_data_keep;
reg             app_tx_data_last;
reg  [15:0]     udp_data_length;
reg             app_tx_data_read;
wire [8:0]      udp_packet_fifo_data_cnt;
reg [11:0]      fifo_read_data_cnt;
reg [63:0]      test_data;

wire            dst_ip_unreachable;
reg [1:0]       STATE = 0;

wire            core_reset;    

always@(posedge clk_15_625 or posedge core_reset)
begin
    if(core_reset) begin
       app_tx_data_request  <= 1'b0;
       app_tx_data_read     <= 1'b0;
       app_tx_data_last     <= 1'b0;
       app_tx_data_keep     <= 8'hff;
       app_tx_data_valid    <= 1'b0;
       fifo_read_data_cnt   <= 12'd0;
       STATE <= WAIT_UDP_DATA;
    end
    else begin
       case(STATE)
            WAIT_UDP_DATA:
                begin
                    if((udp_packet_fifo_data_cnt > 9'd0) && (~app_rx_data_valid) && udp_tx_ready) begin
                        app_tx_data_request <= 1'b1;
                        STATE <= WAIT_ACK;
                    end
                    else begin
                       app_tx_data_request <= 1'b0;
                        STATE <= WAIT_UDP_DATA;
                    end
                end
            WAIT_ACK:
                begin
                   if(app_tx_ack) begin
                        app_tx_data_request <= 1'b0;
                        app_tx_data_read <= 1'b1;
                        app_tx_data_valid <= 1'b1;
                        if(udp_data_length <= 8) begin
                            app_tx_data_last <= 1'b1;
                            app_tx_data_keep <= (8'hff >> (8 - udp_data_length));
                            STATE <= DELAY;
                        end
                        else begin
                            fifo_read_data_cnt <= fifo_read_data_cnt + 8;
                            STATE <= SEND_UDP_DATA;
                        end
                    end
                    else if(dst_ip_unreachable) begin
                        app_tx_data_request <= 1'b0;
                        app_tx_data_valid <= 1'b0;
                        STATE <= WAIT_UDP_DATA;
                    end
                    else begin
                        app_tx_data_request <= 1'b1;
                          app_tx_data_read <= 1'b0;
                        app_tx_data_valid <= 1'b0;
                        STATE <= WAIT_ACK;
                    end
                end
            SEND_UDP_DATA:
                begin
                    app_tx_data_valid <= 1'b1;
                    fifo_read_data_cnt <= fifo_read_data_cnt + 8;
                    app_tx_data_read <= 1'b1;
                    if((fifo_read_data_cnt + 8) >= udp_data_length) begin        
                        app_tx_data_last <= 1'b1;
                        app_tx_data_keep <= (8'hff >> (fifo_read_data_cnt + 8 - udp_data_length ));
                        STATE <= DELAY;
                    end
                    else begin                                                                            
                        STATE <= SEND_UDP_DATA;
                    end                        
                end
            DELAY:
                begin
                    app_tx_data_read <= 1'b0;
                    app_tx_data_valid <= 1'b0;
                    app_tx_data_last <= 1'b0;
                    app_tx_data_keep <= 8'hff;
                    fifo_read_data_cnt <= 12'd0;
                    if(app_rx_data_valid)
                        STATE <= WAIT_UDP_DATA;
                    else
                        STATE <= DELAY;
                end
            default: STATE <= WAIT_UDP_DATA;
        endcase
    end
end      


udp_packet_fifo udp_packet_fifo 
(
.rst(core_reset),          // input rst
.wr_clk(clk_15_625),       // input wr_clk
.rd_clk(clk_15_625),       // input rd_clk
.din(app_rx_data),         // input [63 : 0] din
.wr_en(app_rx_data_valid), // input wr_en
.rd_en(app_tx_data_read),  // input rd_en
.dout(app_tx_data),        // output [63 : 0] dout
.full(),                   // output full
.empty(),                  // output empty
.rd_data_count(udp_packet_fifo_data_cnt) // output [8 : 0] rd_data_count
);


always@(posedge clk_15_625 or posedge core_reset)
begin
    if(core_reset) 
        udp_data_length <= 16'd0;
    else begin 
        if(app_rx_data_valid)
          udp_data_length <= app_rx_data_length;
        else
          udp_data_length <= udp_data_length;
    end
end


 slave_wrapper slave_wrapper_inst
(
.LOCAL_PORT_NUM      (16'd6002),
.LOCAL_IP_ADDRESS    (32'hc0a88902),
.LOCAL_MAC_ADDRESS   (48'h000a35000102),
.DST_PORT_NUM        (16'd6001),
.DST_IP_ADDRESS      (32'hc0a88901),
.ICMP_EN             (1'b1),
.ARP_REPLY_EN        (1'b1),
.ARP_REQUEST_EN      (1'b1),
.ARP_TIMEOUT_VALUE   (30'd20_000_000),
.ARP_RETRY_NUM       (4'd2),

.reset               (reset),
.dcm_locked          (dcm_locked),
.udp_core_clk        (clk_15_625),
.core_reset          (core_reset),
.gtx_clk             (clk_125),
.gtx_clk90           (clk_125_90),

.udp_tx_ready        (udp_tx_ready),
.app_tx_ack          (app_tx_ack),
		
.app_tx_request      (app_tx_data_request),
.app_tx_data_valid   (app_tx_data_valid),
.app_tx_data         (app_tx_data),
.app_tx_data_keep    (app_tx_data_keep),
.app_tx_data_last    (app_tx_data_last),
.app_tx_data_length  (udp_data_length),	
.dst_ip_unreachable  (dst_ip_unreachable),		
.app_rx_data_valid   (app_rx_data_valid),
.app_rx_data         (app_rx_data),
.app_rx_data_keep    (app_rx_data_keep),
.app_rx_data_last    (app_rx_data_last),
.app_rx_data_length  (app_rx_data_length),
.app_rx_port_num     (app_rx_port_num),
.udp_rx_error        (udp_rx_error),

.rgmii_rxd           (rgmii_rxd),
.rgmii_rx_ctl        (rgmii_rx_ctl),
.rgmii_rxc           (rgmii_rxc),
    
.rgmii_txd           (rgmii_txd),
.rgmii_tx_ctl        (rgmii_tx_ctl),
.rgmii_txc           (rgmii_txc)
                                   
);
    
endmodule
