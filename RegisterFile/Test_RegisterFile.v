module Test_RegisterFile();

    reg clk;
    reg [2:0] read_reg1, read_reg2, write_reg;
    reg [15:0] write_data;
    reg reg_write;
    wire [15:0] read_data1, read_data2;

    // Instantiate the Register File
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

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        reg_write = 0;
        write_reg = 3'b000;
        write_data = 16'h0000;
        read_reg1 = 3'b000;
        read_reg2 = 3'b000;

        // Write to register 0
        #10;
        write_reg = 3'b000;
        write_data = 16'h1234;
        reg_write = 1;
        #10;
        reg_write = 0;

        // Write to register 1
        #10;
        write_reg = 3'b001;
        write_data = 16'h5678;
        reg_write = 1;
        #10;
        reg_write = 0;

        // Read from registers 0 and 1
        #10;
        read_reg1 = 3'b000;
        read_reg2 = 3'b001;
        #10;

        // Observe the read_data1 and read_data2 signals in the waveform
    end
endmodule
