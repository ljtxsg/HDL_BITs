module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    // output shift_ena
    parameter s0=0, s1=1, s2=2, s3=3, b0=4, b1=5, b2=6, b3=7 ,count=8, waiting=9;
    reg [4:0] state, next_state;
    always @ (posedge clk) begin
        if(reset)
            state <= s0;
        else
            state <= next_state;
    end
    always @ (*) begin
        case(state)
            s0:   next_state = data? s1: s0;
            s1:   next_state = data? s2: s0;
            s2:   next_state = data? s2: s3;
            s3:   next_state = data? b0: s0;
            b0:   next_state = b1;
            b1:   next_state = b2;
            b2:   next_state = b3;
            b3:   next_state = count;
            count:next_state = done_counting? waiting: count;
            waiting:next_state = ack? s0: waiting;
            default: next_state = s0;
        endcase
    end
    assign shift_ena = state == b0|state==b1|state==b2|state==b3;
    assign counting = state==count;
    assign done = state==waiting;

endmodule
