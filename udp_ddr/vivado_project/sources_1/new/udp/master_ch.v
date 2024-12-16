`timescale 1ns / 1ps
module master_ch(
input               clk_15_625,
input               clk_200,
input               clk_125,  
input               clk_125_90,
input               data_read_ready,
input    [63:0]     data_in, 
output              data_in_req,      
output              valid_out,    
output   [63:0]     data_out,     
output              core_reset, 
output reg  [55:0]  tx_data_len,

input               reset,
input          	    dcm_locked,
input [3:0]         rgmii_rxd,
input               rgmii_rx_ctl,
input               rgmii_rxc,
output wire[3:0]    rgmii_txd,
output wire         rgmii_tx_ctl,
output wire         rgmii_txc
);
localparam          UDP_IDLE        = 4'd0;
localparam          UDP_SEND_ACK    = 4'd1;
localparam          UDP_SEND_DATA   = 4'd2;
localparam          UDP_RECEIVE     = 4'd3;
localparam          PACKET_LEN      = 16'd1;


reg                 app_data_request;
reg [15:0]          udp_port;
reg [31:0]          ip_address;
reg [15:0]          packet_length;

wire                app_rx_data_valid;
wire [63:0]         app_rx_data;
wire [7:0]          app_rx_data_keep;
wire                app_rx_data_last;
wire [15:0]         app_rx_data_length;
wire [15:0]         app_rx_port_num;
wire                udp_tx_ready;
wire                app_tx_ack;
reg                 app_tx_data_request;
wire                app_tx_data_valid;
wire  [63:0]        app_tx_data;
wire  [7:0]         app_tx_data_keep;
reg                 app_tx_data_last;
reg                 app_tx_data_last_reg;
wire  [15:0]        udp_data_length;
reg                 app_tx_data_read;//tx fifo读请求信??            

wire                dst_ip_unreachable;
reg        [3:0]    udp_state;
reg                 udp_receive_end;
reg                 udp_send_end;
reg     [7:0]       packet_cnt;    
reg     [15:0]      send_delay_cnt;
assign              data_in_req = app_tx_data_read;
assign              app_tx_data_valid = app_tx_data_read;
// assign              app_tx_data = {data_in[7:0],data_in[15:8],data_in[23:16],data_in[31:24],
//                                 data_in[39:32],data_in[47:40],data_in[55:48],data_in[63:56]};
assign              app_tx_data = data_in;
assign              valid_out = (app_rx_data[1]==0)?app_rx_data_valid:1'b0;
assign              data_out = (app_rx_data[1]==0)?{app_rx_data[7:0],app_rx_data[15:8],app_rx_data[23:16],app_rx_data[31:24],
                                app_rx_data[39:32],app_rx_data[47:40],app_rx_data[55:48],app_rx_data[63:56]}:64'd0;
assign              app_tx_data_keep =8'hff;
assign              udp_data_length = 16'd8;
always@(posedge clk_15_625 or posedge core_reset)begin//接收发???状态机
    if(core_reset) begin
        udp_state <= UDP_RECEIVE;
        app_tx_data_request<=1'b0;
        app_tx_data_last<=1'b0;
        packet_cnt<=8'd0;
        app_tx_data_read<=1'b0;
        send_delay_cnt<=16'd0;
    end
    else begin
        case(udp_state)
            UDP_IDLE:begin
                if((~app_rx_data_valid)&&(udp_tx_ready)&&(data_read_ready))begin//udp_tx_ready
                    udp_state <= UDP_SEND_ACK;
                    app_tx_data_request<=1'b1;
                end
                else begin
                    udp_state <= UDP_IDLE;
                    app_tx_data_request<=1'b0;
                end
            end
            UDP_SEND_ACK:begin
                if(app_tx_ack)begin
                    app_tx_data_request<=1'b0;
                    app_tx_data_read <= 1'b1;
                    app_tx_data_last<=1'b1;
                    udp_state<=UDP_SEND_DATA;
                end
                else if(dst_ip_unreachable)begin
                    app_tx_data_request <= 1'b0;
                    app_tx_data_read <= 1'b0;
                    udp_state <= UDP_IDLE;
                end
                else begin
                    app_tx_data_request <= 1'b1;
                    app_tx_data_read <= 1'b0;
                    udp_state <= UDP_SEND_ACK;
                end
            end
            UDP_SEND_DATA:begin
                app_tx_data_last<=1'b0;
                app_tx_data_read<=1'b0;
                if(send_delay_cnt==16'd20000)begin
                    udp_state<=UDP_IDLE;
                    send_delay_cnt<=16'd0;
                end
                else begin
                    udp_state<=UDP_SEND_DATA;
                    send_delay_cnt<=send_delay_cnt + 1;
                end

                
                // if(packet_cnt<PACKET_LEN-1'b1)begin
                //     app_tx_data_read <= 1'b1;
                //     packet_cnt<=packet_cnt+1'b1;
                //     udp_state<=UDP_SEND_DATA;
                // end
                // else begin
                //     app_tx_data_read<=1'b0;
                //     packet_cnt<=8'd0;
                //     if(udp_send_end==1)
                //         udp_state<=UDP_RECEIVE;
                //     else                  
                //         udp_state<=UDP_IDLE;
                // end
                      
            end
            UDP_RECEIVE:begin
                app_tx_data_read <= 1'b0;
                if(udp_receive_end==1'b1)
                    udp_state <= UDP_IDLE;
                else
                    udp_state<=UDP_RECEIVE;
            end
            default: udp_state <= UDP_IDLE;
        endcase
    end
end
always@(posedge clk_15_625 or posedge core_reset)begin//判断接受到的数据包是空包还是有效数据??
    if(core_reset)
        udp_receive_end<=1'b0;
    else if(app_rx_data_valid)begin
        if(app_rx_data[7]==1'b1)
            udp_receive_end<=1'b1;
        else 
            udp_receive_end<=1'b0;
    end
    else if(udp_state==UDP_SEND_DATA)
        udp_receive_end<=1'b0;
    else
        udp_receive_end<=udp_receive_end;
end
always@(posedge clk_15_625 or posedge core_reset)begin//判断接受到的数据包是空包还是有效数据??
    if(core_reset)
        udp_send_end<=1'b0;
    else if(data_in_req)begin
        if(data_in[63]==1'b1)
            udp_send_end<=1'b1;
        else 
            udp_send_end<=1'b0;
    end
    else if(udp_state==UDP_RECEIVE)
        udp_send_end<=1'b0;
    else
        udp_send_end<=udp_send_end;
end
      
always@(posedge clk_15_625 or posedge core_reset)begin//判断接受到的数据包是空包还是有效数据??
    if(core_reset)
        tx_data_len<=56'd0;
    else if(app_rx_data_valid)begin
        if(app_rx_data[1]==1'b1)
            tx_data_len<={app_rx_data[15:8],app_rx_data[23:16],app_rx_data[31:24],app_rx_data[39:32],app_rx_data[47:40],app_rx_data[55:48],app_rx_data[63:56]};
        else 
            tx_data_len<=tx_data_len;
    end
    else begin
        tx_data_len<=tx_data_len;
    end
end

master_wrapper master_wrapper_inst
(
.LOCAL_PORT_NUM      (16'd8002),
.LOCAL_IP_ADDRESS    (32'hc0a88902),
.LOCAL_MAC_ADDRESS   (48'h000a35000102),
.DST_PORT_NUM        (16'd8001),
.DST_IP_ADDRESS      (32'hc0a88901),
.ICMP_EN             (1'b1),
.ARP_REPLY_EN        (1'b1),
.ARP_REQUEST_EN      (1'b1),
.ARP_TIMEOUT_VALUE   (30'd20_000_000),
.ARP_RETRY_NUM       (4'd2),

.reset               (reset),
.dcm_locked          (dcm_locked),
.refclk              (clk_200),
.udp_core_clk        (clk_15_625),
.gtx_clk             (clk_125),
.core_reset          (core_reset),
.gtx_clk_out         (),
.gtx_clk90_out       (),

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
