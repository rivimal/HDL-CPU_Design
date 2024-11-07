`timescale 1ns / 1ps
module CPU (
    input wire clk,       // Clock signal
    input wire reset      // Reset signal
);

    // Program Counter signals
    wire [15:0] pc_out;
    wire [15:0] pc_next;
    wire pc_write_enable = 1;

    // Instruction Memory signals
    wire [15:0] instruction;

    // Control Unit signals
    wire regWrite;
    wire memRead;
    wire memWrite;
    wire [1:0] aluOp;
    wire jump;

    // Register File signals
    wire [2:0] read_reg1 = instruction[11:9];
    wire [2:0] read_reg2 = instruction[8:6];
    wire [2:0] write_reg = instruction[5:3];
    wire [15:0] read_data1;
    wire [15:0] read_data2;
    wire [15:0] write_data;

    // ALU signals
    wire [15:0] alu_result;
    wire zero_flag;

    // Data Memory signals
    wire [15:0] data_memory_out;

    // Instantiate Program Counter
    ProgramCounter PC (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_next),
        .pc_write_enable(pc_write_enable),
        .pc_out(pc_out)
    );

    // Instantiate Instruction Memory
    InstructionMemory IM (
        .address(pc_out),
        .instruction(instruction)
    );

    // Instantiate Control Unit
    ControlUnit CU (
        .opcode(instruction[15:12]),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .aluOp(aluOp),
        .jump(jump)
    );

    // Instantiate Register File
    RegisterFile RF (
        .clk(clk),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .reg_write(regWrite),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Instantiate ALU
    ALU alu (
        .A(read_data1),
        .B(read_data2),
        .ALUOp(aluOp),
        .Result(alu_result),
        .Zero(zero_flag)
    );

    // Instantiate Data Memory
    DataMemory DM (
        .address(alu_result[7:0]), // Use lower 8 bits for memory address
        .writeData(read_data2),    // Write data comes from read_data2
        .memRead(memRead),
        .memWrite(memWrite),
        .readData(data_memory_out)
    );

    // Mux for write_data (Data from ALU or Data Memory)
    assign write_data = memRead ? data_memory_out : alu_result;

    // Program Counter update logic
    assign pc_next = jump ? alu_result : (pc_out + 1);

endmodule
