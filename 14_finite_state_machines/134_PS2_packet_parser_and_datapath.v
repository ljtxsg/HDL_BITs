module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    reg [15:0] out_temp;
    reg [1:0] state, next_state;
    parameter s0=0, s1=1, s2=2, s3=3;

    // FSM from fsm_ps2
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
    

    // New: Datapath to store incoming bytes.

    always @ (posedge clk) begin
        if (reset) begin
            out_temp<=0;
            out_bytes<=0;
        end
        else begin
            out_temp[15:8] = (next_state == s1)? in[7:0] : out_temp[15:8];
            out_temp[7:0] = (next_state == s2)? in[7:0] : out_temp[7:0];
            out_bytes = (next_state == s3)? {out_temp[15:0], in}: out_bytes;
        end
    end
            
endmodule
