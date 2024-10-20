module ControlUnit (
    input [3:0] opcode,        // 4-bit opcode from the instruction
    output reg regWrite,       // Control signal to write to the register
    output reg memRead,        // Control signal to read from memory
    output reg memWrite,       // Control signal to write to memory
    output reg [1:0] aluOp,    // ALU operation control signal
    output reg jump            // Control signal for jump instruction
);

always @(*) begin
    // Default signals (for NOP)
    regWrite = 0;
    memRead = 0;
    memWrite = 0;
    aluOp = 2'b00;
    jump = 0;

    case (opcode)
        4'b0000: begin  // ADD instruction
            regWrite = 1;
            aluOp = 2'b10;  // Set ALU to perform addition
        end

        4'b0001: begin  // SUB instruction
            regWrite = 1;
            aluOp = 2'b11;  // Set ALU to perform subtraction
        end

        4'b0010: begin  // LOAD instruction
            memRead = 1;
            regWrite = 1;
        end

        4'b0011: begin  // STORE instruction
            memWrite = 1;
        end

        4'b0100: begin  // JUMP instruction
            jump = 1;
        end

        default: begin
            // NOP (No Operation) or invalid instruction
        end
    endcase
end

endmodule