module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    reg [3:0] q1, q10, q100, q1000;
    BCD counter1(clk, reset, 1'b1, q1);
    BCD counter2(clk, reset, ena[1], q10);
    BCD counter3(clk, reset, ena[2], q100);
    BCD counter4(clk, reset, ena[3], q1000);
    assign ena[1] = (q1 == 4'd9);
    assign ena[2] = (q1 == 4'd9 && q10 == 4'd9);
    assign ena[3] = (q1 == 4'd9 && q10 == 4'd9 && q100 == 4'd9);
    assign q = {q1000, q100, q10, q1};
endmodule

module BCD(
    input clk,
    input reset,
    input enable,
    output [3:0] Q
);
    always @ (posedge clk)
        begin
            if(reset)
                Q <= 0;
            else if (enable) begin
                if (Q != 4'd9)
                    Q <= Q+1'd1;
                else
                    Q <= 0;
            end
        end
endmodule
