module rf (
    input wire clk,

	input wire [15:0] w_data,
    input wire [3:0] w_addr,
    input wire w_en,

    input wire [15:0] pc_data,
    input wire [3:0] pc_addr,
    input wire pc_en,

    input wire [3:0] out1_addr,
    input wire out1_en,

    input wire [3:0] out2_addr,
    input wire out2_en,

    output wire [15:0] out1,
    output wire [15:0] out2
);

    // 16 x 16-bit register file
    reg [15:0] mem [0:15];

    // -------------------------
    // Write logic (clocked)
    // PC has priority
    // -------------------------
    always @(posedge clk) begin
        if (pc_en) begin
            mem[pc_addr] <= pc_data;
        end
        else if (w_en) begin
            mem[w_addr] <= w_data;
        end
    end

    // -------------------------
    // Read logic (combinational)
    // -------------------------
    assign out1 = out1_en ? mem[out1_addr] : 16'b0;
    assign out2 = out2_en ? mem[out2_addr] : 16'b0;

endmodule

