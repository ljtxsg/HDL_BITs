module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0] mina_b, minc_d;
    assign mina_b = (a<b)? a: b;
    assign minc_d = (c<d)? c: d;
    assign min = (mina_b < minc_d)? mina_b: minc_d;
    // assign intermediate_result1 = compare? true: false;

endmodule
