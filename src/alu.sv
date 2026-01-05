module ALU_16 (
    input logic [15:0] in1,
    input logic [15:0] in2,
    input logic [2:0] alu_sel,
    output logic [15:0] alu_out
);

    localparam ADD  = 3'b000,
               SUB  = 3'b001,
               AND_ = 3'b010,
               OR_  = 3'b011,
               XOR_ = 3'b100,
               FLIP = 3'b101,
               LSR  = 3'b110,
               LSL  = 3'b111;

    always_comb begin
        case (alu_sel)
            ADD: alu_out = in1 + in2;
            SUB: alu_out = in1 - in2;
            AND_: alu_out = in1 & in2;
            OR_: alu_out = in1 | in2;
            XOR_: alu_out = in1 ^ in2;
            FLIP: alu_out = in1 ^ (16'b1 << in2[3:0]); // flip one bit
            LSR: alu_out = in1 >> in2[3:0];
            LSL: alu_out = in1 << in2[3:0];
            default: alu_out = 16'h0000;
        endcase
    end

endmodule

