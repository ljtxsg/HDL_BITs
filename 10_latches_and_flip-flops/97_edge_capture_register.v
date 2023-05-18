module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_temp;
    always @ (posedge clk)
        begin
             in_temp <= ~ in;
        end
    always @ (posedge clk)
        begin
            if(reset) begin
                out <= 0;
            end
            else begin
                out <= ~ (in_temp | in) | out;
            end
        end
            
endmodule
