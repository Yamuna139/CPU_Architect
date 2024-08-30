module ALU (
    input [15:0] operand1,
    input [15:0] operand2,
    input [5:0] opcode,
    output reg [15:0] result
);

    always @(*) begin
        case (opcode)
            6'b000000: result = operand1 + operand2; // ADD
            6'b000001: result = operand1 - operand2; // SUB
            6'b000010: result = operand1 * operand2; // MUL
            6'b000011: result = operand1 / operand2; // DIV
            6'b000100: result = operand1 & operand2; // AND
            6'b000101: result = operand1 | operand2; // OR
            6'b000110: result = operand1 ^ operand2; // XOR
            6'b000111: result = ~operand1;            // NOT
            default: result = 16'h0000;               // Default case
        endcase
    end
endmodule
