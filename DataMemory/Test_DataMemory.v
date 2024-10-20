module Test_DataMemory;

    // Inputs
    reg [7:0] address;
    reg [15:0] writeData;
    reg memRead;
    reg memWrite;

    // Outputs
    wire [15:0] readData;

    // Instantiate the Data Memory
    DataMemory uut (
        .address(address),
        .writeData(writeData),
        .memRead(memRead),
        .memWrite(memWrite),
        .readData(readData)
    );

    initial begin
        $dumpfile("DataMemory.vcd");
        $dumpvars;

        // Test sequence
        memWrite = 1;           // Enable write
        address = 8'b00000000;  // Address to write to
        writeData = 16'b0000000000000001; // Data to write
        #10;

        address = 8'b00000001;  // Next address to write
        writeData = 16'b0000000000000010; // Data to write
        #10;

        memWrite = 0;           // Disable write

        memRead = 1;            // Enable read
        address = 8'b00000000;  // Read from address 0
        #10;

        memRead = 0;            // Disable read
        #10;

        memRead = 1;            // Read from address 1
        address = 8'b00000001;  // Read from address 1
        #10;

        $stop;                  // End simulation
    end

endmodule