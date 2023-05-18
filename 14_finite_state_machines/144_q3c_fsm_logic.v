module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    parameter y0=3'b000,y1=3'b001,y2=3'b010,y3=3'b011,y4=3'b100;
    reg [2:0] state, next_state;
    always @ (posedge clk)
        state<=y;
    always @ (*) begin
     case(state)
            y0: next_state = x? y1: y0;
            y1: next_state = x? y4: y1;
            y2: next_state = x? y1: y2;
            y3: next_state = x? y2: y1;
            y4: next_state = x? y4: y3;
         default: next_state = y0;
     endcase
    end
    assign z =  (y==y3||y==y4);
    assign Y0 = (y==y0&x|y==y1&~x|y==y2&x|y==y3&~x|y==y4&~x);

endmodule