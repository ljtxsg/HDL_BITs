module top_module( 
    input [99:0] in,
    output [99:0] out
);

    genvar i;
    generate
        for(i=0;i<7'd100;i=i+1)
            begin: loop
                assign out[i]=in[99-i];
            end
    endgenerate
endmodule

//也可以用always块，需要将out定义为reg，	
//always @(*) begin
//   for (int i=0;i<$bits(out);i++)        // $bits() is a system function that returns the width of a signal.
//       out[i] = in[$bits(out)-i-1];	// $bits(out) is 100 because out is 100 bits wide.
//    end