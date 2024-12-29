module multiport_ram #(
    parameter ADDR_WIDTH = 7,
    parameter DATA_WIDTH = 360,
    parameter DEPTH = 72,
    parameter NUM_READ_PORTS = 2
)(
    input clk,

    // Read ports
    input                           re0,
    input [ADDR_WIDTH-1:0]          rd_addr0,
    output reg [DATA_WIDTH-1:0]     rd_data0,
    input                           re1,
    input [ADDR_WIDTH-1:0]          rd_addr1,
    output reg [DATA_WIDTH-1:0]     rd_data1,
    input                           re2,
    input [ADDR_WIDTH-1:0]          rd_addr2,
    output reg [DATA_WIDTH-1:0]     rd_data2,
    input                           re3,
    input [ADDR_WIDTH-1:0]          rd_addr3,
    output reg [DATA_WIDTH-1:0]     rd_data3,

    // write ports
    input                           we0,
    input [ADDR_WIDTH-1:0]          wr_addr0,
    input [DATA_WIDTH-1:0]          wr_data0
);

    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];

    // Read
    always @(posedge clk) begin
        if (re0) begin
            rd_data0 <= ram[rd_addr0];
        end
    end
    always @(posedge clk) begin
        if (re1) begin
            rd_data1 <= ram[rd_addr1];
        end
    end
    always @(posedge clk) begin
        if (re2) begin
            rd_data2 <= ram[rd_addr2];
        end
    end
    always @(posedge clk) begin
        if (re3) begin
            rd_data3 <= ram[rd_addr3];
        end
    end

    // Write
    always @(posedge clk) begin
        if (we0) begin
            ram[wr_addr0] <= wr_data0;
        end
    end

    // reg [DATA_WIDTH-1:0] rd_data_reg [0:NUM_READ_PORTS-1];
    // integer k;
    // genvar i;
    // generate
    //     for (i = 0; i < NUM_READ_PORTS; i = i + 1) begin: read_ports
    //         wire [ADDR_WIDTH-1:0] rd_addr_i;
    //         assign rd_addr_i = rd_addr[(i+1)*ADDR_WIDTH-1:i*ADDR_WIDTH];
            
    //         always @(posedge clk or negedge rst_n) begin
    //             if (!rst_n) begin
    //                 for (k = 0; k < DEPTH; k = k + 1) begin
    //                     // bram[k] <= {({40{4'h1}}), {200'h0}};
    //                     bram[k] = 360'd1;
    //                 end
    //             end else begin
    //                 if (re[i] && (we && (wr_addr == rd_addr_i))) begin
    //                     // 如果当前读写地址冲突，直接将写入数据赋值给读出端口
    //                     rd_data_reg[i] <= wr_data[DATA_WIDTH-1:0];
    //                 end else if (re[i]) begin
    //                     rd_data_reg[i] <= bram[rd_addr_i];
    //                 end else begin
    //                     rd_data_reg[i] <= 0;
    //                 end
    //             end
    //         end
    //         assign rd_data[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH] = rd_data_reg[i];
    //     end
    // endgenerate

    // genvar j;
    // generate
    //     for (j = 0; j < NUM_WRITE_PORTS; j = j + 1) begin: write_ports
    //         wire [ADDR_WIDTH-1:0] wr_addr_j;
    //         wire [DATA_WIDTH-1:0] wr_data_j;

    //         assign wr_addr_j = wr_addr[(j+1)*ADDR_WIDTH-1:j*ADDR_WIDTH];
    //         assign wr_data_j = wr_data[(j+1)*DATA_WIDTH-1:j*DATA_WIDTH];

    //         always @(posedge clk) begin
    //             if (we[j]) begin
    //                 bram[wr_addr_j] <= wr_data_j;
    //             end
    //         end
    //     end
    // endgenerate

endmodule
