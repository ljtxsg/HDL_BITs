module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter s0=0, s1=1, s2=2, s3=3;
    reg [1:0] state, next_state;
    always @ (posedge clk or posedge areset)
        begin
            if(areset)
                state <= s0;
            else
                state <= next_state;
        end
    always @ (*) begin
        case(state)
            s0: next_state = x? s2: s1;
            s1: next_state = x? s2: s1;
            s2: next_state = x? s3: s2;
            s3: next_state = x? s3: s2;
            default: next_state = s0;
        endcase
    end
    
    assign z = (state == s1|state==s3)? 0:(state==s2)?1:0;

endmodule
