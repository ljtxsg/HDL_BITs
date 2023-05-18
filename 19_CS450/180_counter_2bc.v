module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter s0=0, s1=1, s2=2, s3=3;
    reg [1:0] next_state;
    
    always @ (posedge clk or posedge areset)
        begin
            if(areset)
                state <= s1;
            else
                state <= next_state;
        end
    
    always @ (*) begin
        case(state)
            s0: next_state = (train_valid & train_taken) ? s1: s0;
            s1: next_state = (train_valid & train_taken) ? s2 : (train_valid)? s0: s1;
            s2: next_state = (train_valid & train_taken) ? s3 : (train_valid)? s1: s2;
            s3: next_state = (train_valid & ~train_taken)? s2: s3;
        endcase
    end
    
    

endmodule
