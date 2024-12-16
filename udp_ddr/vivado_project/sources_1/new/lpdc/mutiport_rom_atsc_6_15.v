module mutiport_rom_atsc_6_15 #(
    parameter ADDR_WIDTH = 7,
    parameter DATA_WIDTH = 96,
    parameter DEPTH = 108,
    parameter NUM_READ_PORTS = 2  // 可配置的读端口数量
)(
    input clk,
    input rst_n,

    // Read ports
    input [NUM_READ_PORTS-1:0] re,
    input [NUM_READ_PORTS*ADDR_WIDTH-1:0] rd_addr,
    output [NUM_READ_PORTS*DATA_WIDTH-1:0] rd_data
);

    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] bram [0:DEPTH-1];

    always @(negedge rst_n) begin
        if (!rst_n) begin
            bram[0] <= 96'h00100932130b4a8f7f610000;
            bram[1] <= 96'h0502092c0b114ce36d580000;
            bram[2] <= 96'h0212172518662e6246e00000;
            bram[3] <= 96'h04ad0f671540515884240000;
            bram[4] <= 96'h0126132316f05a456f240000;
            bram[5] <= 96'h051f0cd7144030bf64750000;
            bram[6] <= 96'h04850c640e941a2b56cd0000;
            bram[7] <= 96'h086e14381716447576e30000;
            bram[8] <= 96'h0a140f591815322552660000;
            bram[9] <= 96'h0cac14ac188c252d881c0000;
            bram[10] <= 96'h0410072c150e3ec586ed0000;
            bram[11] <= 96'h028d0a1c0f5c114c462a664c;
            bram[12] <= 96'h0611100914f73abd8ae20000;
            bram[13] <= 96'h02460c401083228754c60000;
            bram[14] <= 96'h055e0d0c0e6b1048414282f6;
            bram[15] <= 96'h053416c6191846708c170000;
            bram[16] <= 96'h02c104000b3c0eb85af668b0;
            bram[17] <= 96'h008512ef14703c1a8e920000;
            bram[18] <= 96'h06810a49188126f461460000;
            bram[19] <= 96'h020d091c170044bf753f0000;
            bram[20] <= 96'h0014021912d71d57566a0000;
            bram[21] <= 96'h0ca4128a18c920ea3c040000;
            bram[22] <= 96'h05390aad1445552c785d0000;
            bram[23] <= 96'h020f050b151d444d84a10000;
            bram[24] <= 96'h093f0b3a0d2812f3249e6310;
            bram[25] <= 96'h06a008b60efa5f386a7c0000;
            bram[26] <= 96'h04ff062e10b7270f8a070000;
            bram[27] <= 96'h02d10ea418b82c5d3e790000;
            bram[28] <= 96'h0724162a18d13c6b7e650000;
            bram[29] <= 96'h051c08c10ce7132c3a067cb5;
            bram[30] <= 96'h07080cb4103f169539244c13;
            bram[31] <= 96'h02ef0805170329026e030000;
            bram[32] <= 96'h027b131c14341c9e4a3b0000;
            bram[33] <= 96'h076010a3140d335d54ea0000;
            bram[34] <= 96'h04b908630a2a0c102d177036;
            bram[35] <= 96'h023e0a18188e1e584d480000;
            bram[36] <= 96'h047609040b2a3c7d58a10000;
            bram[37] <= 96'h030e107916af40097b0e0000;
            bram[38] <= 96'h0020044f089910905e7866d7;
            bram[39] <= 96'h033a16991889213e4e7f0000;
            bram[40] <= 96'h06870f5118c82a5e4b4f0000;
            bram[41] <= 96'h0011068d1691253681450000;
            bram[42] <= 96'h071008d80a130d41290656f7;
            bram[43] <= 96'h02a304da0b381069270e6d64;
            bram[44] <= 96'h08830cdc16144f3c86520000;
            bram[45] <= 96'h002c10c0120b146034ce5427;
            bram[46] <= 96'h045f0b0711261cb542ee0000;
            bram[47] <= 96'h0042126218293f5976020000;
            bram[48] <= 96'h00e909351766233f645e0000;
            bram[49] <= 96'h02100720122a14722e507d56;
            bram[50] <= 96'h08de109f180d1e67351d0000;
            bram[51] <= 96'h09670ed7192820b562170000;
            bram[52] <= 96'h007007620a5314933e39695e;
            bram[53] <= 96'h0947145518fa1b064ade0000;
            bram[54] <= 96'h014916d2191536088a910000;
            bram[55] <= 96'h012a0e80173f2a24390a0000;
            bram[56] <= 96'h054c133c148848d479620000;
            bram[57] <= 96'h0c1a121b183c584d70d00000;
            bram[58] <= 96'h00ed0a5512f7313b875d0000;
            bram[59] <= 96'h065d0a40162e42478e760000;
            bram[60] <= 96'h02fe0afe193456f67c4c0000;
            bram[61] <= 96'h06bb0d04134140f580420000;
            bram[62] <= 96'h00f50f09107812e01b0b52a0;
            bram[63] <= 96'h02370c63190e381d74ae0000;
            bram[64] <= 96'h00f40e7f111f12062d5350c8;
            bram[65] <= 96'h060612d41763433566c00000;
            bram[66] <= 96'h09560f37122052b7730f0000;
            bram[67] <= 96'h06810a030ef110de1f015d49;
            bram[68] <= 96'h00fe04ef062914fb36818522;
            bram[69] <= 96'h02d90a581539327f8e0c0000;
            bram[70] <= 96'h04ed0b1d141e2adb34660000;
            bram[71] <= 96'h007b0c870ed910ed3b63772e;
            bram[72] <= 96'h02b40e07194850f26b3e0000;
            bram[73] <= 96'h05291017125f144c2f3b626f;
            bram[74] <= 96'h000c0660134d446d71670000;
            bram[75] <= 96'h02330e8d1668428e833e0000;
            bram[76] <= 96'h05560d5d10a5371a646f0000;
            bram[77] <= 96'h021707311742595a88350000;
            bram[78] <= 96'h008b14b71951467474690000;
            bram[79] <= 96'h0412088d0c7410161f606163;
            bram[80] <= 96'h08901739194548ea6c2d0000;
            bram[81] <= 96'h001a06cf13311529327162eb;
            bram[82] <= 96'h06260e2119404f2f8c0e0000;
            bram[83] <= 96'h00e6023510ba2910790f0000;
            bram[84] <= 96'h00a1050e0cbe12263aaf5c97;
            bram[85] <= 96'h033e14371675314873450000;
            bram[86] <= 96'h0203164f18aa600b7e5b0000;
            bram[87] <= 96'h0a600ee610bf241c5a4d0000;
            bram[88] <= 96'h0759168a19641cdd48a90000;
            bram[89] <= 96'h09510b480cea10bc2f3e5e49;
            bram[90] <= 96'h05420d111053528d7a4e0000;
            bram[91] <= 96'h0f1d13341560582e682d0000;
            bram[92] <= 96'h03180ad90e852b435f630000;
            bram[93] <= 96'h06bd0d141348233b6e3e0000;
            bram[94] <= 96'h015a0b4c1690194f892d0000;
            bram[95] <= 96'h065610aa12a1212e65550000;
            bram[96] <= 96'h00f7090d16412652409e0000;
            bram[97] <= 96'h0a310cfd0f56116038d372a4;
            bram[98] <= 96'h043a093b148322bb4e670000;
            bram[99] <= 96'h08cf127a182e2d2e5c900000;
            bram[100] <= 96'h000e026d088a60b3808a0000;
            bram[101] <= 96'h013b0c5a0e874ce18ca40000;
            bram[102] <= 96'h04180c1d0e0b30436a010000;
            bram[103] <= 96'h066f08500a060c2e36375aab;
            bram[104] <= 96'h007e0f1f147f287b7b3c0000;
            bram[105] <= 96'h069c08970a9e0ecb34535078;
            bram[106] <= 96'h0329140f16641b0448290000;
            bram[107] <= 96'h0c6f10eb16085c18823e0000;
        end
    end

    reg [DATA_WIDTH-1:0] rd_data_reg [0:NUM_READ_PORTS-1];
    genvar i;
    generate
        for (i = 0; i < NUM_READ_PORTS; i = i + 1) begin: read_ports
            wire [ADDR_WIDTH-1:0] rd_addr_i;
            assign rd_addr_i = rd_addr[(i+1)*ADDR_WIDTH-1:i*ADDR_WIDTH];
            
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    rd_data_reg[i] <= {DATA_WIDTH{1'b0}};
                end else begin 
                    if (re[i]) begin
                        rd_data_reg[i] <= bram[rd_addr_i];
                    end
                end
            end
            assign rd_data[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH] = rd_data_reg[i];
        end
    endgenerate

endmodule
