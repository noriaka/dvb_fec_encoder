`timescale 1ps / 1ps
module dvbs2_tx(
    input           clk_25MHz,
    input           clk_50MHz,
    input           clk_100MHz,
    input           enable,
    input           reset,
    input [31:0]    data_in,
    output          read_in_ret,
    output [31:0]   fir_i_out,
    output [31:0]   fir_q_out
);

// Internal Signals
wire                read_in_ret;
wire                reader_data_out;
wire                reader_valid_out;
wire                first_data;

wire                bbheader_bit_out;
wire                bbheader_valid_out;
wire                bbheader_error;
wire                bbscrambler_bit_out;
wire                bbscrambler_valid_out;
wire                bchencoder_bit_out;
wire                bchencoder_valid_out;
wire                bchencoder_error;
wire                ldpcencoder_bit_out;
wire                ldpcencoder_valid_out;
wire                ldpcencoder_error;
wire                interleaver_bit_out;
wire                interleaver_valid_out;
wire [2:0]          bitmapper_sym_i_out;
wire [2:0]          bitmapper_sym_q_out;
wire                bitmapper_valid_out;
wire [2:0]          phyframer_sym_i_out;
wire [2:0]          phyframer_sym_q_out;
wire                phyframer_valid_out;
wire                phyframer_error;
wire [11:0]         output_sync_sym_i_out;
wire [11:0]         output_sync_sym_q_out;
wire                output_sync_valid_out;
wire                output_sync_error;
wire                fifo_switch_performed;
wire                fifo_wr_sel;
wire                done_out;
wire                actual_out;

wire                clk_600MHz;
clk_wiz_1 clk_wiz_1_inst        //时钟倍频IP核
(
    // Clock out ports
    .clk_out1(clk_600MHz),      // output clk_out1
    .clk_in1(clk_100MHz)
);

dvb_fifo_reader dvb_fifo_reader_inst(
    .clock_data_in      (clk_100MHz),
    .enable             (enable),
    .in_reset           (reset),
    .empty_in           (0),
    .data_in            (data_in),
    .read_in_ret        (read_in_ret),
    .clock_data_out     (clk_100MHz),
    .out_reset          (reset),
    .valid_out          (reader_valid_out),
    .data_out           (reader_data_out),
    .first_data         (first_data)
);

bbheader bbheader_inst(
    .clock            (clk_100MHz),
    .reset            (reset),
    .enable           (first_data),
    .bit_in           (reader_data_out),
    .valid_in         (reader_valid_out),
    .bit_out          (bbheader_bit_out),
    .valid_out        (bbheader_valid_out),
    .error            (bbheader_error)
);

dvbs2_bbscrambler dvbs2_bbscrambler_inst(
    .clock          (clk_100MHz),
    .reset          (reset),
    .enable         (enable),
    .bit_in         (bbheader_bit_out),
    .valid_in       (bbheader_valid_out),
    .bit_out        (bbscrambler_bit_out),
    .valid_out      (bbscrambler_valid_out)
);

dvbs2_bchencoder dvbs2_bchencoder_inst (
    .clock          (clk_100MHz),
    .reset          (reset),
    .enable         (enable),
    .bit_in         (bbscrambler_bit_out),
    .valid_in       (bbscrambler_valid_out),
    .bit_out        (bchencoder_bit_out),
    .valid_out      (bchencoder_valid_out),
    .error          (bchencoder_error)
);

dvbs2_ldpcencoder dvbs2_ldpcencoder_inst (
    .clock_16MHz    (clk_100MHz),
    .clock_96MHz    (clk_600MHz),
    .reset          (reset),
    .enable         (enable),
    .bit_in         (bchencoder_bit_out),
    .valid_in       (bchencoder_valid_out),
    .bit_out        (ldpcencoder_bit_out),
    .valid_out      (ldpcencoder_valid_out),
    .error          (ldpcencoder_error)
);

dvbs2_interleaver dvbs2_interleaver_inst (
    .clock          (clk_100MHz),
    .reset          (reset),
    .enable         (enable),
    .bit_in         (ldpcencoder_bit_out),
    .valid_in       (ldpcencoder_valid_out),
    .bit_out        (interleaver_bit_out),
    .valid_out      (interleaver_valid_out)
);

dvbs2_bitmapper dvbs2_bitmapper_inst (
    .clock_in       (clk_100MHz),
    .reset          (reset),
    .enable         (enable),
    .bit_in         (interleaver_bit_out),
    .clock_out      (clk_25MHz),
    .valid_in       (interleaver_valid_out),
    .sym_i          (bitmapper_sym_i_out),
    .sym_q          (bitmapper_sym_q_out),
    .valid_out      (bitmapper_valid_out)
);

dvbs2_phyframer dvbs2_phyframer_inst (
    // Inputs and Outputs
    .clock_in               (clk_25MHz), // Input clock. Write input data into FIFO at this rate.
    .reset                  (reset), // Synchronous reset
    .enable                 (enable), // Input enable
    .sym_i_in               (bitmapper_sym_i_out), // I portion of input symbol
    .sym_q_in               (bitmapper_sym_q_out), // Q portion of input symbol
    .valid_in               (bitmapper_valid_out), // Raised if input symbol is valid (see if data is present)
    .clock_out              (clk_100MHz), // Output clock. Internally processing done at this rate.
    .fifo_switch_performed  (fifo_switch_performed),
    .sym_i_out              (phyframer_sym_i_out), // I portion of output symbol
    .sym_q_out              (phyframer_sym_q_out),// Q portion of output symbol
    .valid_out              (phyframer_valid_out), // Raised if output symbol is valid
    .error                  (phyframer_error), // Raised if there is a FIFO error
    .done_out               (done_out),
    .fifo_wr_sel            (fifo_wr_sel)
);

dvbs2_output_sync dvbs2_output_sync_inst (
    .clock_in                (clk_100MHz), // Input clock. Write input data into FIFO at this rate.
    .reset                   (reset), // Synchronous reset
    .enable                  (enable),// Input enable
    .sym_i_in                (phyframer_sym_i_out), // I portion of input symbol
    .sym_q_in                (phyframer_sym_q_out), // Q portion of input symbol
    .valid_in                (phyframer_valid_out), // Raised if input symbol is valid (see if data is present)
    .output_clock            (clk_100MHz),// Output clock - based on symbol rate
    .output_reset            (reset),
    .done_out                (done_out),
    .fifo_wr_sel             (fifo_wr_sel),
    .sym_i_out               (output_sync_sym_i_out),// I portion of output symbol
    .sym_q_out               (output_sync_sym_q_out), // Q portion of output symbol
    .valid_out               (output_sync_valid_out),// Raised if output symbol is valid
    .error                   (output_sync_error), // Raised if there is a FIFO error
    .actual_out              (actual_out),
    .fifo_switch_performed   (fifo_switch_performed)
);

reg            en_fir;
wire [24:0]    fir_i;
wire [24:0]    fir_q;
wire [31:0]    fir_i_out;
wire [31:0]    fir_q_out;
assign fir_i_out = {7'b0000000, fir_i};
assign fir_q_out = {7'b0000000, fir_q};

always @(posedge clk_600MHz or posedge reset) begin//使能信号拉高要快
    if (reset)
        en_fir <= 0;
    else begin
        if (actual_out == 1)
            en_fir <= 1; 
    end
end

fir_filter fir_filter_i_inst (
    .clk                     (clk_50MHz),
    .rst                     (reset),
    .enable                  (en_fir),
    .fir_in                  (output_sync_sym_i_out),
    .valid_in                (output_sync_valid_out),
    .fir_out                 (fir_i)
);

fir_filter fir_filter_q_inst (
    .clk                     (clk_50MHz),
    .rst                     (reset),
    .enable                  (en_fir),
    .fir_in                  (output_sync_sym_q_out),
    .valid_in                (output_sync_valid_out),
    .fir_out                 (fir_q)
);

endmodule
