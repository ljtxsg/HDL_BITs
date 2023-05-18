module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter A=0, f_start=1, f1=2, f2=3, g_start=5, g_forever1=6, g1=7, g_forever0=8, f0=9;
    reg [3:0] state, next_state;
    always @ (posedge clk)
        begin
            if(!resetn)
                state<=A;
            else
                state<=next_state;
        end
    always @ (*) begin
        case(state)
            A: next_state = f_start;
            f_start: next_state = f0;
            f0: next_state =x? f1: f0;
            f1: next_state = ~x? f2: f1;
            f2: next_state = x? g_start: f0;
            g_start: next_state = y? g_forever1: g1;
            g1: next_state=y?g_forever1:g_forever0;
            g_forever1: next_state = g_forever1;
            g_forever0: next_state = g_forever0;
            default: next_state = A;
        endcase
    end
    assign f= state==f_start;
    assign g= state==g_start||state==g_forever1||state==g1;

endmodule
