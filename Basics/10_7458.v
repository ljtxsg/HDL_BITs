module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    wire wire1, wire2, wire3, wire4;
    assign wire1 = p2a & p2b;
    assign wire2 = p2c & p2d;
    assign wire3 = p1a & p1c & p1b;
    assign wire4 = p1f & p1e & p1d;
    assign p1y = wire3 | wire4;
    assign p2y = wire2 | wire1;
endmodule
