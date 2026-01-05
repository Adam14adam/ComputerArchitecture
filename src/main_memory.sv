module main_memory(
    input logic clk,

    input logic [7:0] mem_addr,
    input logic rd,
    input logic wr,

    input logic [15:0] w_data,

    output logic [15:0] r_data
);
    logic [15:0] mem_reg [255:0];

    // Write - sequential
    always_ff @(posedge clk) begin
        if (wr)
            mem_reg[mem_addr] <= w_data;
    end

    // Read - combinational
    always_comb begin
        r_data = rd ? mem_reg[mem_addr] : 16'b0;
    end

endmodule


