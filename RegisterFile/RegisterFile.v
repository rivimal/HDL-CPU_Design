module RegisterFile (
    input wire clk,                 // Clock signal
    input wire [2:0] read_reg1,     // Address of the first register to read
    input wire [2:0] read_reg2,     // Address of the second register to read
    input wire [2:0] write_reg,     // Address of the register to write to
    input wire [15:0] write_data,   // Data to write to the register
    input wire reg_write,           // Write enable signal
    output wire [15:0] read_data1,  // Data output from the first register
    output wire [15:0] read_data2   // Data output from the second register
);

    // Register array (8 registers of 16 bits each)
    reg [15:0] registers [7:0];

    // Reading from registers (asynchronous)
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    // Writing to a register (synchronous)
    always @(posedge clk) begin
        if (reg_write) begin
            registers[write_reg] <= write_data;
        end
    end
endmodule
