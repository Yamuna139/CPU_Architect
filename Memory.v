module Memory (
    input wire [15:0] address,
    input wire [15:0] write_data,
    input wire write_enable,
    output reg [15:0] read_data
);

    reg [15:0] mem [255:0]; // Memory with 256 addresses, each 16 bits

    always @(posedge write_enable) begin
        mem[address] <= write_data;
    end

    always @(*) begin
        read_data = mem[address];
    end
endmodule
