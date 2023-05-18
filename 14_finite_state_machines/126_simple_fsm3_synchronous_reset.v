module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    // State transition logic
    parameter A=0, B=1, C=2, D=3;
    reg [3:0] state, next_state;
    // State transition logic
    always @ (*) begin
        next_state[A] = (state[A] & ~in) | (state[C] & ~in);
        next_state[B] = (state[A] & in) | (state[B] & in) | (state[D] & in);
        next_state[C] = (state[B] & ~in) | (state[D] & ~in);
        next_state[D] = state[C] & in;
    end
    // State flip-flops with synchronous reset
 	always @ (posedge clk) begin
        if (reset)
            state <= 4'b0001;
        else
            state <= next_state;
    end
    // Output logic
    assign out = state[D];
endmodule
