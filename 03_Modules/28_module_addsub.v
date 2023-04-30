module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire cout1;
    add16 add1(
        .a(a[15:0]),
        .b(b[15:0]^{16{sub}}),
        .cin(sub),
        .sum(sum[15:0]),
        .cout(cout1)
    );
    add16 add2(
        .a(a[31:16]),
        .b(b[31:16]^{16{sub}}),
        .cin(cout1),
        .sum(sum[31:16]),
        .cout()
    );
endmodule
