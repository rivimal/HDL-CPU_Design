`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module Test_ALU;
    // Inputs
    reg [15:0] A;
    reg [15:0] B;
    reg [2:0] ALUOp;

    // Outputs
    wire [15:0] Result;
    wire Zero;  

    // Instantiate the ALU
    ALU uut (
        .A(A),
        .B(B),
        .ALUOp(ALUOp),
        .Result(Result),
        .Zero(Zero)
    );
    
    // Test sequence
    initial begin
		$dumpfile("ALU.vcd");
        $dumpvars;
		
        // Test 1: ADD (A + B)
        A = 16'h000A; B = 16'h0005; ALUOp = 3'b000; // Expected Result = 0x000F
        #10; // Wait for 10 time units

        // Test 2: SUBTRACT (A - B)
        A = 16'h000A; B = 16'h0005; ALUOp = 3'b001; // Expected Result = 0x0005
        #10;

        // Test 3: AND (A & B)
        A = 16'h00FF; B = 16'h0F0F; ALUOp = 3'b010; // Expected Result = 0x0F0F
        #10;

        // Test 4: OR (A | B)
        A = 16'h00FF; B = 16'h0F0F; ALUOp = 3'b011; // Expected Result = 0x0FFF
        #10;

        // Test 5: NOT (~A)
        A = 16'h00FF; ALUOp = 3'b100; // Expected Result = 0xFF00
        #10;

        // Additional tests can be added here...

        $stop; // End simulation
    end
    
endmodule
