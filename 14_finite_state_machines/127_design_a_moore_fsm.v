module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [1:0] state, next_state;
    parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
    always @ (posedge clk) begin
        if (reset)
            state <= s0;
        else
            state <= next_state;
    end
    
    always @ (*) begin
        case (state)
            s0: next_state = (s==3'b000)? s0:
                (s==3'b001)? s1:
                (s==3'b011)? s2: s3;
            s1: next_state = (s==3'b000)? s0:
                (s==3'b001)? s1:
                (s==3'b011)? s2: s3;
            s2: next_state = (s==3'b000)? s0:
                (s==3'b001)? s1:
                (s==3'b011)? s2: s3;
            s3: next_state = (s==3'b000)? s0:
                (s==3'b001)? s1:
                (s==3'b011)? s2: s3;
        endcase
    end
    
    always @ (posedge clk) begin
        if (reset)begin
            {fr1,fr2,fr3,dfr}<=4'b1111;
        end
        else begin
        {fr1, fr2, fr3} <= (s == 3'b000)? 3'b111:
        (s == 3'b001 && (state == s0 || state == s1))? 3'b110:
        (s == 3'b001 && (state == s2 || state == s3))? 3'b110:
        (s == 3'b011 && (state == s0 || state == s1 || state == s2))? 3'b100:
        (s == 3'b011 && (state == s3))? 3'b100:
        (s == 3'b111)? 3'b000 : 3'b000;
            dfr <= ((next_state == s0) || (state == s3 && s==3'b011)||(state == s2 && s==3'b001)|| (state == s1 && s == 3'b000))? 1:
            ((state == s3 && s == 3'b111 )|| (state == s2 && s==3'b011) || (state ==s1 && s == 3'b001))? dfr:0;
    	end
    end
endmodule
