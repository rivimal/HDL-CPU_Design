module Test_RegisterFile();

    // Declare the necessary signals
    reg clk;
    reg [2:0] read_reg1, read_reg2, write_reg;
    reg [15:0] write_data;
    reg reg_write;
    wire [15:0] read_data1, read_data2;

    // Instantiate the RegisterFile
    RegisterFile uut (
        .clk(clk),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation (toggling every 5 time units)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        $dumpfile("RegisterFile.vcd"); // Dump simulation data
        $dumpvars(0, Test_RegisterFile);

        // Initialize signals
        reg_write = 0;
        write_reg = 3'b000;
        write_data = 16'h0000;
        read_reg1 = 3'b000;
        read_reg2 = 3'b000;

        // Test Case 1: Write 0x1234 to register 0
        #10;
        write_reg = 3'b000;     // Write to register 0
        write_data = 16'h1234;  // Data to write
        reg_write = 1;          // Enable write
        #10;
        reg_write = 0;          // Disable write after one clock cycle

        // Test Case 2: Write 0x5678 to register 1
        #10;
        write_reg = 3'b001;     // Write to register 1
        write_data = 16'h5678;  // Data to write
        reg_write = 1;          // Enable write
        #10;
        reg_write = 0;          // Disable write

        // Test Case 3: Read from register 0 and 1
        #10;
        read_reg1 = 3'b000;     // Read from register 0
        read_reg2 = 3'b001;     // Read from register 1
        #10;                    // Wait to see the output

        // Test Case 4: Attempt to write when reg_write is disabled
        #10;
        write_reg = 3'b010;     // Target register 2
        write_data = 16'h9999;  // Data to write
        reg_write = 0;          // Disable write
        #10;                    // Wait to see that register 2 is not modified

        // Test Case 5: Verify register 2 is still zero (it should be, since we didn't enable writing)
        read_reg1 = 3'b010;     // Read from register 2
        #10;

        $stop;  // Stop the simulation
    end
endmodule
