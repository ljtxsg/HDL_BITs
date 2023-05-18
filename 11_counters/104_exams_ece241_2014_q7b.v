module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

    reg [3:0] c1, c2, c3;
    assign c_enable[0] = !reset;
    assign c_enable[1] = (c1 == 4'd9)? 1:0;
    assign c_enable[2] = (c1 == 4'd9 && c2 == 4'd9)? 1:0;
    assign OneHertz = (c1 == 4'd9 && c2 == 4'd9 && c3 == 4'd9)? 1:0;
    bcdcount counter0 (clk, reset, c_enable[0], c1);
    bcdcount counter1 (clk, reset, c_enable[1], c2);
    bcdcount counter2 (clk, reset, c_enable[2], c3);

endmodule
