
create_clock -period 10.000 -name sysclk -add [get_ports sysclk_p]
set_property PACKAGE_PIN D9 [get_ports sysclk_p]
set_property IOSTANDARD DIFF_SSTL135 [get_ports sysclk_p]

set_property DCI_CASCADE {33 35} [get_iobanks 34]

set_property BITSTREAM.GENERAL.COMPRESS true [current_design]
set_property PACKAGE_PIN R22 [get_ports O_phy_rst]
#��λ����ĵ�ƽԼ���?3V3��IO BANK��ƽ
set_property IOSTANDARD LVCMOS33 [get_ports O_phy_rst]
###############-----ETH1----#################
### -----------------RX------------------###
#��������ʱ��
set_property PACKAGE_PIN R25 [get_ports PHYA_rgmii_rxc]
#����������Ч�ź�
set_property PACKAGE_PIN P26 [get_ports PHYA_rgmii_rx_ctl]
#���������ź�
set_property PACKAGE_PIN P25 [get_ports {PHYA_rgmii_rxd[0]}]
set_property PACKAGE_PIN T23 [get_ports {PHYA_rgmii_rxd[1]}]
set_property PACKAGE_PIN T22 [get_ports {PHYA_rgmii_rxd[2]}]
set_property PACKAGE_PIN R23 [get_ports {PHYA_rgmii_rxd[3]}]
### -----------------TX------------------###
#��������ʱ��
set_property PACKAGE_PIN R26 [get_ports PHYA_rgmii_txc]
#���������Ч�ź�?
set_property PACKAGE_PIN U24 [get_ports PHYA_rgmii_tx_ctl]
#��������ź�?
set_property PACKAGE_PIN V24 [get_ports {PHYA_rgmii_txd[0]}]
set_property PACKAGE_PIN W25 [get_ports {PHYA_rgmii_txd[1]}]
set_property PACKAGE_PIN W26 [get_ports {PHYA_rgmii_txd[2]}]
set_property PACKAGE_PIN P21 [get_ports {PHYA_rgmii_txd[3]}]

