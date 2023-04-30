module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire cout_sel;
    wire [15:0] sum_0, sum_1;
    add16 add1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .cout(cout_sel),
        .sum(sum[15:0])
    );
    add16 add2(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b0),
        .cout(),
        .sum(sum_0[15:0])
    );
    add16 add3(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1'b1),
        .cout(),
        .sum(sum_1[15:0])
    );
    assign sum[31:16] = (cout_sel) ? sum_1[15:0] : sum_0[15:0];
    
endmodule
