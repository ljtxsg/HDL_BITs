module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    reg [9:0] count;
    always @ (posedge clk)
        begin
            if(reset)
                count <=0;
            else
                count <= count+1;
        end
    always @ (posedge clk)
        begin
            if(reset)
                shift_ena = 1;
            else if (count > 2)
                shift_ena = 0;
            else
                shift_ena = 1;
        end

endmodule
