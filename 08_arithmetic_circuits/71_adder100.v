module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    assign {cout,sum[99:0]} = a + b + cin;
    
endmodule
