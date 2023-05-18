module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    // Use FSM from Fsm_serial
    reg [3:0] state,next_state;
    reg [7:0] temp;
    parameter IDLE=10,s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7,s8=8,s9=9, non_stop = 11;
    always @ (posedge clk)begin
        if (reset)
            state <= IDLE;
        else 
            state<=next_state;
    end
    
    always @ (*) begin
        case (state)
            IDLE: next_state = ~in? s0: IDLE;
            s0: next_state = s1;
            s1: next_state = s2;
            s2: next_state = s3;
            s3: next_state = s4;
            s4: next_state = s5;
            s5: next_state = s6;
            s6: next_state = s7;
            s7: next_state = s8;
            s8: next_state = in? s9: non_stop;
            s9: next_state = ~in? s0: IDLE;
            non_stop: next_state = in? IDLE: non_stop;
            default: next_state = IDLE;
        endcase
    end
    assign done = state == s9;

    always @ (posedge clk)begin
        if (reset) begin
            temp<=0;
            out_byte<=0;
        end
        else if(next_state==s1)
            temp[0]<=in;
        else if(next_state==s2)
            temp[1]<=in;
        else if(next_state==s3)
            temp[2]<=in;
        else if(next_state==s4)
            temp[3]<=in;
        else if(next_state==s5)
            temp[4]<=in;
        else if(next_state==s6)
            temp[5]<=in;
        else if(next_state==s7)
            temp[6]<=in;
        else if(next_state==s8)
            temp[7]<=in;
        else if(next_state==s9)
            out_byte<=temp;
    end
    // New: Datapath to latch input bits.

endmodule
