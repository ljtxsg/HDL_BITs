module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    parameter s0=0, s1=1, s2=2, s3=3, b0=4, b1=5, b2=6, b3=7, count_repeat=8, count_wait=9;
    reg [3:0] state, next_state;
    reg [12:0] i;
    reg delay_stop;
    reg [3:0] delay;
    reg [9:0] cnt_1k;
    always @ (posedge clk)
        begin
            if(reset)
                state <= s0;
            else
                state <= next_state;
        end
    always @ (*) begin
        case (state)
            s0: next_state = data? s1: s0;
            s1: next_state = data? s2: s0;
            s2: next_state = data? s2: s3;
            s3: next_state = data? b0: s0;
            b0: next_state = b1;
            b1: next_state = b2;
            b2: next_state = b3;
            b3: next_state = count_repeat;
            count_repeat: next_state = delay_stop? count_wait: count_repeat;
            count_wait: next_state = ack? s0: count_wait;
            default: next_state = s0;
        endcase
    end
    
    assign count[3:0] = state == count_repeat? delay[3:0] : count[3:0];
    assign counting = state == count_repeat;
    assign done = state == count_wait;
    assign delay_stop = count == 0 && cnt_1k == 999;
   
    
    always @ (posedge clk) begin
        if(reset)
            delay[3:0] <= 4'b0000;
        else if (state == b0|state==b1|state==b2|state==b3)
            delay[3:0] <= {delay[2:0],data};
        else if (cnt_1k == 999)
            delay <= delay-1;
    end
    
    
    always @ (posedge clk) begin
        if(reset)begin
            cnt_1k <= 0;
        end
        else if (state == count_repeat)begin
            if (cnt_1k == 999)
                cnt_1k <= 0;
            else
                cnt_1k <= cnt_1k+1;            
        end
        else 
            cnt_1k <=0;
    end

endmodule
