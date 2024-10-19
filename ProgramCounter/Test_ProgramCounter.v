module Test_ProgramCounter();

    reg clk;
    reg reset;
    reg [15:0] pc_in;
    reg pc_write_enable;
    wire [15:0] pc_out;

    // Instantiate the Program Counter
    ProgramCounter uut (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_write_enable(pc_write_enable),
        .pc_out(pc_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
    $dumpfile("ProgramCounter.vcd");  // For waveform output
    $dumpvars;

    // Initialize signals
    reset = 1;                // Start with reset active
    pc_write_enable = 0;       // Disable PC write initially
    pc_in = 16'b0;             // Set pc_in to zero

    #10;
    reset = 0;                // Release reset, PC should start incrementing

    #30;                      // Let PC increment for 30 units of time

    pc_in = 16'h1234;         // Set a specific value for the PC
    pc_write_enable = 1;      // Enable writing to the PC
    #10;
    pc_write_enable = 0;      // Disable writing

    #30;                      // Let PC increment again
	end

endmodule
