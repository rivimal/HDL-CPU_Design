`timescale 1ns / 1ps

module Test_InstructionMemory;

    // Inputs
    reg [15:0] address;

    // Outputs
    wire [15:0] instruction;

    // Instantiate the Instruction Memory
    InstructionMemory uut (
        .address(address),
        .instruction(instruction)
    );

    // Test sequence
    initial begin
        $dumpfile("InstructionMemory.vcd");  // For waveform output
        $dumpvars;

        // Initialize address
        address = 16'b0000000000000000;  // Fetch instruction at address 0
        #10;

        address = 16'b0000000000000001;  // Fetch instruction at address 1
        #10;

        address = 16'b0000000000000010;  // Fetch instruction at address 2
        #10;

        address = 16'b0000000000000011;  // Fetch instruction at address 3
        #10;

        $stop;  // End simulation
    end

endmodule
