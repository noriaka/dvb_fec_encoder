`timescale 1ns / 1ps

module tb_lpdc_parallel_encoder();

reg                     clk;
reg                     rst_n;
reg                     clk_enable;
reg                     bit_in;
wire                    valid_out;
wire [18:0]             data_out;

// ldpc_parallel_encoder ldpc_parallel_encoder_inst(
//     .clk                (clk),
//     .rst_n              (rst_n),
//     .clk_enable         (clk_enable),
//     .bit_in             (bit_in),

//     .valid_out          (),
//     .data_out           ()
// );

test_ldpc_parallel_encoder test_ldpc_parallel_encoder_inst(
    .clk                (clk),
    .rst_n              (rst_n),
    .clk_enable         (clk_enable),
    .bit_in             (bit_in),

    .valid_out          (valid_out),
    .data_out           (data_out)
);

integer file;
integer count;

initial begin
    count = 0;
    file = $fopen("F:\\FileFolder\\Graduation_Project\\DVB-S2-FPGA\\Git\\dvb_fpga\\fpga_ldpc_data\\fpga_ldpc_data_6_15.txt", "w");
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 0;
    end else if (valid_out) begin
        if (count < 3600) begin
            $fwrite(file, "%h\n", data_out);
            count <= count + 1; // 增加计数
        end else begin
            $fclose(file); // 关闭文件
        end
    end
end


always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;
    rst_n = 0;
    clk_enable = 0;

    #20;
    rst_n = 1'b1;

    #20;
    clk_enable = 1'b1;
    // #1000;
    // $finish;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        bit_in <= 0;
    else begin
        if (clk_enable == 1)
            bit_in <= ~bit_in;
    end
end

endmodule
