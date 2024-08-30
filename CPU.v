module CPU (
    input wire clk,
    input wire reset
);
    // Internal signals
    reg [15:0] pc; // Program Counter
    wire [18:0] instruction;
    wire [15:0] read_data1, read_data2, alu_result;
    reg [15:0] write_data;
    reg write_enable;
    wire [15:0] mem_read_data;

    // Instantiate components
    RegisterFile reg_file (
        .clk(clk),
        .reset(reset),
        .read_reg1(instruction[8:5]),
        .read_reg2(instruction[4:1]),
        .write_reg(instruction[12:9]),
        .write_data(alu_result),
        .write_enable(write_enable),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    ALU alu (
        .operand1(read_data1),
        .operand2(read_data2),
        .opcode(instruction[18:13]),
        .result(alu_result)
    );

    Memory instruction_memory (
        .address(pc),
        .write_data(16'h0000), // Not used in instruction memory
        .write_enable(1'b0),
        .read_data(instruction)
    );

    Memory data_memory (
        .address(alu_result),
        .write_data(read_data2),
        .write_enable(write_enable),
        .read_data(mem_read_data)
    );

    // Instruction Fetch
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 16'h0000;
        end else begin
            pc <= pc + 1; // Simple program counter increment
        end
    end

    // Instruction Decode and Execution
    always @(posedge clk) begin
        if (!reset) begin
            case (instruction[18:13])
                6'b000000, 6'b000001, 6'b000010, 6'b000011, // Arithmetic
                6'b000100, 6'b000101, 6'b000110, 6'b000111: begin
                    write_enable <= 1'b1;
                end
                6'b001000: begin // LD
                    write_data <= mem_read_data;
                    write_enable <= 1'b1;
                end
                6'b001001: begin // ST
                    write_enable <= 1'b1;
                end
                default: begin
                    write_enable <= 1'b0;
                end
            endcase
        end
    end
endmodule
