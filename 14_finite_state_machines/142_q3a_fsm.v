module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=0, B=1;
    reg state, next_state;
    reg [1:0] count;
    reg[2:0] w_new;
    always @ (posedge clk)
        begin
            if(reset)
                state<=A;
            else
                state<=next_state;
        end
    always @ (*) begin
        case(state)
            A: next_state = s? B: A;
            B: next_state = B;
        endcase
    end
    always @ (posedge clk) begin
        if(reset) begin
            count <= 0;
        end
        else if (state == B) begin
            if(count==2)begin
                count <= 0;
            end
            else begin
                count<=count+1;
            end
        end
    end
      always @(posedge clk) begin
        if (reset) begin
            w_new <= 0;
        end
          else if (state == B) begin
            w_new <= {w_new[1:0], w};
        end
    end
    assign z = ((w_new==3'b011 || w_new==3'b101||w_new==3'b110 )& count==0)? 1:0;
            
    

endmodule
