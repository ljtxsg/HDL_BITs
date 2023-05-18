module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    reg [7:0] memory;
    always @ (posedge clk) begin
        if (enable)
            memory <= {memory[6:0],S};
        else
            memory <= memory;
    end
    always @ (*) begin
        case ({A,B,C})
            3'b000: Z = memory[0];
            3'b001: Z = memory[1];
            3'b010: Z = memory[2];
            3'b011: Z = memory[3];
            3'b100: Z = memory[4];
            3'b101: Z = memory[5];
            3'b110: Z = memory[6];
            3'b111: Z = memory[7];
        endcase
    end
endmodule
