module controller (
    input logic clk,
    input logic reset,
    
    // Instruction input
    input logic [15:0] instruction,
    
    // Control outputs
    output logic [2:0] alu_sel,
    output logic rf_w_en,
    output logic rf_out1_en,
    output logic rf_out2_en,
    output logic pc_up,
    output logic if_load
);

    // Instruction decode
    logic [3:0] opcode;
    logic [3:0] rd, rs1, rs2;
    
    assign opcode = instruction[15:12];
    assign rd = instruction[11:8];
    assign rs1 = instruction[7:4];
    assign rs2 = instruction[3:0];
    
    // State machine
    typedef enum logic [1:0] {
        FETCH = 2'b00,
        EXECUTE = 2'b01
    } state_t;
    
    state_t current_state, next_state;
    
    // State register
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= FETCH;
        else
            current_state <= next_state;
    end
    
    // Next state logic
    always_comb begin
        case (current_state)
            FETCH: next_state = EXECUTE;
            EXECUTE: next_state = FETCH;
            default: next_state = FETCH;
        endcase
    end
    
    // Control signal generation
    always_comb begin
        // Default values
        alu_sel = 3'b000;
        rf_w_en = 1'b0;
        rf_out1_en = 1'b0;
        rf_out2_en = 1'b0;
        pc_up = 1'b0;
        if_load = 1'b0;
        
        case (current_state)
            FETCH: begin
                if_load = 1'b1;
                pc_up = 1'b1;
            end
            
            EXECUTE: begin
                if (opcode == 4'b0000) begin // ADD instruction
                    alu_sel = 3'b000;      // ADD operation
                    rf_out1_en = 1'b1;     // Enable rs1 read
                    rf_out2_en = 1'b1;     // Enable rs2 read
                    rf_w_en = 1'b1;        // Enable rd write
                end
            end
        endcase
    end

endmodule
