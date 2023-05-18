module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    reg [1:0] state, next_state;
    parameter s0=0, s1=1, s2=2, s3=3;

    // State transition logic (combinational)
    always @ (*) begin
        case (state)
            s0: next_state=in[3]?s1:s0;
            s1: next_state=s2;
            s2: next_state=s3;
            s3: next_state=in[3]?s1:s0;
            default:next_state=s0;
        endcase
    end
    // State flip-flops (sequential)

    always @ (posedge clk) begin
        if (reset)
            state <= s0;
        else
            state <= next_state;
    end
    // Output logic

    assign done = state==s3;
endmodule
