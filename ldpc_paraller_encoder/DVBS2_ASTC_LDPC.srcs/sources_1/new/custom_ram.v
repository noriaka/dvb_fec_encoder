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
// module custom_ram #( 
//     parameter ADDR_WIDTH = 7,
//     parameter DATA_WIDTH = 360,
//     parameter DEPTH = 108
// )(
//     input  clk,
//     //input  rst_n,
//     //read port
//     input                       re1,
//     input  [ADDR_WIDTH-1:0]     rd_addr1,
//     output reg [DATA_WIDTH-1:0] rd_data1,

//     input                       re2,
//     input  [ADDR_WIDTH-1:0]     rd_addr2,
//     output reg [DATA_WIDTH-1:0] rd_data2,

//     //write port
//     input                       we1,
//     input  [ADDR_WIDTH-1:0]     wr_addr1,
//     input  [DATA_WIDTH-1:0]     wr_data1

//     // input                       we2,
//     // input  [ADDR_WIDTH-1:0]     wr_addr2,
//     // input  [DATA_WIDTH-1:0]     wr_data2
// );

//     reg [DATA_WIDTH-1:0] bram [0:DEPTH-1];
//     //read1
//     always @(posedge clk)
//     begin
//         if(re1)
//             rd_data1 <= bram[rd_addr1];
//         else
//             rd_data1 <= rd_data1;
//     end
//     //read2
//     always @(posedge clk)
//     begin
//         if(re2)
//             rd_data2 <= bram[rd_addr2];
//         else
//             rd_data2 <= rd_data2;
//     end


//     //write1
//     always @(posedge clk)
//     begin
//         if(we1)
//             bram[wr_addr1]<=wr_data1;
//     end
//     //write2
//     // always @(posedge clk)
//     // begin
//     //     if(we2)
//     //         bram[wr_addr2]<=wr_data2;
//     // end
// endmodule

module custom_ram #(
    parameter ADDR_WIDTH = 7,
    parameter DATA_WIDTH = 360,
    parameter DEPTH = 128
)(
    input                       clk,
    
    // 写端口 0
    input                       we0,
    input  [ADDR_WIDTH-1:0]     wr_addr0,
    input  [DATA_WIDTH-1:0]     wr_data0,
    
    // 写端口 1
    input                       we1,
    input  [ADDR_WIDTH-1:0]     wr_addr1,
    input  [DATA_WIDTH-1:0]     wr_data1,
    
    // ram0 读
    input                       re0,
    input  [ADDR_WIDTH-1:0]     rd_addr0,
    output reg [DATA_WIDTH-1:0] rd_data0,
    input                       re1,
    input  [ADDR_WIDTH-1:0]     rd_addr1,
    output reg [DATA_WIDTH-1:0] rd_data1,

    // ram1读
    input                       re2,
    input  [ADDR_WIDTH-1:0]     rd_addr2,
    output reg [DATA_WIDTH-1:0] rd_data2,
    input                       re3,
    input  [ADDR_WIDTH-1:0]     rd_addr3,
    output reg [DATA_WIDTH-1:0] rd_data3,
    input                       re4,
    input  [ADDR_WIDTH-1:0]     rd_addr4,
    output reg [DATA_WIDTH-1:0] rd_data4,
    input                       re5,
    input  [ADDR_WIDTH-1:0]     rd_addr5,
    output reg [DATA_WIDTH-1:0] rd_data5
);

    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] ram0 [0:DEPTH-1];
    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] ram1 [0:DEPTH-1];

    always @(posedge clk) begin
        if (we0) begin
            ram0[wr_addr0] <= wr_data0;
        end
    end

    always @(posedge clk) begin
        if (we1) begin
            ram1[wr_addr1] <= wr_data1;
        end
    end

    always @(posedge clk) begin
        if (re0) begin
            rd_data0 <= ram0[rd_addr0];
        end
    end
    always @(posedge clk) begin
        if (re1) begin
            rd_data1 <= ram0[rd_addr1];
        end
    end

    always @(posedge clk) begin
        if (re2) begin
            rd_data2 <= ram1[rd_addr2];
        end
    end
    always @(posedge clk) begin
        if (re3) begin
            rd_data3 <= ram1[rd_addr3];
        end
    end
    always @(posedge clk) begin
        if (re4) begin
            rd_data4 <= ram1[rd_addr4];
        end
    end
    always @(posedge clk) begin
        if (re5) begin
            rd_data5 <= ram1[rd_addr5];
        end
    end


endmodule
