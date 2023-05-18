module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    parameter A=0, B=1, C=2, D=3;
    reg [3:0] state, next_state;
    // State transition logic
    always @ (*) begin
        next_state[A] = (state[A] & ~in) | (state[C] & ~in);
        next_state[B] = (state[A] & in) | (state[B] & in) | (state[D] & in);
        next_state[C] = (state[B] & ~in) | (state[D] & ~in);
        next_state[D] = state[C] & in;
    end
    
    always @ (posedge clk or posedge areset) begin
        if (areset)
            state <= 4'b0001;
        else
            state <= next_state;
    end
    
    assign out = state[D];
        


    // State flip-flops with asynchronous reset

    // Output logic

endmodule
