`timescale 1 ns / 1 ns

module dvbs2hdlTransmitterCore_buffInpGenAddrQPSK(
        clk,
        reset,
        enb,
        dataIn,
        validIn,
        resetIn,
        addrBPSK,
        addrBPSKValidOut
);

input   clk;
input   reset;
input   enb;
input   dataIn;  // ufix1
input   validIn;  // ufix1
input   resetIn;  // ufix1
output  addrBPSK;  // ufix1
output  addrBPSKValidOut;  // ufix1

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        addrBPSK <= 1'b0;
        addrBPSKValidOut <= 1'b0;
    end else begin
        if (enb) begin
            if (validIn == 1'b1 && dataIn == 1'b0) begin
                addrBPSK <= 1'b0;
                addrBPSKValidOut <= 1'b1;
            end else if (validIn == 1'b1 && dataIn == 1'b1) begin
                addrBPSK <= 1'b1;
                addrBPSKValidOut <= 1'b1;
            end else begin
                addrBPSKValidOut <= 1'b0;
            end
        end
    end
end

endmodule