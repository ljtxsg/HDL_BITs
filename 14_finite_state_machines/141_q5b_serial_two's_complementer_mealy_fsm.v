module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A=0, B=1;
    reg [1:0] state, next_state;
    always @ (posedge clk or posedge areset)
        begin
            if (areset)begin
                state[A] <= 1'b1;
                state[B] <= 1'b0;
            end
            else
                state <= next_state;
        end
    always @ (*) begin
        next_state[A] = state[A] & ~x;
        next_state[B] = (state[A] & x) | (state[B]);
    end
    
    assign z = (state[A]&x)|(state[B]&~x);

endmodule
