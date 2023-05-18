module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] in_temp;
    always @ (posedge clk) begin
        in_temp <= ~in;
        pedge <= in_temp & in;
    end
         
endmodule
