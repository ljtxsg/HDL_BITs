module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    reg [3:0] Q_temp;
    assign c_enable = enable;
    assign c_d = c_load? 1: 0;
    count4 the_counter (clk, c_enable, c_load, c_d, Q_temp);
    always @ (posedge clk)
        begin
            if (reset) begin
                Q <= 1;
                Q_temp <= 1;
            end
            else begin
                if (enable) begin
                    if(Q != 4'd12) begin
                        Q <= Q+1;
                        Q_temp <= Q_temp+1;
                    end
                    else begin
                    	Q<=1;
                    	Q_temp<=1;
                    end
                end
            end
        end
    
    always @(*)begin
        if(reset) begin
            c_load = 1;
        end
        else if (Q == 4'd12 && c_enable)
            c_load = 1;
        else
            c_load = 0;
    end

endmodule
