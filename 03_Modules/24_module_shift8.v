/**********************需要注意的点：*****************************/
/****模块例化的时候，对于模块外部的输入可以是reg/wire,模块内部的输入必须是wire****/
/****模块外部的输出必须是wire，模块内部的输出可以是reg/wire************************/
module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);

    wire [7:0] qw1, qw2, qw3;
    my_dff8 my1(
        .clk(clk),
        .d(d),
        .q(qw1)
    );
    my_dff8 my2(
        .clk(clk),
        .d(qw1),
        .q(qw2)
    );
    my_dff8 my3(
        .clk(clk),
        .d(qw2),
        .q(qw3)
    );
    always @ (*)
        case(sel)
            2'b00: q = d;
            2'b01: q = qw1;
            2'b10: q = qw2;
            2'b11: q = qw3;
        endcase
    
endmodule