set_property SLEW FAST [get_ports PHYA_rgmii_txc]
set_property SLEW FAST [get_ports PHYA_rgmii_tx_ctl]
set_property SLEW FAST [get_ports {PHYA_rgmii_txd[*]}]
#��ƽԼ��Ϊ3V3��IO BANK��ƽ
set_property IOSTANDARD LVCMOS33 [get_ports PHYA_rgmii_rxc]
set_property IOSTANDARD LVCMOS33 [get_ports PHYA_rgmii_rx_ctl]
set_property IOSTANDARD LVCMOS33 [get_ports {PHYA_rgmii_rxd[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports PHYA_rgmii_txc]
set_property IOSTANDARD LVCMOS33 [get_ports PHYA_rgmii_tx_ctl]
set_property IOSTANDARD LVCMOS33 [get_ports {PHYA_rgmii_txd[*]}]






create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_wiz_0/inst/clk_out5]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 64 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {ddr_output_fifo_rd_dout[0]} {ddr_output_fifo_rd_dout[1]} {ddr_output_fifo_rd_dout[2]} {ddr_output_fifo_rd_dout[3]} {ddr_output_fifo_rd_dout[4]} {ddr_output_fifo_rd_dout[5]} {ddr_output_fifo_rd_dout[6]} {ddr_output_fifo_rd_dout[7]} {ddr_output_fifo_rd_dout[8]} {ddr_output_fifo_rd_dout[9]} {ddr_output_fifo_rd_dout[10]} {ddr_output_fifo_rd_dout[11]} {ddr_output_fifo_rd_dout[12]} {ddr_output_fifo_rd_dout[13]} {ddr_output_fifo_rd_dout[14]} {ddr_output_fifo_rd_dout[15]} {ddr_output_fifo_rd_dout[16]} {ddr_output_fifo_rd_dout[17]} {ddr_output_fifo_rd_dout[18]} {ddr_output_fifo_rd_dout[19]} {ddr_output_fifo_rd_dout[20]} {ddr_output_fifo_rd_dout[21]} {ddr_output_fifo_rd_dout[22]} {ddr_output_fifo_rd_dout[23]} {ddr_output_fifo_rd_dout[24]} {ddr_output_fifo_rd_dout[25]} {ddr_output_fifo_rd_dout[26]} {ddr_output_fifo_rd_dout[27]} {ddr_output_fifo_rd_dout[28]} {ddr_output_fifo_rd_dout[29]} {ddr_output_fifo_rd_dout[30]} {ddr_output_fifo_rd_dout[31]} {ddr_output_fifo_rd_dout[32]} {ddr_output_fifo_rd_dout[33]} {ddr_output_fifo_rd_dout[34]} {ddr_output_fifo_rd_dout[35]} {ddr_output_fifo_rd_dout[36]} {ddr_output_fifo_rd_dout[37]} {ddr_output_fifo_rd_dout[38]} {ddr_output_fifo_rd_dout[39]} {ddr_output_fifo_rd_dout[40]} {ddr_output_fifo_rd_dout[41]} {ddr_output_fifo_rd_dout[42]} {ddr_output_fifo_rd_dout[43]} {ddr_output_fifo_rd_dout[44]} {ddr_output_fifo_rd_dout[45]} {ddr_output_fifo_rd_dout[46]} {ddr_output_fifo_rd_dout[47]} {ddr_output_fifo_rd_dout[48]} {ddr_output_fifo_rd_dout[49]} {ddr_output_fifo_rd_dout[50]} {ddr_output_fifo_rd_dout[51]} {ddr_output_fifo_rd_dout[52]} {ddr_output_fifo_rd_dout[53]} {ddr_output_fifo_rd_dout[54]} {ddr_output_fifo_rd_dout[55]} {ddr_output_fifo_rd_dout[56]} {ddr_output_fifo_rd_dout[57]} {ddr_output_fifo_rd_dout[58]} {ddr_output_fifo_rd_dout[59]} {ddr_output_fifo_rd_dout[60]} {ddr_output_fifo_rd_dout[61]} {ddr_output_fifo_rd_dout[62]} {ddr_output_fifo_rd_dout[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 128 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {ddr_output_fifo_wr_din[0]} {ddr_output_fifo_wr_din[1]} {ddr_output_fifo_wr_din[2]} {ddr_output_fifo_wr_din[3]} {ddr_output_fifo_wr_din[4]} {ddr_output_fifo_wr_din[5]} {ddr_output_fifo_wr_din[6]} {ddr_output_fifo_wr_din[7]} {ddr_output_fifo_wr_din[8]} {ddr_output_fifo_wr_din[9]} {ddr_output_fifo_wr_din[10]} {ddr_output_fifo_wr_din[11]} {ddr_output_fifo_wr_din[12]} {ddr_output_fifo_wr_din[13]} {ddr_output_fifo_wr_din[14]} {ddr_output_fifo_wr_din[15]} {ddr_output_fifo_wr_din[16]} {ddr_output_fifo_wr_din[17]} {ddr_output_fifo_wr_din[18]} {ddr_output_fifo_wr_din[19]} {ddr_output_fifo_wr_din[20]} {ddr_output_fifo_wr_din[21]} {ddr_output_fifo_wr_din[22]} {ddr_output_fifo_wr_din[23]} {ddr_output_fifo_wr_din[24]} {ddr_output_fifo_wr_din[25]} {ddr_output_fifo_wr_din[26]} {ddr_output_fifo_wr_din[27]} {ddr_output_fifo_wr_din[28]} {ddr_output_fifo_wr_din[29]} {ddr_output_fifo_wr_din[30]} {ddr_output_fifo_wr_din[31]} {ddr_output_fifo_wr_din[32]} {ddr_output_fifo_wr_din[33]} {ddr_output_fifo_wr_din[34]} {ddr_output_fifo_wr_din[35]} {ddr_output_fifo_wr_din[36]} {ddr_output_fifo_wr_din[37]} {ddr_output_fifo_wr_din[38]} {ddr_output_fifo_wr_din[39]} {ddr_output_fifo_wr_din[40]} {ddr_output_fifo_wr_din[41]} {ddr_output_fifo_wr_din[42]} {ddr_output_fifo_wr_din[43]} {ddr_output_fifo_wr_din[44]} {ddr_output_fifo_wr_din[45]} {ddr_output_fifo_wr_din[46]} {ddr_output_fifo_wr_din[47]} {ddr_output_fifo_wr_din[48]} {ddr_output_fifo_wr_din[49]} {ddr_output_fifo_wr_din[50]} {ddr_output_fifo_wr_din[51]} {ddr_output_fifo_wr_din[52]} {ddr_output_fifo_wr_din[53]} {ddr_output_fifo_wr_din[54]} {ddr_output_fifo_wr_din[55]} {ddr_output_fifo_wr_din[56]} {ddr_output_fifo_wr_din[57]} {ddr_output_fifo_wr_din[58]} {ddr_output_fifo_wr_din[59]} {ddr_output_fifo_wr_din[60]} {ddr_output_fifo_wr_din[61]} {ddr_output_fifo_wr_din[62]} {ddr_output_fifo_wr_din[63]} {ddr_output_fifo_wr_din[64]} {ddr_output_fifo_wr_din[65]} {ddr_output_fifo_wr_din[66]} {ddr_output_fifo_wr_din[67]} {ddr_output_fifo_wr_din[68]} {ddr_output_fifo_wr_din[69]} {ddr_output_fifo_wr_din[70]} {ddr_output_fifo_wr_din[71]} {ddr_output_fifo_wr_din[72]} {ddr_output_fifo_wr_din[73]} {ddr_output_fifo_wr_din[74]} {ddr_output_fifo_wr_din[75]} {ddr_output_fifo_wr_din[76]} {ddr_output_fifo_wr_din[77]} {ddr_output_fifo_wr_din[78]} {ddr_output_fifo_wr_din[79]} {ddr_output_fifo_wr_din[80]} {ddr_output_fifo_wr_din[81]} {ddr_output_fifo_wr_din[82]} {ddr_output_fifo_wr_din[83]} {ddr_output_fifo_wr_din[84]} {ddr_output_fifo_wr_din[85]} {ddr_output_fifo_wr_din[86]} {ddr_output_fifo_wr_din[87]} {ddr_output_fifo_wr_din[88]} {ddr_output_fifo_wr_din[89]} {ddr_output_fifo_wr_din[90]} {ddr_output_fifo_wr_din[91]} {ddr_output_fifo_wr_din[92]} {ddr_output_fifo_wr_din[93]} {ddr_output_fifo_wr_din[94]} {ddr_output_fifo_wr_din[95]} {ddr_output_fifo_wr_din[96]} {ddr_output_fifo_wr_din[97]} {ddr_output_fifo_wr_din[98]} {ddr_output_fifo_wr_din[99]} {ddr_output_fifo_wr_din[100]} {ddr_output_fifo_wr_din[101]} {ddr_output_fifo_wr_din[102]} {ddr_output_fifo_wr_din[103]} {ddr_output_fifo_wr_din[104]} {ddr_output_fifo_wr_din[105]} {ddr_output_fifo_wr_din[106]} {ddr_output_fifo_wr_din[107]} {ddr_output_fifo_wr_din[108]} {ddr_output_fifo_wr_din[109]} {ddr_output_fifo_wr_din[110]} {ddr_output_fifo_wr_din[111]} {ddr_output_fifo_wr_din[112]} {ddr_output_fifo_wr_din[113]} {ddr_output_fifo_wr_din[114]} {ddr_output_fifo_wr_din[115]} {ddr_output_fifo_wr_din[116]} {ddr_output_fifo_wr_din[117]} {ddr_output_fifo_wr_din[118]} {ddr_output_fifo_wr_din[119]} {ddr_output_fifo_wr_din[120]} {ddr_output_fifo_wr_din[121]} {ddr_output_fifo_wr_din[122]} {ddr_output_fifo_wr_din[123]} {ddr_output_fifo_wr_din[124]} {ddr_output_fifo_wr_din[125]} {ddr_output_fifo_wr_din[126]} {ddr_output_fifo_wr_din[127]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 4 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {STATE[0]} {STATE[1]} {STATE[2]} {STATE[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 11 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {dvbs2_fifo_rd_count[0]} {dvbs2_fifo_rd_count[1]} {dvbs2_fifo_rd_count[2]} {dvbs2_fifo_rd_count[3]} {dvbs2_fifo_rd_count[4]} {dvbs2_fifo_rd_count[5]} {dvbs2_fifo_rd_count[6]} {dvbs2_fifo_rd_count[7]} {dvbs2_fifo_rd_count[8]} {dvbs2_fifo_rd_count[9]} {dvbs2_fifo_rd_count[10]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 128 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {dvbs2_fifo_rd_dout[0]} {dvbs2_fifo_rd_dout[1]} {dvbs2_fifo_rd_dout[2]} {dvbs2_fifo_rd_dout[3]} {dvbs2_fifo_rd_dout[4]} {dvbs2_fifo_rd_dout[5]} {dvbs2_fifo_rd_dout[6]} {dvbs2_fifo_rd_dout[7]} {dvbs2_fifo_rd_dout[8]} {dvbs2_fifo_rd_dout[9]} {dvbs2_fifo_rd_dout[10]} {dvbs2_fifo_rd_dout[11]} {dvbs2_fifo_rd_dout[12]} {dvbs2_fifo_rd_dout[13]} {dvbs2_fifo_rd_dout[14]} {dvbs2_fifo_rd_dout[15]} {dvbs2_fifo_rd_dout[16]} {dvbs2_fifo_rd_dout[17]} {dvbs2_fifo_rd_dout[18]} {dvbs2_fifo_rd_dout[19]} {dvbs2_fifo_rd_dout[20]} {dvbs2_fifo_rd_dout[21]} {dvbs2_fifo_rd_dout[22]} {dvbs2_fifo_rd_dout[23]} {dvbs2_fifo_rd_dout[24]} {dvbs2_fifo_rd_dout[25]} {dvbs2_fifo_rd_dout[26]} {dvbs2_fifo_rd_dout[27]} {dvbs2_fifo_rd_dout[28]} {dvbs2_fifo_rd_dout[29]} {dvbs2_fifo_rd_dout[30]} {dvbs2_fifo_rd_dout[31]} {dvbs2_fifo_rd_dout[32]} {dvbs2_fifo_rd_dout[33]} {dvbs2_fifo_rd_dout[34]} {dvbs2_fifo_rd_dout[35]} {dvbs2_fifo_rd_dout[36]} {dvbs2_fifo_rd_dout[37]} {dvbs2_fifo_rd_dout[38]} {dvbs2_fifo_rd_dout[39]} {dvbs2_fifo_rd_dout[40]} {dvbs2_fifo_rd_dout[41]} {dvbs2_fifo_rd_dout[42]} {dvbs2_fifo_rd_dout[43]} {dvbs2_fifo_rd_dout[44]} {dvbs2_fifo_rd_dout[45]} {dvbs2_fifo_rd_dout[46]} {dvbs2_fifo_rd_dout[47]} {dvbs2_fifo_rd_dout[48]} {dvbs2_fifo_rd_dout[49]} {dvbs2_fifo_rd_dout[50]} {dvbs2_fifo_rd_dout[51]} {dvbs2_fifo_rd_dout[52]} {dvbs2_fifo_rd_dout[53]} {dvbs2_fifo_rd_dout[54]} {dvbs2_fifo_rd_dout[55]} {dvbs2_fifo_rd_dout[56]} {dvbs2_fifo_rd_dout[57]} {dvbs2_fifo_rd_dout[58]} {dvbs2_fifo_rd_dout[59]} {dvbs2_fifo_rd_dout[60]} {dvbs2_fifo_rd_dout[61]} {dvbs2_fifo_rd_dout[62]} {dvbs2_fifo_rd_dout[63]} {dvbs2_fifo_rd_dout[64]} {dvbs2_fifo_rd_dout[65]} {dvbs2_fifo_rd_dout[66]} {dvbs2_fifo_rd_dout[67]} {dvbs2_fifo_rd_dout[68]} {dvbs2_fifo_rd_dout[69]} {dvbs2_fifo_rd_dout[70]} {dvbs2_fifo_rd_dout[71]} {dvbs2_fifo_rd_dout[72]} {dvbs2_fifo_rd_dout[73]} {dvbs2_fifo_rd_dout[74]} {dvbs2_fifo_rd_dout[75]} {dvbs2_fifo_rd_dout[76]} {dvbs2_fifo_rd_dout[77]} {dvbs2_fifo_rd_dout[78]} {dvbs2_fifo_rd_dout[79]} {dvbs2_fifo_rd_dout[80]} {dvbs2_fifo_rd_dout[81]} {dvbs2_fifo_rd_dout[82]} {dvbs2_fifo_rd_dout[83]} {dvbs2_fifo_rd_dout[84]} {dvbs2_fifo_rd_dout[85]} {dvbs2_fifo_rd_dout[86]} {dvbs2_fifo_rd_dout[87]} {dvbs2_fifo_rd_dout[88]} {dvbs2_fifo_rd_dout[89]} {dvbs2_fifo_rd_dout[90]} {dvbs2_fifo_rd_dout[91]} {dvbs2_fifo_rd_dout[92]} {dvbs2_fifo_rd_dout[93]} {dvbs2_fifo_rd_dout[94]} {dvbs2_fifo_rd_dout[95]} {dvbs2_fifo_rd_dout[96]} {dvbs2_fifo_rd_dout[97]} {dvbs2_fifo_rd_dout[98]} {dvbs2_fifo_rd_dout[99]} {dvbs2_fifo_rd_dout[100]} {dvbs2_fifo_rd_dout[101]} {dvbs2_fifo_rd_dout[102]} {dvbs2_fifo_rd_dout[103]} {dvbs2_fifo_rd_dout[104]} {dvbs2_fifo_rd_dout[105]} {dvbs2_fifo_rd_dout[106]} {dvbs2_fifo_rd_dout[107]} {dvbs2_fifo_rd_dout[108]} {dvbs2_fifo_rd_dout[109]} {dvbs2_fifo_rd_dout[110]} {dvbs2_fifo_rd_dout[111]} {dvbs2_fifo_rd_dout[112]} {dvbs2_fifo_rd_dout[113]} {dvbs2_fifo_rd_dout[114]} {dvbs2_fifo_rd_dout[115]} {dvbs2_fifo_rd_dout[116]} {dvbs2_fifo_rd_dout[117]} {dvbs2_fifo_rd_dout[118]} {dvbs2_fifo_rd_dout[119]} {dvbs2_fifo_rd_dout[120]} {dvbs2_fifo_rd_dout[121]} {dvbs2_fifo_rd_dout[122]} {dvbs2_fifo_rd_dout[123]} {dvbs2_fifo_rd_dout[124]} {dvbs2_fifo_rd_dout[125]} {dvbs2_fifo_rd_dout[126]} {dvbs2_fifo_rd_dout[127]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 128 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {udp_packet_fifo_wr_din[0]} {udp_packet_fifo_wr_din[1]} {udp_packet_fifo_wr_din[2]} {udp_packet_fifo_wr_din[3]} {udp_packet_fifo_wr_din[4]} {udp_packet_fifo_wr_din[5]} {udp_packet_fifo_wr_din[6]} {udp_packet_fifo_wr_din[7]} {udp_packet_fifo_wr_din[8]} {udp_packet_fifo_wr_din[9]} {udp_packet_fifo_wr_din[10]} {udp_packet_fifo_wr_din[11]} {udp_packet_fifo_wr_din[12]} {udp_packet_fifo_wr_din[13]} {udp_packet_fifo_wr_din[14]} {udp_packet_fifo_wr_din[15]} {udp_packet_fifo_wr_din[16]} {udp_packet_fifo_wr_din[17]} {udp_packet_fifo_wr_din[18]} {udp_packet_fifo_wr_din[19]} {udp_packet_fifo_wr_din[20]} {udp_packet_fifo_wr_din[21]} {udp_packet_fifo_wr_din[22]} {udp_packet_fifo_wr_din[23]} {udp_packet_fifo_wr_din[24]} {udp_packet_fifo_wr_din[25]} {udp_packet_fifo_wr_din[26]} {udp_packet_fifo_wr_din[27]} {udp_packet_fifo_wr_din[28]} {udp_packet_fifo_wr_din[29]} {udp_packet_fifo_wr_din[30]} {udp_packet_fifo_wr_din[31]} {udp_packet_fifo_wr_din[32]} {udp_packet_fifo_wr_din[33]} {udp_packet_fifo_wr_din[34]} {udp_packet_fifo_wr_din[35]} {udp_packet_fifo_wr_din[36]} {udp_packet_fifo_wr_din[37]} {udp_packet_fifo_wr_din[38]} {udp_packet_fifo_wr_din[39]} {udp_packet_fifo_wr_din[40]} {udp_packet_fifo_wr_din[41]} {udp_packet_fifo_wr_din[42]} {udp_packet_fifo_wr_din[43]} {udp_packet_fifo_wr_din[44]} {udp_packet_fifo_wr_din[45]} {udp_packet_fifo_wr_din[46]} {udp_packet_fifo_wr_din[47]} {udp_packet_fifo_wr_din[48]} {udp_packet_fifo_wr_din[49]} {udp_packet_fifo_wr_din[50]} {udp_packet_fifo_wr_din[51]} {udp_packet_fifo_wr_din[52]} {udp_packet_fifo_wr_din[53]} {udp_packet_fifo_wr_din[54]} {udp_packet_fifo_wr_din[55]} {udp_packet_fifo_wr_din[56]} {udp_packet_fifo_wr_din[57]} {udp_packet_fifo_wr_din[58]} {udp_packet_fifo_wr_din[59]} {udp_packet_fifo_wr_din[60]} {udp_packet_fifo_wr_din[61]} {udp_packet_fifo_wr_din[62]} {udp_packet_fifo_wr_din[63]} {udp_packet_fifo_wr_din[64]} {udp_packet_fifo_wr_din[65]} {udp_packet_fifo_wr_din[66]} {udp_packet_fifo_wr_din[67]} {udp_packet_fifo_wr_din[68]} {udp_packet_fifo_wr_din[69]} {udp_packet_fifo_wr_din[70]} {udp_packet_fifo_wr_din[71]} {udp_packet_fifo_wr_din[72]} {udp_packet_fifo_wr_din[73]} {udp_packet_fifo_wr_din[74]} {udp_packet_fifo_wr_din[75]} {udp_packet_fifo_wr_din[76]} {udp_packet_fifo_wr_din[77]} {udp_packet_fifo_wr_din[78]} {udp_packet_fifo_wr_din[79]} {udp_packet_fifo_wr_din[80]} {udp_packet_fifo_wr_din[81]} {udp_packet_fifo_wr_din[82]} {udp_packet_fifo_wr_din[83]} {udp_packet_fifo_wr_din[84]} {udp_packet_fifo_wr_din[85]} {udp_packet_fifo_wr_din[86]} {udp_packet_fifo_wr_din[87]} {udp_packet_fifo_wr_din[88]} {udp_packet_fifo_wr_din[89]} {udp_packet_fifo_wr_din[90]} {udp_packet_fifo_wr_din[91]} {udp_packet_fifo_wr_din[92]} {udp_packet_fifo_wr_din[93]} {udp_packet_fifo_wr_din[94]} {udp_packet_fifo_wr_din[95]} {udp_packet_fifo_wr_din[96]} {udp_packet_fifo_wr_din[97]} {udp_packet_fifo_wr_din[98]} {udp_packet_fifo_wr_din[99]} {udp_packet_fifo_wr_din[100]} {udp_packet_fifo_wr_din[101]} {udp_packet_fifo_wr_din[102]} {udp_packet_fifo_wr_din[103]} {udp_packet_fifo_wr_din[104]} {udp_packet_fifo_wr_din[105]} {udp_packet_fifo_wr_din[106]} {udp_packet_fifo_wr_din[107]} {udp_packet_fifo_wr_din[108]} {udp_packet_fifo_wr_din[109]} {udp_packet_fifo_wr_din[110]} {udp_packet_fifo_wr_din[111]} {udp_packet_fifo_wr_din[112]} {udp_packet_fifo_wr_din[113]} {udp_packet_fifo_wr_din[114]} {udp_packet_fifo_wr_din[115]} {udp_packet_fifo_wr_din[116]} {udp_packet_fifo_wr_din[117]} {udp_packet_fifo_wr_din[118]} {udp_packet_fifo_wr_din[119]} {udp_packet_fifo_wr_din[120]} {udp_packet_fifo_wr_din[121]} {udp_packet_fifo_wr_din[122]} {udp_packet_fifo_wr_din[123]} {udp_packet_fifo_wr_din[124]} {udp_packet_fifo_wr_din[125]} {udp_packet_fifo_wr_din[126]} {udp_packet_fifo_wr_din[127]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 12 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {udp_packet_fifo_rd_count[0]} {udp_packet_fifo_rd_count[1]} {udp_packet_fifo_rd_count[2]} {udp_packet_fifo_rd_count[3]} {udp_packet_fifo_rd_count[4]} {udp_packet_fifo_rd_count[5]} {udp_packet_fifo_rd_count[6]} {udp_packet_fifo_rd_count[7]} {udp_packet_fifo_rd_count[8]} {udp_packet_fifo_rd_count[9]} {udp_packet_fifo_rd_count[10]} {udp_packet_fifo_rd_count[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 56 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {tx_data_len[0]} {tx_data_len[1]} {tx_data_len[2]} {tx_data_len[3]} {tx_data_len[4]} {tx_data_len[5]} {tx_data_len[6]} {tx_data_len[7]} {tx_data_len[8]} {tx_data_len[9]} {tx_data_len[10]} {tx_data_len[11]} {tx_data_len[12]} {tx_data_len[13]} {tx_data_len[14]} {tx_data_len[15]} {tx_data_len[16]} {tx_data_len[17]} {tx_data_len[18]} {tx_data_len[19]} {tx_data_len[20]} {tx_data_len[21]} {tx_data_len[22]} {tx_data_len[23]} {tx_data_len[24]} {tx_data_len[25]} {tx_data_len[26]} {tx_data_len[27]} {tx_data_len[28]} {tx_data_len[29]} {tx_data_len[30]} {tx_data_len[31]} {tx_data_len[32]} {tx_data_len[33]} {tx_data_len[34]} {tx_data_len[35]} {tx_data_len[36]} {tx_data_len[37]} {tx_data_len[38]} {tx_data_len[39]} {tx_data_len[40]} {tx_data_len[41]} {tx_data_len[42]} {tx_data_len[43]} {tx_data_len[44]} {tx_data_len[45]} {tx_data_len[46]} {tx_data_len[47]} {tx_data_len[48]} {tx_data_len[49]} {tx_data_len[50]} {tx_data_len[51]} {tx_data_len[52]} {tx_data_len[53]} {tx_data_len[54]} {tx_data_len[55]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list ddr_full]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list ddr_output_fifo_rd_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list ddr_output_fifo_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list ddr_read_end]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list ddr_write_end]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list dvbs2_fifo_rd_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list fifo_change]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list fifo_switch]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list start_flag]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list udp_data_in_req]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list udp_packet_fifo_rst]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list udp_packet_fifo_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list udp_read_ready]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_25]
