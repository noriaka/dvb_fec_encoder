// `timescale 1ns / 1ps

// module pm_test(
//     input                   clk,
//     input                   rst_n,
//     output reg [107:0]      pm_out
// );

// //--------------------------------
// // 参数
// //--------------------------------
// parameter ADDR_WIDTH = 6;   // 能寻址到 54 行 (2^6 = 64 > 54)
// parameter DATA_WIDTH = 360; // 每行 360 bit
// parameter DEPTH      = 54;  // 行数
// parameter NUM_READ_PORTS = 1;

// //--------------------------------
// // RAM 端口信号
// //--------------------------------
// reg [ADDR_WIDTH-1:0] wr_addr0, wr_addr1;
// reg [DATA_WIDTH-1:0] wr_data0, wr_data1;
// reg                  we0, we1;

// reg [ADDR_WIDTH-1:0] rd_addr0, rd_addr1;
// wire [DATA_WIDTH-1:0] rd_data0, rd_data1;
// reg                  re0, re1;  // 在读阶段一直为1

// //--------------------------------
// // 实例化 RAM
// //--------------------------------
// ram_1r1w #(
//     .ADDR_WIDTH    (ADDR_WIDTH),
//     .DATA_WIDTH    (DATA_WIDTH),
//     .DEPTH         (DEPTH),
//     .NUM_READ_PORTS(NUM_READ_PORTS)
// ) ram1_inst (
//     .clk       (clk),
//     .re0       (re0),
//     .rd_addr0  (rd_addr0),
//     .rd_data0  (rd_data0),
//     .we        (we0),
//     .wr_addr   (wr_addr0),
//     .wr_data   (wr_data0)
// );

// ram_1r1w #(
//     .ADDR_WIDTH    (ADDR_WIDTH),
//     .DATA_WIDTH    (DATA_WIDTH),
//     .DEPTH         (DEPTH),
//     .NUM_READ_PORTS(NUM_READ_PORTS)
// ) ram2_inst (
//     .clk       (clk),
//     .re0       (re1),
//     .rd_addr0  (rd_addr1),
//     .rd_data0  (rd_data1),
//     .we        (we1),
//     .wr_addr   (wr_addr1),
//     .wr_data   (wr_data1)
// );

// //--------------------------------
// // 状态机定义
// //--------------------------------
// reg [3:0] state;
// localparam IDLE         = 4'd0;
// localparam WRITE_RAM    = 4'd1;
// localparam WAIT_WRITE   = 4'd2;
// localparam COL_INIT     = 4'd3;  // 准备开始处理第 col_cnt 列
// localparam ROW_INIT     = 4'd4;  // 给出 row_cnt 地址
// localparam ROW_WAIT     = 4'd5;  // 等待读出
// localparam ROW_LATCH    = 4'd6;  // 取该行 col_cnt 列的 bit
// localparam ROW_NEXT     = 4'd7;
// localparam COL_OUT      = 4'd8;  // 108 bit 输出
// localparam COL_NEXT     = 4'd9;  // 下一列

// //--------------------------------
// // 写相关计数
// //--------------------------------
// reg [ADDR_WIDTH-1:0] wr_cnt;  // 写地址计数(0~53)

// //--------------------------------
// // 读相关计数
// //--------------------------------
// reg [8:0] col_cnt;            // 列号(0~359)
// reg [ADDR_WIDTH-1:0] row_cnt; // 行号(0~53)

// //--------------------------------
// // 中间寄存器
// //--------------------------------
// reg [DATA_WIDTH-1:0] row_data0;   // 来自 ram1 的一整行
// reg [DATA_WIDTH-1:0] row_data1;   // 来自 ram2 的一整行
// reg [107:0]          pm_buffer;   // 暂存一个列拼接结果

// //--------------------------------
// // 主状态机
// //--------------------------------
// always @(posedge clk or negedge rst_n) begin
//     if (!rst_n) begin
//         //--------------------------------
//         // 异步复位：全部清零
//         //--------------------------------
//         state      <= IDLE;
        
//         // 写控制
//         we0        <= 1'b0;
//         we1        <= 1'b0;
//         wr_cnt     <= 0;
//         wr_addr0   <= 0;
//         wr_addr1   <= 0;
//         wr_data0   <= {180{2'b01}};
//         wr_data1   <= {180{2'b01}};
        
//         // 读控制
//         re0        <= 1'b0;
//         re1        <= 1'b0;
//         rd_addr0   <= 0;
//         rd_addr1   <= 0;
//         row_data0  <= 0;
//         row_data1  <= 0;
        
