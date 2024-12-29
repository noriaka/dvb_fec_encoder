`timescale 1ps / 1ps
module dvbs2_tx_tb();

reg                 enable;
reg [31:0]          data_in;
wire                read_in_ret;

reg                 clk_25MHz;
reg                 clk_50MHz;
reg                 clk_100MHz;
wire                clk_600MHz;

reg                 reset;

always #20000       clk_25MHz = ~clk_25MHz;
always #5000        clk_100MHz = ~clk_100MHz;
// always #833         clk_600MHz = ~clk_600MHz;
always #10000       clk_50MHz = ~clk_50MHz;

reg [0:114303]      frame_in;
integer             file;
integer             i;

initial begin
    clk_25MHz = 1;
    clk_50MHz = 1;
    clk_100MHz = 1;
    // clk_600MHz = 1;

    enable = 0;
    reset = 1;
    
    file = $fopen("F:\\ProjectFileFolder\\MatlabProject\\dvb\\data_in_new.txt", "r");
    if (file == 0) begin
        $display("无法打开文件");
        $finish;
    end

    for (i = 0; i < 114304; i = i + 1) begin
        if (!$feof(file)) begin
            $fscanf(file, "%b", frame_in[i]);
        end
    end

    $fclose(file);
    data_in = {frame_in[24:31], frame_in[16:23], 
                frame_in[8:15], frame_in[0:7]};


    #5000
    enable = 1;
    reset = 0;
end


// clk_wiz_1 change//时钟倍频IP核
// (
//     // Clock out ports
//     .clk_out1(clk_600MHz),      // output clk_out1
//     .clk_in1(clk_100MHz)
// );

reg [20:0]              cnt;
always @(posedge clk_50MHz or posedge reset) begin
    if (reset) begin
        cnt <= 32;
    end else if (cnt == 114304) begin
        cnt <= cnt;
    end else begin
        if (read_in_ret == 1) begin
            // data_in <= frame_in[cnt+:32];
            data_in <= {frame_in[(cnt+24)+:8], frame_in[(cnt+16)+:8],
                        frame_in[(cnt+8)+:8], frame_in[cnt+:8]};
            // $display(data_in);
            cnt <= cnt + 32;      
        end
    end
end

wire [31:0]             fir_i_out;
wire [31:0]             fir_q_out;

dvbs2_tx dvbs2_tx_inst(
    .clk_25MHz              (clk_25MHz),
    .clk_50MHz              (clk_50MHz),
    .clk_100MHz             (clk_100MHz),
    .enable                 (enable),
    .reset                  (reset),
    .data_in                (data_in),
    .read_in_ret            (read_in_ret),
    .fir_i_out              (fir_i_out),
    .fir_q_out              (fir_q_out)
);

// // Internal Signals
// wire                bbheader_bit_out;
// wire                bbheader_valid_out;
// wire                bbheader_error;
// wire                bbscrambler_bit_out;
// wire                bbscrambler_valid_out;
// wire                bchencoder_bit_out;
// wire                bchencoder_valid_out;
// wire                bchencoder_error;
// wire                ldpcencoder_bit_out;
// wire                ldpcencoder_valid_out;
// wire                ldpcencoder_error;
// wire                interleaver_bit_out;
// wire                interleaver_valid_out;
// wire [2:0]          bitmapper_sym_i_out;
// wire [2:0]          bitmapper_sym_q_out;
// wire                bitmapper_valid_out;
// wire [2:0]          phyframer_sym_i_out;
// wire [2:0]          phyframer_sym_q_out;
// wire                phyframer_valid_out;
// wire                phyframer_error;
// wire [11:0]         output_sync_sym_i_out;
// wire [11:0]         output_sync_sym_q_out;
// wire                output_sync_valid_out;
// wire                output_sync_error;
// wire		        fifo_switch_performed;
// wire		        fifo_wr_sel;
// wire		        done_out;
// wire                actual_out;

// dvb_fifo_reader dvb_fifo_reader_inst(
//     .clock_data_in      (clk_100MHz),
//     .enable             (enable),
//     .in_reset           (reset),
//     .empty_in           (empty_in),
//     .data_in            (data_in),
//     .read_in_ret        (read_in_ret),
//     .clock_data_out     (clk_100MHz),
//     .out_reset          (reset),
//     .valid_out          (reader_valid_out),
//     .data_out           (reader_data_out),
//     .first_data         (first_data)
// );

// bbheader bbheader_inst(
//     .clock            (clk_100MHz),
//     .reset            (reset),
//     .enable           (first_data),
//     .bit_in           (reader_data_out),
//     .valid_in         (reader_valid_out),
//     .bit_out          (bbheader_bit_out),
//     .valid_out        (bbheader_valid_out),
//     .error            (bbheader_error)
// );

// dvbs2_bbscrambler dvbs2_bbscrambler_inst(
//     .clock          (clk_100MHz),
//     .reset          (reset),
//     .enable         (enable),
//     .bit_in         (bbheader_bit_out),
//     .valid_in       (bbheader_valid_out),
//     .bit_out        (bbscrambler_bit_out),
//     .valid_out      (bbscrambler_valid_out)
// );

// dvbs2_bchencoder dvbs2_bchencoder_inst (
//     .clock          (clk_100MHz),
//     .reset          (reset),
//     .enable         (enable),
//     .bit_in         (bbscrambler_bit_out),
//     .valid_in       (bbscrambler_valid_out),
//     .bit_out        (bchencoder_bit_out),
//     .valid_out      (bchencoder_valid_out),
//     .error          (bchencoder_error)
// );

// dvbs2_ldpcencoder dvbs2_ldpcencoder_inst (
//     .clock_16MHz    (clk_100MHz),
//     .clock_96MHz    (clk_600MHz),
//     .reset          (reset),
//     .enable         (enable),
//     .bit_in         (bchencoder_bit_out),
//     .valid_in       (bchencoder_valid_out),
//     .bit_out        (ldpcencoder_bit_out),
//     .valid_out      (ldpcencoder_valid_out),
//     .error          (ldpcencoder_error)
// );

// dvbs2_interleaver dvbs2_interleaver_inst (
//     .clock          (clk_100MHz),
//     .reset          (reset),
//     .enable         (enable),
//     .bit_in         (ldpcencoder_bit_out),
//     .valid_in       (ldpcencoder_valid_out),
//     .bit_out        (interleaver_bit_out),
//     .valid_out      (interleaver_valid_out)
// );

// dvbs2_bitmapper dvbs2_bitmapper_inst (
//     .clock_in       (clk_100MHz),
//     .reset          (reset),
//     .enable         (enable),
//     .bit_in         (interleaver_bit_out),
//     .clock_out      (clk_25MHz),
//     .valid_in       (interleaver_valid_out),
//     .sym_i          (bitmapper_sym_i_out),
//     .sym_q          (bitmapper_sym_q_out),
//     .valid_out      (bitmapper_valid_out)
// );

// dvbs2_phyframer dvbs2_phyframer_inst (
//     // Inputs and Outputs
//     .clock_in               (clk_25MHz), // Input clock. Write input data into FIFO at this rate.
//     .reset                  (reset), // Synchronous reset
//     .enable                 (enable), // Input enable
//     .sym_i_in               (bitmapper_sym_i_out), // I portion of input symbol
//     .sym_q_in               (bitmapper_sym_q_out), // Q portion of input symbol
//     .valid_in               (bitmapper_valid_out), // Raised if input symbol is valid (see if data is present)
//     .clock_out              (clk_100MHz), // Output clock. Internally processing done at this rate.
//     .fifo_switch_performed  (fifo_switch_performed),
//     .sym_i_out              (phyframer_sym_i_out), // I portion of output symbol
//     .sym_q_out              (phyframer_sym_q_out),// Q portion of output symbol
//     .valid_out              (phyframer_valid_out), // Raised if output symbol is valid
//     .error                  (phyframer_error), // Raised if there is a FIFO error
//     .done_out               (done_out),
//     .fifo_wr_sel            (fifo_wr_sel)
// );

// dvbs2_output_sync dvbs2_output_sync_inst (
//     .clock_in                (clk_100MHz), // Input clock. Write input data into FIFO at this rate.
//     .reset                   (reset), // Synchronous reset
//     .enable                  (enable),// Input enable
//     .sym_i_in                (phyframer_sym_i_out), // I portion of input symbol
//     .sym_q_in                (phyframer_sym_q_out), // Q portion of input symbol
//     .valid_in                (phyframer_valid_out), // Raised if input symbol is valid (see if data is present)
//     .output_clock            (clk_100MHz),// Output clock - based on symbol rate
//     .output_reset            (reset),
//     .done_out                (done_out),
//     .fifo_wr_sel             (fifo_wr_sel),
//     .sym_i_out               (output_sync_sym_i_out),// I portion of output symbol
//     .sym_q_out               (output_sync_sym_q_out), // Q portion of output symbol
//     .valid_out               (output_sync_valid_out),// Raised if output symbol is valid
//     .error                   (output_sync_error), // Raised if there is a FIFO error
//     .actual_out              (actual_out),
//     .fifo_switch_performed   (fifo_switch_performed)
// );

// reg            en_fir;
// wire [24:0]    fir_i_out;
// wire [24:0]    fir_q_out;

// always @(posedge clk_600MHz or posedge reset) begin//使能信号拉高要快
//     if (reset)
//         en_fir <= 0;
//     else begin
//         if (actual_out == 1)
//             en_fir <= 1; 
//     end
// end

// fir_filter fir_filter_i_inst (
//     .clk                     (clk_50MHz),
//     .rst                     (reset),
//     .enable                  (en_fir),
//     .fir_in                  (output_sync_sym_i_out),
//     .valid_in                (output_sync_valid_out),
//     .fir_out                 (fir_i_out)
// );

// fir_filter fir_filter_q_inst (
//     .clk                     (clk_50MHz),
//     .rst                     (reset),
//     .enable                  (en_fir),
//     .fir_in                  (output_sync_sym_q_out),
//     .valid_in                (output_sync_valid_out),
//     .fir_out                 (fir_q_out)
// );

integer file_out_i;
integer file_out_q;

initial begin
    file_out_i = $fopen("F:\\FileFolder\\Graduation_Project\\DVB-S2-FPGA\\Git\\dvb_fpga\\test_data\\fir_i_out.txt", "w");
    file_out_q = $fopen("F:\\FileFolder\\Graduation_Project\\DVB-S2-FPGA\\Git\\dvb_fpga\\test_data\\fir_q_out.txt", "w");
end

/*----------------fir_out-------------------------*/
reg [20:0]          cnt_symb;
reg                 en_wr;
always @(posedge clk_100MHz or posedge reset) begin
    if (reset) begin
        en_wr <= 0;
    end else begin
        if (fir_i_out != 0)
            en_wr <= 1;
    end
end

always @(posedge clk_50MHz or posedge reset) begin
    if (reset) begin
        cnt_symb <= 0;
    end else if (en_wr == 1) begin
        if (cnt_symb == 20'd66744) begin
            $fclose(file_out_i);
            $fclose(file_out_q);
            $finish;
        end else begin
            $fwrite(file_out_i, "%h\n",fir_i_out);
            $fwrite(file_out_q, "%h\n",fir_q_out);
            cnt_symb <= cnt_symb + 1;
        end
    end
end

endmodule