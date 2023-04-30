module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    full_add add0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .s(sum[0]),
        .co(cout[0])
    );
    
    genvar i;
    generate
        for(i=1; i<100; i++)
            begin: loop
                full_add add(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cout[i-1]),
                    .s(sum[i]),
                    .co(cout[i])
                );
            end
    endgenerate
endmodule

module full_add (
    input a,
    input b,
    input cin,
    output s,
    output co
);
    assign s = a ^ b ^ cin;
    assign co = (a & b) | ((a ^ b) & cin);
endmodule