//         // 输出
//         col_cnt    <= 0;
//         row_cnt    <= 0;
//         pm_buffer  <= 108'd0;
//         pm_out     <= 108'd0;
//     end
//     else begin
//         case (state)
//         //-------------------------
//         // IDLE：进入写RAM准备
//         //-------------------------
//         IDLE: begin
//             // 打开写使能，准备写
//             we0 <= 1'b1;
//             we1 <= 1'b1;
//             wr_cnt <= 0;
            
//             // 每行都写 {180{2'b01}} = 360 bit "010101..."
//             wr_data0 <= {180{2'b01}};
//             wr_data1 <= {180{2'b01}};
//             state <= WRITE_RAM;
//         end

//         //-------------------------
//         // WRITE_RAM：逐行写
//         //-------------------------
//         WRITE_RAM: begin
//             // 行地址
//             wr_addr0 <= wr_cnt;
//             wr_addr1 <= wr_cnt;

//             // 若写到最后一行了 -> 关闭写使能
//             if (wr_cnt == (DEPTH - 1)) begin
//                 state <= WAIT_WRITE;
//             end
//             else begin
//                 wr_cnt <= wr_cnt + 1'b1;
//             end
//         end

//         //-------------------------
//         // WAIT_WRITE：等待一拍
//         // 然后开始“逐列输出”
//         //-------------------------
//         WAIT_WRITE: begin
//             // 一次性把读使能全打开
//             we0 <= 1'b0;
//             we1 <= 1'b0;
//             re0 <= 1'b1;
//             re1 <= 1'b1;
            
//             col_cnt <= 0;    // 从第 0 列开始
//             state   <= COL_INIT;
//         end

//         //-------------------------
//         // COL_INIT：准备处理第 col_cnt 列
//         //-------------------------
//         COL_INIT: begin
//             row_cnt   <= 0;            // 从第 0 行开始
//             pm_buffer <= 108'd0;       // 清空拼接寄存器
//             state     <= ROW_INIT;
//         end

//         //-------------------------
//         // ROW_INIT：给出 row_cnt 行的地址
//         //-------------------------
//         ROW_INIT: begin
//             rd_addr0 <= row_cnt;
//             rd_addr1 <= row_cnt;
//             state    <= ROW_WAIT;  
//         end

//         //-------------------------
//         // ROW_WAIT：同步读，下一拍拿到rd_data
//         //-------------------------
//         ROW_WAIT: begin
//             row_data0 <= rd_data0; 
//             row_data1 <= rd_data1; 
//             state     <= ROW_LATCH;
//         end

//         //-------------------------
//         // ROW_LATCH：取col_cnt列的bit
//         // 拼到pm_buffer
//         //-------------------------
//         ROW_LATCH: begin
//             pm_buffer[2*row_cnt]     <= row_data0[col_cnt];
//             pm_buffer[2*row_cnt + 1] <= row_data1[col_cnt];
//             state <= ROW_NEXT;
//         end

//         //-------------------------
//         // ROW_NEXT：检查是否行读完
//         //-------------------------
//         ROW_NEXT: begin
//             if (row_cnt == (DEPTH - 1)) begin
//                 // 54 行读完 -> 输出
//                 state <= COL_OUT;
//             end
//             else begin
//                 row_cnt <= row_cnt + 1'b1;
//                 state   <= ROW_INIT;
//             end
//         end

//         //-------------------------
//         // COL_OUT：把 108 bit 输出
//         //-------------------------
//         COL_OUT: begin
//             pm_out <= pm_buffer;
//             state  <= COL_NEXT;
//         end

//         //-------------------------
//         // COL_NEXT：检查列是否处理完
//         //-------------------------
//         COL_NEXT: begin
//             if (col_cnt == 359) begin
//                 // 所有列(0~359)处理完 -> 回IDLE
//                 // 并关闭读使能
//                 re0 <= 1'b0;
//                 re1 <= 1'b0;
//                 state <= IDLE;
//             end
//             else begin
//                 col_cnt <= col_cnt + 1'b1;
//                 state   <= COL_INIT;
//             end
//         end

//         default: begin
//             state <= IDLE;
//         end
//         endcase
//     end
// end

// endmodule

//-----------------------------------------------------------------

