module Test_ControlUnit;

    // Inputs
    reg [3:0] opcode;

    // Outputs
    wire regWrite;
    wire memRead;
    wire memWrite;
    wire [1:0] aluOp;
    wire jump;

    // Instantiate the Control Unit
    ControlUnit uut (
        .opcode(opcode),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .aluOp(aluOp),
        .jump(jump)
    );

    initial begin
        $dumpfile("ControlUnit.vcd");  // For waveform output
        $dumpvars;

        // Test ADD instruction (0000)
        opcode = 4'b0000;
        #10;

        // Test SUB instruction (0001)
        opcode = 4'b0001;
        #10;

        // Test LOAD instruction (0010)
        opcode = 4'b0010;
        #10;

        // Test STORE instruction (0011)
        opcode = 4'b0011;
        #10;

        // Test JUMP instruction (0100)
        opcode = 4'b0100;
        #10;

        $stop;  // End simulation
    end

endmodule