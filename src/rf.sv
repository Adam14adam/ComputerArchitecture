module rf (
    input logic clk,

    input logic [15:0] w_data,
    input logic [3:0] w_addr,
    input logic w_en,

    input logic [15:0] pc_data,
    input logic [3:0] pc_addr,
    input logic pc_en,

    input logic [3:0] out1_addr,
    input logic out1_en,

    input logic [3:0] out2_addr,
    input logic out2_en,

    output logic [15:0] out1,
    output logic [15:0] out2
);

    // 16 x 16-bit register file
    logic [15:0] rf_reg [0:15];

    // -------------------------
    // Write logic (clocked)
    // PC has priority
    // -------------------------
    always_ff @(posedge clk) begin
        if (pc_en) begin
            rf_reg[pc_addr] <= pc_data;
        end
        else if (w_en) begin
            rf_reg[w_addr] <= w_data;
        end
    end

    // -------------------------
    // Read logic (combinational)
    // -------------------------
    always_comb begin
        assign out1 = out1_en ? mem[out1_addr] : 16'b0;
        assign out2 = out2_en ? mem[out2_addr] : 16'b0;
    end

endmodule

