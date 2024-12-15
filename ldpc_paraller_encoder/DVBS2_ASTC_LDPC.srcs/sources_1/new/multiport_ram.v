module multiport_ram #(
    parameter ADDR_WIDTH = 7,
    parameter DATA_WIDTH = 360,
    parameter DEPTH = 72,
    parameter NUM_READ_PORTS = 2,  // 可配置的读端口数量
    parameter NUM_WRITE_PORTS = 1  // 可配置的写端口数量
)(
    input clk,
    input rst_n,

    // Read ports
    input [NUM_READ_PORTS-1:0] re,
    input [NUM_READ_PORTS*ADDR_WIDTH-1:0] rd_addr,
    output [NUM_READ_PORTS*DATA_WIDTH-1:0] rd_data,
    
    // Write ports
    input [NUM_WRITE_PORTS-1:0] we,
    input [NUM_WRITE_PORTS*ADDR_WIDTH-1:0] wr_addr,
    input [NUM_WRITE_PORTS*DATA_WIDTH-1:0] wr_data
);

    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] bram [0:DEPTH-1];

    reg [DATA_WIDTH-1:0] rd_data_reg [0:NUM_READ_PORTS-1];
    integer k;
    genvar i;
    generate
        for (i = 0; i < NUM_READ_PORTS; i = i + 1) begin: read_ports
            wire [ADDR_WIDTH-1:0] rd_addr_i;
            assign rd_addr_i = rd_addr[(i+1)*ADDR_WIDTH-1:i*ADDR_WIDTH];
            
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    for (k = 0; k < DEPTH; k = k + 1) begin
                        // bram[k] <= {({40{4'h1}}), {200'h0}};
                        bram[k] = 360'd1;
                    end
                end else begin
                    if (re[i] && (we && (wr_addr == rd_addr_i))) begin
                        // 如果当前读写地址冲突，直接将写入数据赋值给读出端口
                        rd_data_reg[i] <= wr_data[DATA_WIDTH-1:0];
                    end else if (re[i]) begin
                        rd_data_reg[i] <= bram[rd_addr_i];
                    end else begin
                        rd_data_reg[i] <= 0;
                    end
                end
            end
            assign rd_data[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH] = rd_data_reg[i];
        end
    endgenerate

    genvar j;
    generate
        for (j = 0; j < NUM_WRITE_PORTS; j = j + 1) begin: write_ports
            wire [ADDR_WIDTH-1:0] wr_addr_j;
            wire [DATA_WIDTH-1:0] wr_data_j;

            assign wr_addr_j = wr_addr[(j+1)*ADDR_WIDTH-1:j*ADDR_WIDTH];
            assign wr_data_j = wr_data[(j+1)*DATA_WIDTH-1:j*DATA_WIDTH];

            always @(posedge clk) begin
                if (we[j]) begin
                    bram[wr_addr_j] <= wr_data_j;
                end
            end
        end
    endgenerate

endmodule
