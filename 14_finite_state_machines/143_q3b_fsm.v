module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    parameter y0=0,y1=1,y2=2,y3=3,y4=4;
    reg [2:0] state, next_state;
    always @ (posedge clk) begin
        if(reset)
            state<=y0;
        else
            state<=next_state;
    end
    always @ (*) begin
        case(state)
            y0: next_state = x? y1: y0;
            y1: next_state = x? y4: y1;
            y2: next_state = x? y1: y2;
            y3: next_state = x? y2: y1;
            y4: next_state = x? y4: y3;
        endcase
    end
    assign z = (state==y3||state==y4);

endmodule
