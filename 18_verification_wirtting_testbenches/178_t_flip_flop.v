module top_module ();
    reg clk, reset, t, q;
    initial begin
        clk = 0;
    end
    always #5 clk =~clk;
    initial begin
        reset = 1;
        t = 1;
        #20 reset = 0;
    end
    tff tff_1(clk, reset, t, q);
    

endmodule
