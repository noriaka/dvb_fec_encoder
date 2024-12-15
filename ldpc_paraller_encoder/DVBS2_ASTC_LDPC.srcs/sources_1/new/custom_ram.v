// module custom_ram #(
//     parameter ADDR_WIDTH = 7,      // 行地址宽度
//     parameter DATA_WIDTH = 32,    // 每行数据宽度
//     parameter DEPTH = 128           // RAM 的深度（行数）
// )(
//     input clk,
//     input rst_n,

//     // 写操作端口
//     input we,                    // 写使能
//     input [ADDR_WIDTH-1:0] wr_addr,  // 行地址
//     input [DATA_WIDTH-1:0] wr_data, // 写入的数据

//     // 读操作端口
//     input [9:0] rd_col,            // 列地址（从0到359）
//     output [DEPTH-1:0] rd_data     // 按列读取的数据
// );

//     (* ram_style = "block" *) reg [DATA_WIDTH-1:0] bram [0:DEPTH-1];
//     integer i;
//     always @(posedge clk) begin
//         if (we) begin
//             bram[wr_addr] <= wr_data;
//         end
//     end

//     reg [DEPTH-1:0] rd_data_reg;
//     always @(posedge clk) begin
//         for (i = 0; i < DEPTH; i = i + 1) begin
//             rd_data_reg[i] <= bram[i][rd_col];  // bram[i][rd_col] 取每行中列 rd_col 的值
//         end
//     end

//     assign rd_data = rd_data_reg;

// endmodule
//-----------------------------------------------------------------
// module custom_ram (
//     clka, clkb, ena, enb, wea, addra, addrb, dia, dob
// );
// input clka, clkb, ena, enb, wea;
// input [9:0] addra, addrb;
// input [511:0] dia;
// output [511:0] dob;
// reg [511:0] ram [1023:0];
// reg [511:0] dob;

// always @(posedge clka) begin
//     if (ena) begin
//         if (wea)
//             ram[addra] <= dia;
//     end
// end

// always @(posedge clkb) begin
//     if (enb) begin
//         dob <= ram[addrb];
//     end
// end

// endmodule
//-----------------------------------------------------------------
module custom_ram #( parameter ADDR_WIDTH = 7,
                parameter DATA_WIDTH = 360,
                parameter DEPTH = 108)
                (
                input  clk,
                //input  rst_n,
                //read port
                input  re1,
                input  [ADDR_WIDTH-1:0] rd_addr1,
                output reg [DATA_WIDTH-1:0] rd_data1,
                //read port
                input                            re2,
                input  [ADDR_WIDTH-1:0]     rd_addr2,
                output reg [DATA_WIDTH-1:0] rd_data2,

                //write port
                input  we,
                input  [ADDR_WIDTH-1:0] wr_addr,
                input  [DATA_WIDTH-1:0] wr_data
                );

    (*ram_style="block"*)reg [DATA_WIDTH-1:0] bram [0:DEPTH-1];
    //read1
    always @(posedge clk)
    begin
        if(re1)
            rd_data1 <= bram[rd_addr1];
        else
            rd_data1 <= rd_data1;
    end
    //read2
    always @(posedge clk)
    begin
        if(re2)
            rd_data2 <= bram[rd_addr2];
        else
            rd_data2 <= rd_data2;
    end


    //write
    always @(posedge clk)
    begin
        if(we)
            bram[wr_addr]<=wr_data;
    end
endmodule