module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
    wire [8:0] sflow;
    assign s = a + b;
    assign sflow = a + b;
    assign overflow = (a[7]==b[7])? (sflow[8] ^ sflow[7]):0;
    // assign s = ...
    // assign overflow = ...
//符号位相反，则不会溢出，若符号位相同，则看进位位和符号位的和是否相反，如果相反，则溢出
endmodule
