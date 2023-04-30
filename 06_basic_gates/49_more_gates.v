module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);
     and logic1(out_and, a, b);
      or logic2(out_or, a, b);
     xor logic3(out_xor, a,b);
    nand logic4(out_nand, a,b);
    nor logic5(out_nor, a, b);
    xnor logic6(out_xnor, a, b);
    and logic7(out_anotb, a, ~b);
    

endmodule
