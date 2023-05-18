module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    parameter s0=0, s1=1, s2=2, s3=3, IDLE=4;
    reg [2:0] state, next_state;
    always @ (posedge clk) begin
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    always @ (*) begin
        case(state)
            IDLE: next_state = data? s0:IDLE;
            s0:   next_state = data? s1:IDLE;
            s1:   next_state = data? s1: s2;
            s2:   next_state = data? s3: IDLE;
            s3:   next_state = s3;
            default: next_state = IDLE;
        endcase
    end
    assign start_shifting = state ==s3;
        

endmodule
