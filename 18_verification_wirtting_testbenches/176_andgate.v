module top_module();
    reg [1:0] in;
    reg OUT;
    initial begin
        in[0]=0;
        in[1]=0;
        #10 in[0]=1;
        #10 in[0]=0; in[1]=1;
        #10 in[0]=1;
    end
    andgate gate1(in, OUT);
        

endmodule
