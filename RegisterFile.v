module RegisterFile (
    input wire clk,
    input wire reset,
    input wire [3:0] read_reg1,
    input wire [3:0] read_reg2,
    input wire [3:0] write_reg,
    input wire [15:0] write_data,
    input wire write_enable,
    output reg [15:0] read_data1,
    output reg [15:0] read_data2
);

    reg [15:0] registers [15:0];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            integer i;
            for (i = 0; i < 16; i = i + 1)
                registers[i] <= 16'h0000;
        end else if (write_enable) begin
            registers[write_reg] <= write_data;
        end
    end

    always @(*) begin
        read_data1 = registers[read_reg1];
        read_data2 = registers[read_reg2];
    end
endmodule
