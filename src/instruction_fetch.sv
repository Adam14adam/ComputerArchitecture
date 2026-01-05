module instruction_fetch (
    input logic clk,
    
    input logic [15:0] in,
    input logic load,

    output logic [15:0] out
);

    always_ff @(posedge clk) begin
        if (load)
            out <= in;
    end

endmodule
