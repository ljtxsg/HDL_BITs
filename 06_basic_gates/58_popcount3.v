module top_module( 
    input [2:0] in,
    output  reg [1:0] out );

    always @ (*) begin
        out = 2'b0;
        for(int i=0; i<3; i++)
            begin
                out = out + in[i];
            end
    end
endmodule
