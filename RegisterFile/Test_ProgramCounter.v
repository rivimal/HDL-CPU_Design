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
        // Initialize signals
        reset = 1;
        pc_write_enable = 0;
        pc_in = 16'b0;
        
        // Reset the PC
        #10;
        reset = 0;
        
        // Let PC increment for a few cycles
        #30;
        
        // Load a specific value into the PC
        #10;
        pc_in = 16'h1234;
        pc_write_enable = 1;
        #10;
        pc_write_enable = 0;
        
        // Let PC increment for a few more cycles
        #30;

        // Observe the pc_out signal in the waveform
    end
endmodule
