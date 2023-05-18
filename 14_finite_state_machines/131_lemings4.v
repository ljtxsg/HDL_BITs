module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
	parameter lna = 0, rna = 1, la = 2, ra = 3, ldig = 4,  rdig = 5, oops = 6, splat=7;
    reg [3:0] state, next_state;
    integer i;
    always @ (posedge clk or posedge areset)
        begin
            if (areset) begin
                state <= lna;
            end
            else
                state <= next_state;
        end
    always @ (*) begin
        case (state)
            lna: next_state = ~ground ? la : 
                dig ? ldig : 
                bump_left ? rna : lna;
            rna: next_state = ~ground ? ra :
                dig ? rdig :
                bump_right ? lna : rna;
            la: next_state = (~ground)? la: (i>5'd19) ? splat:lna;
            ra: next_state = (~ground)? ra :(i>5'd19) ? splat:rna;
            ldig: next_state = ground ? ldig : la;
            rdig: next_state = ground ? rdig : ra;
            splat: next_state = splat;
            default: next_state = splat;
        endcase
    end
    always @ (posedge clk or posedge areset)
        begin
            if (areset) begin
                i <= 0;
            end
            else if (aaah)
               i <= i+1;
            else 
               i <= 0;
        end
    
    assign walk_left = (state == lna);
    assign walk_right = (state == rna);
    assign aaah = (state == la) || (state == ra) ;
    assign digging = (state == ldig) || (state == rdig);
endmodule

