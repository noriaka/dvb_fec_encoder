`timescale 1ns / 1ps
/*
Company : Liyang Milian Electronic Technology Co., Ltd.
Brand: Ã×Áª¿Í(msxbo)
Technical forum:uisrc.com
taobao: osrc.taobao.com
Create Date: 2019/12/17
Module Name: slave_wrapper
Description: 
Copyright: Copyright (c) msxbo
Revision: 1.0
Signal description:
1) _i input
2) _o output
3) _n activ low
4) _dg debug signal 
5) _r delay or register
6) _s state mechine
*/
//////////////////////////////////////////////////////////////////////////////////


module slave_wrapper(
input  [15:0]       	LOCAL_PORT_NUM,
input  [31:0]       	LOCAL_IP_ADDRESS,
input  [47:0]       	LOCAL_MAC_ADDRESS,
input  [15:0]       	DST_PORT_NUM,
input  [31:0]       	DST_IP_ADDRESS,

input         			ICMP_EN,   
input            		ARP_REPLY_EN,      
input            		ARP_REQUEST_EN,      
input  [29:0]   		ARP_TIMEOUT_VALUE,
input  [3:0]   			ARP_RETRY_NUM,


input                   reset,
input                   dcm_locked,
input                   udp_core_clk,
output                  core_reset,
input                   gtx_clk,
input                   gtx_clk90,

output                  udp_tx_ready,
output                  app_tx_ack,
input                   app_tx_request,
input                   app_tx_data_valid,
input [63:0]            app_tx_data,
input [7:0]             app_tx_data_keep,
input            		app_tx_data_last,
input [15:0]			app_tx_data_length,
output                  dst_ip_unreachable,
			
output                  app_rx_data_valid,
output [63:0]           app_rx_data,
output [7:0]            app_rx_data_keep,
output        		    app_rx_data_last,	
output [15:0]           app_rx_data_length,
output [15:0]           app_rx_port_num,
output                  udp_rx_error,
output                  ip_rx_error,

input [3:0]             rgmii_rxd,
input                   rgmii_rx_ctl,
input                   rgmii_rxc,
    
output [3:0]            rgmii_txd,
output                  rgmii_tx_ctl,
output                  rgmii_txc
                                   
);

wire            mac_tx_valid;
wire [63:0]     mac_tx_data;
wire [7:0]      mac_tx_keep;
wire            mac_tx_ready;
wire            mac_tx_last;
wire            mac_tx_user;
    
wire            mac_rx_valid;
wire [63:0]     mac_rx_data;
wire [7:0]      mac_rx_keep;
wire            mac_rx_last;
wire            mac_rx_user;
    
wire            m_axis_tvalid1;
wire [63:0]     m_axis_tdata1;
wire [7:0]      m_axis_tkeep1;
wire            m_axis_tready1;
wire            m_axis_tlast1;
wire            m_axis_tuser1;

wire            m_axis_tvalid2;
wire [63:0]     m_axis_tdata2;
wire [7:0]      m_axis_tkeep2;
wire            m_axis_tready2;
wire            m_axis_tlast2;
wire            m_axis_tuser2;
    
wire            m_axis_tvalid3;
wire [63:0]     m_axis_tdata3;
wire [7:0]      m_axis_tkeep3;
wire            m_axis_tready3;
wire            m_axis_tlast3;
wire            m_axis_tuser3;

wire            m_axis_tvalid4;
wire [63:0]     m_axis_tdata4;
wire [7:0]      m_axis_tkeep4;
wire            m_axis_tready4;
wire            m_axis_tlast4;
wire            m_axis_tuser4;



wire            rx_mac_aclk;    // MAC Rx clock
wire            tx_mac_aclk;    // MAC Tx clock


// MAC receiver client I/F
wire [7:0]      rx_axis_mac_tdata;
wire            rx_axis_mac_tvalid;
wire            rx_axis_mac_tlast;
wire            rx_axis_mac_tuser;

// MAC transmitter client I/F
wire [7:0]      tx_axis_mac_tdata;
wire            tx_axis_mac_tvalid;
wire            tx_axis_mac_tready;
wire            tx_axis_mac_tlast;
wire            tx_axis_mac_tuser;



// AXI-Lite interface
wire  [11:0]    s_axi_awaddr;
wire            s_axi_awvalid;
wire            s_axi_awready;
wire  [31:0]    s_axi_wdata;
wire            s_axi_wvalid;
wire            s_axi_wready;
wire  [1:0]     s_axi_bresp;
wire            s_axi_bvalid;
wire            s_axi_bready;
wire  [11:0]    s_axi_araddr;
wire            s_axi_arvalid;
wire            s_axi_arready;
wire  [31:0]    s_axi_rdata;
wire  [1:0]     s_axi_rresp;
wire            s_axi_rvalid;
wire            s_axi_rready;


wire            tx_reset;
wire            rx_reset;

wire            glbl_rst_intn;     
wire            gtx_resetn;  
wire            s_axi_resetn;

tri_mode_ethernet_mac_0_example_design_resets example_resets
(
  // clocks
  .s_axi_aclk       (gtx_clk),
  .gtx_clk          (gtx_clk),
  .core_clk         (udp_core_clk),
  // asynchronous resets
  .glbl_rst         (reset),
  .reset_error      (1'b0),
  .rx_reset         (rx_reset),
  .tx_reset         (tx_reset),
  .dcm_locked       (dcm_locked),
  // synchronous reset outputs
  .glbl_rst_intn    (glbl_rst_intn),
  .gtx_resetn       (gtx_resetn),
  .s_axi_resetn     (s_axi_resetn),
  .phy_resetn       (phy_resetn),
  .chk_resetn       (),
  .core_reset       (core_reset)
);

uiudp_stack uiudp_stack_inst
(
.LOCAL_PORT_NUM      (LOCAL_PORT_NUM),
.LOCAL_IP_ADDRESS    (LOCAL_IP_ADDRESS),
.LOCAL_MAC_ADDRESS   (LOCAL_MAC_ADDRESS),
.ICMP_EN             (ICMP_EN),
.ARP_REPLY_EN        (ARP_REPLY_EN),
.ARP_REQUEST_EN      (ARP_REQUEST_EN),
.ARP_TIMEOUT_VALUE   (ARP_TIMEOUT_VALUE),
.ARP_RETRY_NUM       (ARP_RETRY_NUM),

.core_clk            (udp_core_clk),    
.reset               (core_reset), 
.udp_tx_ready        (udp_tx_ready), 
.app_tx_ack          (app_tx_ack), 
.app_tx_request      (app_tx_request), //app_tx_data_request
.app_tx_data_valid   (app_tx_data_valid),    
.app_tx_data         (app_tx_data),
.app_tx_data_keep    (app_tx_data_keep),
.app_tx_data_last    (app_tx_data_last),    
.app_tx_data_length  (app_tx_data_length), 
.app_tx_dst_port     (DST_PORT_NUM), 
.ip_tx_dst_address   (DST_IP_ADDRESS), 
.app_rx_data_valid   (app_rx_data_valid), 
.app_rx_data         (app_rx_data),
.app_rx_data_keep    (app_rx_data_keep),
.app_rx_data_last    (app_rx_data_last),
.app_rx_data_length  (app_rx_data_length), 
.app_rx_port_num     (app_rx_port_num),
.udp_rx_error        (udp_rx_error),    
.mac_tx_data_valid   (mac_tx_valid),
.mac_tx_data         (mac_tx_data),
.mac_tx_keep         (mac_tx_keep),
.mac_tx_ready        (mac_tx_ready),
.mac_tx_last         (mac_tx_last),
.mac_tx_user         (mac_tx_user),        
.mac_rx_data_valid   (mac_rx_valid),
.mac_rx_data         (mac_rx_data),
.mac_rx_keep         (mac_rx_keep),
.mac_rx_last         (mac_rx_last),
.mac_rx_user         (1'b0),
.ip_rx_error         (ip_rx_error),    
.dst_ip_unreachable  (dst_ip_unreachable)
);

axis_data_fifo_1 tx_async_fifo0 
(
.s_axis_aresetn      (~core_reset),         // input wire s_axis_aresetn
.s_axis_aclk         (udp_core_clk),        // input wire s_axis_aclk
.s_axis_tvalid       (mac_tx_valid),        // input wire s_axis_tvalid
.s_axis_tready       (mac_tx_ready),        // output wire s_axis_tready
.s_axis_tdata        (mac_tx_data),         // input wire [63 : 0] s_axis_tdata
.s_axis_tkeep        (mac_tx_keep),         // input wire [7 : 0] s_axis_tkeep
.s_axis_tlast        (mac_tx_last),         // input wire s_axis_tlast
.s_axis_tuser        (1'b0),                // input wire [0 : 0] s_axis_tuser
.m_axis_aclk         (tx_mac_aclk),         // input wire m_axis_aclk
.m_axis_tvalid       (m_axis_tvalid1),      // output wire m_axis_tvalid
.m_axis_tready       (m_axis_tready1),      // input wire m_axis_tready
.m_axis_tdata        (m_axis_tdata1),       // output wire [63 : 0] m_axis_tdata
.m_axis_tkeep        (m_axis_tkeep1),       // output wire [7 : 0] m_axis_tkeep
.m_axis_tlast        (m_axis_tlast1),       // output wire m_axis_tlast
.m_axis_tuser        (),                    // output wire [0 : 0] m_axis_tuser
.axis_wr_data_count  (),                    // output wire [31 : 0] axis_wr_data_count
.axis_rd_data_count  ()                     // output wire [31 : 0] axis_rd_data_count
);

axis_data_fifo_0 tx_packet_fifo0 
(
.s_axis_aresetn      (gtx_resetn),          // input wire s_axis_aresetn
.s_axis_aclk         (tx_mac_aclk),         // input wire s_axis_aclk
.s_axis_tvalid       (m_axis_tvalid1),      // input wire s_axis_tvalid
.s_axis_tready       (m_axis_tready1),      // output wire s_axis_tready
.s_axis_tdata        (m_axis_tdata1),       // input wire [63 : 0] s_axis_tdata
.s_axis_tkeep        (m_axis_tkeep1),       // input wire [7 : 0] s_axis_tkeep
.s_axis_tlast        (m_axis_tlast1),       // input wire s_axis_tlast
.s_axis_tuser        (1'b0),                // input wire [0 : 0] s_axis_tuser
.m_axis_tvalid       (m_axis_tvalid2),      // output wire m_axis_tvalid
.m_axis_tready       (m_axis_tready2),      // input wire m_axis_tready
.m_axis_tdata        (m_axis_tdata2),       // output wire [63 : 0] m_axis_tdata
.m_axis_tkeep        (m_axis_tkeep2),       // output wire [7 : 0] m_axis_tkeep
.m_axis_tlast        (m_axis_tlast2),       // output wire m_axis_tlast
.m_axis_tuser        (),                    // output wire [0 : 0] m_axis_tuser
.axis_wr_data_count  (),                    // output wire [31 : 0] axis_wr_data_count
.axis_rd_data_count  ()                     // output wire [31 : 0] axis_rd_data_count
);    

axis_dwidth_converter_0 tx_axis_dwidth_converter0 
(
.aclk               (tx_mac_aclk),          // input wire aclk
.aresetn            (gtx_resetn),           // input wire aresetn
.s_axis_tvalid      (m_axis_tvalid2),       // input wire s_axis_tvalid
.s_axis_tready      (m_axis_tready2),       // output wire s_axis_tready
.s_axis_tdata       (m_axis_tdata2),        // input wire [63 : 0] s_axis_tdata
.s_axis_tkeep       (m_axis_tkeep2),        // input wire [7 : 0] s_axis_tkeep
.s_axis_tlast       (m_axis_tlast2),        // input wire s_axis_tlast
.m_axis_tvalid      (tx_axis_mac_tvalid),   // output wire m_axis_tvalid
.m_axis_tready      (tx_axis_mac_tready),   // input wire m_axis_tready
.m_axis_tdata       (tx_axis_mac_tdata),    // output wire [7 : 0] m_axis_tdata
.m_axis_tkeep       (),                     // output wire [0 : 0] m_axis_tkeep
.m_axis_tlast       (tx_axis_mac_tlast)     // output wire m_axis_tlast
);

axis_dwidth_converter_1 rx_axis_dwidth_converter0 (
.aclk               (rx_mac_aclk),                         // input wire aclk
.aresetn            (gtx_resetn),                       // input wire aresetn
.s_axis_tvalid      (rx_axis_mac_tvalid),         // input wire s_axis_tvalid
.s_axis_tready      (),                           // output wire s_axis_tready
.s_axis_tdata       (rx_axis_mac_tdata),           // input wire [7 : 0] s_axis_tdata
.s_axis_tkeep       (1'b1),                        // input wire [0 : 0] s_axis_tkeep
.s_axis_tlast       (rx_axis_mac_tlast),           // input wire s_axis_tlast
.m_axis_tvalid      (m_axis_tvalid3),  // output wire m_axis_tvalid
.m_axis_tready      (m_axis_tready3),  // input wire m_axis_tready
.m_axis_tdata       (m_axis_tdata3),    // output wire [63 : 0] m_axis_tdata
.m_axis_tkeep       (m_axis_tkeep3),    // output wire [7 : 0] m_axis_tkeep
.m_axis_tlast       (m_axis_tlast3)    // output wire m_axis_tlast
);    

axis_data_fifo_1 rx_async_fifo0 
(
.s_axis_aresetn     (gtx_resetn),          // input wire s_axis_aresetn
.s_axis_aclk        (rx_mac_aclk),                // input wire s_axis_aclk
.s_axis_tvalid      (m_axis_tvalid3),            // input wire s_axis_tvalid
.s_axis_tready      (m_axis_tready3),            // output wire s_axis_tready
.s_axis_tdata       (m_axis_tdata3),              // input wire [63 : 0] s_axis_tdata
.s_axis_tkeep       (m_axis_tkeep3),              // input wire [7 : 0] s_axis_tkeep
.s_axis_tlast       (m_axis_tlast3),              // input wire s_axis_tlast
.s_axis_tuser       (1'b0),              // input wire [0 : 0] s_axis_tuser
.m_axis_aclk        (udp_core_clk),                // input wire m_axis_aclk
.m_axis_tvalid      (m_axis_tvalid4),            // output wire m_axis_tvalid
.m_axis_tready      (m_axis_tready4),            // input wire m_axis_tready
.m_axis_tdata       (m_axis_tdata4),              // output wire [63 : 0] m_axis_tdata
.m_axis_tkeep       (m_axis_tkeep4),              // output wire [7 : 0] m_axis_tkeep
.m_axis_tlast       (m_axis_tlast4),              // output wire m_axis_tlast
.m_axis_tuser       (),                          // output wire [0 : 0] m_axis_tuser
.axis_wr_data_count (),  // output wire [31 : 0] axis_wr_data_count
.axis_rd_data_count ()  // output wire [31 : 0] axis_rd_data_count
);

axis_data_fifo_0 rx_packet_fifo0 
(
.s_axis_aresetn     (~core_reset),          // input wire s_axis_aresetn
.s_axis_aclk        (udp_core_clk),                // input wire s_axis_aclk
.s_axis_tvalid      (m_axis_tvalid4),            // input wire s_axis_tvalid
.s_axis_tready      (m_axis_tready4),            // output wire s_axis_tready
.s_axis_tdata       (m_axis_tdata4),              // input wire [63 : 0] s_axis_tdata
.s_axis_tkeep       (m_axis_tkeep4),              // input wire [7 : 0] s_axis_tkeep
.s_axis_tlast       (m_axis_tlast4),              // input wire s_axis_tlast
.s_axis_tuser       (1'b0),              // input wire [0 : 0] s_axis_tuser
.m_axis_tvalid      (mac_rx_valid),            // output wire m_axis_tvalid
.m_axis_tready      (1'b1),            // input wire m_axis_tready
.m_axis_tdata       (mac_rx_data),              // output wire [63 : 0] m_axis_tdata
.m_axis_tkeep       (mac_rx_keep),              // output wire [7 : 0] m_axis_tkeep
.m_axis_tlast       (mac_rx_last),              // output wire m_axis_tlast
.m_axis_tuser       (),                          // output wire [0 : 0] m_axis_tuser
.axis_wr_data_count (),  // output wire [31 : 0] axis_wr_data_count
.axis_rd_data_count ()  // output wire [31 : 0] axis_rd_data_count
);      
//----------------------------------------------------------------------------
// Instantiate the Tri-Mode Ethernet MAC core
//----------------------------------------------------------------------------
tri_mode_ethernet_mac_1 tri_mode_ethernet_mac_i (                                                                          
  .gtx_clk(gtx_clk),                            // input wire gtx_clk
  .gtx_clk90(gtx_clk90),                        // input wire gtx_clk90                       
  // asynchronous reset
  .glbl_rstn            (glbl_rst_intn),
  .rx_axi_rstn          (1'b1),
  .tx_axi_rstn          (1'b1),

  // Receiver Interface
  .rx_statistics_vector (),
  .rx_statistics_valid  (),

  .rx_mac_aclk          (rx_mac_aclk),
  .rx_reset             (rx_reset),
  .rx_axis_mac_tdata    (rx_axis_mac_tdata),
  .rx_axis_mac_tvalid   (rx_axis_mac_tvalid),
  .rx_axis_mac_tlast    (rx_axis_mac_tlast),
  .rx_axis_mac_tuser    (),

  // Transmitter Interface
  .tx_ifg_delay         (8'd0),
  .tx_statistics_vector (),
  .tx_statistics_valid  (),

  .tx_mac_aclk          (tx_mac_aclk),
  .tx_reset             (tx_reset),
  .tx_axis_mac_tdata    (tx_axis_mac_tdata),
  .tx_axis_mac_tvalid   (tx_axis_mac_tvalid),
  .tx_axis_mac_tlast    (tx_axis_mac_tlast),
  .tx_axis_mac_tuser    (1'b0 ),
  .tx_axis_mac_tready   (tx_axis_mac_tready),
  // Flow Control
  .pause_req            (1'b0),
  .pause_val            (16'd0),                           
  // Speed Control
  .speedis100           (),
  .speedis10100         (),

  // RGMII Interface
  .rgmii_txd            (rgmii_txd),
  .rgmii_tx_ctl         (rgmii_tx_ctl),
  .rgmii_txc            (rgmii_txc),
  .rgmii_rxd            (rgmii_rxd),
  .rgmii_rx_ctl         (rgmii_rx_ctl),
  .rgmii_rxc            (rgmii_rxc),
  .inband_link_status   (),
  .inband_clock_speed   (),
  .inband_duplex_status (),

  // AXI lite interface
  .s_axi_aclk           (gtx_clk),
  .s_axi_resetn         (s_axi_resetn),
  .s_axi_awaddr         (s_axi_awaddr),
  .s_axi_awvalid        (s_axi_awvalid),
  .s_axi_awready        (s_axi_awready),
  .s_axi_wdata          (s_axi_wdata),
  .s_axi_wvalid         (s_axi_wvalid),
  .s_axi_wready         (s_axi_wready),
  .s_axi_bresp          (s_axi_bresp),
  .s_axi_bvalid         (s_axi_bvalid),
  .s_axi_bready         (s_axi_bready),
  .s_axi_araddr         (s_axi_araddr),
  .s_axi_arvalid        (s_axi_arvalid),
  .s_axi_arready        (s_axi_arready),
  .s_axi_rdata          (s_axi_rdata),
  .s_axi_rresp          (s_axi_rresp),
  .s_axi_rvalid         (s_axi_rvalid),
  .s_axi_rready         (s_axi_rready),
  .mac_irq              ()
);

//----------------------------------------------------------------------------
// Instantiate the AXI-LITE Controller
//----------------------------------------------------------------------------

tri_mode_ethernet_mac_0_axi_lite_sm axi_lite_controller_0 (
  .s_axi_aclk           (gtx_clk),
  .s_axi_resetn         (s_axi_resetn),
  .mac_speed            (2'b10),
  .update_speed         (1'b0),   // may need glitch protection on this..
  .serial_command       (1'b0),
  .serial_response      (),

  .s_axi_awaddr         (s_axi_awaddr),
  .s_axi_awvalid        (s_axi_awvalid),
  .s_axi_awready        (s_axi_awready),

  .s_axi_wdata          (s_axi_wdata),
  .s_axi_wvalid         (s_axi_wvalid),
  .s_axi_wready         (s_axi_wready),

  .s_axi_bresp          (s_axi_bresp),
  .s_axi_bvalid         (s_axi_bvalid),
  .s_axi_bready         (s_axi_bready),

  .s_axi_araddr         (s_axi_araddr),
  .s_axi_arvalid        (s_axi_arvalid),
  .s_axi_arready        (s_axi_arready),

  .s_axi_rdata          (s_axi_rdata),
  .s_axi_rresp          (s_axi_rresp),
  .s_axi_rvalid         (s_axi_rvalid),
  .s_axi_rready         (s_axi_rready)
);


endmodule
