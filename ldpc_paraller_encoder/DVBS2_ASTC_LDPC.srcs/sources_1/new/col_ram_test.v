`timescale 1ns / 1ps
module col_ram_test(
    input       clk
);


// reg ena, enb, wea;
// reg [9:0] addra, addrb;
// reg [511:0] dia;
// wire [511:0] dob;

// (* keep = "true" *)
// (* keep_hierarchy="yes" *)
// custom_ram custom_ram_inst (
//     .clka       (clk),
//     .clkb       (clk),
//     .ena        (ena),
//     .enb        (enb),
//     .wea        (wea),
//     .addra      (addra),
//     .addrb      (addrb),
//     .dia        (dia),
//     .dob        (dob)
// );


//     // Read ports
//  reg [2-1:0] re;
//  reg [2*7-1:0] rd_addr;
//  wire [2*32-1:0] rd_data;
//  reg [1-1:0] we;
//  reg [1*7-1:0] wr_addr;
//  reg [1*32-1:0] wr_data;

// (* keep = "true" *)
// (* keep_hierarchy="yes" *)
// multiport_ram #(
//     .ADDR_WIDTH          (7),
//     .DATA_WIDTH          (32),
//     .DEPTH               (128),
//     .NUM_READ_PORTS      (2),
//     .NUM_WRITE_PORTS     (1)
// ) multiport_ram_inst (
//     .clk            (clk),
//     .rst_n          (rst_n),
//     .re             (re),
//     .rd_addr        (rd_addr),
//     .rd_data        (rd_data),
//     .we             (we),
//     .wr_addr        (wr_addr),
//     .wr_data        (wr_data)
// );

reg we;
reg re1, re2, re3, re4, re5, re6, re7, re8, re9, re10, re11;
reg [7:0] wr_addr, rd_addr1, rd_addr2, rd_addr3, rd_addr4,
            rd_addr5, rd_addr6, rd_addr7, rd_addr8, rd_addr9, 
            rd_addr10, rd_addr11;
reg [359:0] wr_data;
wire [359:0] rd_data1, rd_data2, rd_data3, rd_data4, 
            rd_data5, rd_data6, rd_data7, rd_data8, 
            rd_data9, rd_data10, rd_data11;

(* keep_hierarchy="yes" *)
custom_ram custom_ram_inst (
    .clk(clk),
    .we(we),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .re1(re1),
    .rd_addr1(rd_addr1),
    .rd_data1(rd_data1),
    .re2(re2),
    .rd_addr2(rd_addr2),
    .rd_data2(rd_data2)
);

endmodule