`timescale 1ns / 1ps

module pm_test(
    input                   clk,
    input                   rst_n,
    output reg [107:0]      pm_out
);

//================================================================
// 1) 参数
//================================================================
parameter ADDR_WIDTH    = 6;    // 行地址可寻址到54 (2^6=64)
parameter DATA_WIDTH    = 360;  // 每行 360 bit
parameter DEPTH         = 54;   // 行数
parameter NUM_READ_PORTS= 1;

//================================================================
// 2) RAM端口 & 本地信号
//================================================================
reg                  we0, we1;
reg                  re0, re1;
reg [ADDR_WIDTH-1:0] wr_addr0, wr_addr1;
reg [DATA_WIDTH-1:0] wr_data0, wr_data1;
wire[DATA_WIDTH-1:0] rd_data0, rd_data1;
reg [ADDR_WIDTH-1:0] rd_addr0, rd_addr1;

//----------------------------------------------------------------
//  实例化 RAM
//----------------------------------------------------------------
ram_1r1w #(
    .ADDR_WIDTH    (ADDR_WIDTH),
    .DATA_WIDTH    (DATA_WIDTH),
    .DEPTH         (DEPTH),
    .NUM_READ_PORTS(NUM_READ_PORTS)
) ram1_inst (
    .clk       (clk),
    .re0       (re0),
    .rd_addr0  (rd_addr0),
    .rd_data0  (rd_data0),
    .we        (we0),
    .wr_addr   (wr_addr0),
    .wr_data   (wr_data0)
);

ram_1r1w #(
    .ADDR_WIDTH    (ADDR_WIDTH),
    .DATA_WIDTH    (DATA_WIDTH),
    .DEPTH         (DEPTH),
    .NUM_READ_PORTS(NUM_READ_PORTS)
) ram2_inst (
    .clk       (clk),
    .re0       (re1),
    .rd_addr0  (rd_addr1),
    .rd_data0  (rd_data1),
    .we        (we1),
    .wr_addr   (wr_addr1),
    .wr_data   (wr_data1)
);

//================================================================
// 3) 本地缓冲区: 把 RAM 的所有行都读进来
//    localmem1[row]、localmem2[row] 分别是 360 bit
//================================================================
reg [DATA_WIDTH-1:0] localmem1 [0:DEPTH-1];
reg [DATA_WIDTH-1:0] localmem2 [0:DEPTH-1];

//================================================================
// 4) 状态机定义
//================================================================
reg [4:0] state;
localparam IDLE           = 5'd0,
           WRITE_RAM      = 5'd1,
           WAIT_WRITE     = 5'd2,
           BULK_READ_INIT = 5'd3,
           BULK_READ_ADDR = 5'd4,
           BULK_READ_WAIT = 5'd5,
           BULK_READ_SAVE = 5'd6,
           BULK_READ_DONE = 5'd7,
           PROC_COL_INIT  = 5'd8,
           PROC_COL_OUT   = 5'd9,
           PROC_COL_NEXT  = 5'd10,
           DONE           = 5'd31;  // 末状态(仅示例)


//================================================================
// 5) 读写计数器
//================================================================
reg [ADDR_WIDTH-1:0] wr_cnt;   // 写行数(0~53)
reg [ADDR_WIDTH-1:0] rd_cnt;   // 读行数(0~53)
reg [8:0]            col_cnt;  // 列数(0~359)

//================================================================
// 6) 用于拼列输出
//================================================================
reg [107:0] pm_buffer;  // 暂存 1 列(108 bit)

//----------------------------------------------------------
// 7) 组合逻辑: 生成 pm_buffer[107:0] (可在1拍内做完)
//   每当 col_cnt 改变时, 我们把 localmemX 中对应列的
//   1 bit 全部取出, 拼成 108 bit
//----------------------------------------------------------
integer i;
always @* begin
    // 缺省清0
    pm_buffer = 108'd0;
    // row=0..53, ram1 -> bit[2*row], ram2 -> bit[2*row+1]
    for (i = 0; i < DEPTH; i = i + 1) begin
        pm_buffer[2*i]   = localmem1[i][col_cnt];
        pm_buffer[2*i+1] = localmem2[i][col_cnt];
    end
end

//================================================================
// 8) 主状态机
//================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        //------------------------------------------------------
        // 异步复位
        //------------------------------------------------------
        state     <= IDLE;
        
        we0       <= 1'b0;
        we1       <= 1'b0;
        re0       <= 1'b0;
        re1       <= 1'b0;
        
        wr_cnt    <= 0;
        rd_cnt    <= 0;
        col_cnt   <= 0;
        
        wr_addr0  <= 0;  wr_addr1  <= 0;
        wr_data0  <= 0;  wr_data1  <= 0;
        rd_addr0  <= 0;  rd_addr1  <= 0;
        
        pm_out    <= 108'd0;
    end
    else begin
        case (state)
        //------------------------------------------------------
        // IDLE: 进入写RAM演示(可选)
        //------------------------------------------------------
        IDLE: begin
            // 如果不需要写RAM, 可直接跳到 BULK_READ_INIT
            // 这里演示: we0/we1=1, 写DEPTH行 {180{2'b01}} 数据
            we0 <= 1'b1;
            we1 <= 1'b1;
            wr_cnt <= 0;
            
            wr_data0 <= {180{2'b01}};
            wr_data1 <= {180{2'b01}};
            
            state <= WRITE_RAM;
        end

        //------------------------------------------------------
        // WRITE_RAM: 每拍写一行
        //------------------------------------------------------
        WRITE_RAM: begin
            wr_addr0 <= wr_cnt;
            wr_addr1 <= wr_cnt;
            
            if (wr_cnt == (DEPTH - 1)) begin
                state <= WAIT_WRITE;
            end
            else begin
                wr_cnt <= wr_cnt + 1'b1;
            end
        end

        //------------------------------------------------------
        // WAIT_WRITE: 保持一拍, 准备进入BULK_READ
        //------------------------------------------------------
        WAIT_WRITE: begin
            // 最后一行写完
            we0 <= 1'b0;
            we1 <= 1'b0;
            re0 <= 1'b1;   // 打开读使能
            re1 <= 1'b1;
            state <= BULK_READ_INIT;
        end

        //------------------------------------------------------
        // BULK_READ_INIT: 准备一次性读完(0~53行)
        //------------------------------------------------------
        BULK_READ_INIT: begin
            rd_cnt <= 0;
            state  <= BULK_READ_ADDR;
        end

        //------------------------------------------------------
        // BULK_READ_ADDR: 对 ram1, ram2 读 rd_cnt 行地址
        //------------------------------------------------------
        BULK_READ_ADDR: begin
            rd_addr0 <= rd_cnt;
            rd_addr1 <= rd_cnt;
            state    <= BULK_READ_WAIT; // 下一拍才能拿到数据
        end

        //------------------------------------------------------
        // BULK_READ_WAIT: 等待读数据 (rd_data0, rd_data1)
        //------------------------------------------------------
        BULK_READ_WAIT: begin
            // 此拍拿到 rd_data0, rd_data1
            // 下一拍再保存到本地缓冲(也可在本拍直接存, 看时序需求)
            state <= BULK_READ_SAVE;
        end

        //------------------------------------------------------
        // BULK_READ_SAVE: 把 rd_data0/rd_data1 存到 localmemX[rd_cnt]
        //------------------------------------------------------
        BULK_READ_SAVE: begin
            localmem1[rd_cnt] <= rd_data0;
            localmem2[rd_cnt] <= rd_data1;
            
            if (rd_cnt == (DEPTH - 1)) begin
                // 全部行都读完
                state <= BULK_READ_DONE;
            end
            else begin
                rd_cnt <= rd_cnt + 1'b1;
                state  <= BULK_READ_ADDR; // 继续读下一行
            end
        end

        //------------------------------------------------------
        // BULK_READ_DONE: 完整数据都在localmem1/localmem2里
        //------------------------------------------------------
        BULK_READ_DONE: begin
            // 准备进入列处理
            col_cnt <= 0;
            state   <= PROC_COL_INIT;
        end

        //------------------------------------------------------
        // PROC_COL_INIT: 准备输出第 col_cnt 列
        //------------------------------------------------------
        PROC_COL_INIT: begin
            // pm_buffer 的组合逻辑在 always @* 里自动构造
            // 这拍无需做额外事, 直接到下一拍把结果输出
            state <= PROC_COL_OUT;
        end

        //------------------------------------------------------
        // PROC_COL_OUT: 把 pm_buffer输出到 pm_out
        //------------------------------------------------------
        PROC_COL_OUT: begin
            pm_out <= pm_buffer; // 1 拍完成一列输出
            state  <= PROC_COL_NEXT;
        end

        //------------------------------------------------------
        // PROC_COL_NEXT: 判断是否所有列(0~359)都完成
        //------------------------------------------------------
        PROC_COL_NEXT: begin
            if (col_cnt == 359) begin
                // 所有列处理完
                state <= DONE;
            end
            else begin
                col_cnt <= col_cnt + 1'b1;
                state   <= PROC_COL_INIT;
            end
        end

        //------------------------------------------------------
        // DONE: 回到 IDLE 或其他逻辑
        //------------------------------------------------------
        DONE: begin
            // 可在此根据需求选择跳转
            // 这里示例跳回 IDLE
            state <= IDLE;
        end

        default: begin
            state <= IDLE;
        end
        endcase
    end
end

endmodule
