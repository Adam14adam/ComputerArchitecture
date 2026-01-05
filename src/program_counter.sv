module program_counter(
    input logic clk,

    input logic [7:0] d_bus,
    input logic d_bus_en,

    input logic [7:0] input2,
    input logic load2,

    input logic [7:0] input1,
    input logic load1,

    input logic clear,
    input logic up,

    output logic [7:0] pc_out
);

    always_ff @(posedge clk) begin
        // clear is enabled
        if (clear) begin
            pc_out <= 8'b0;
        end

        //dbus is enabled
        else if (d_bus_en) begin
            pc_out <= d_bus;
        end

        // controller input enables
        else if (load1) begin
            pc_out <= input1;
        end

        // Program counter adder enabled
        else if (load2) begin
            pc_out <= input2;
        end

        else if (up) begin
            pc_out <= pc_out + 1;
        end

        // Default behaviour
        else
            pc_out <= pc_out;
    end

endmodule
