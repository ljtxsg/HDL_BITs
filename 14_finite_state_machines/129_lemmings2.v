module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter lna = 0, rna = 1, la=2, ra=3;
    reg [1:0] state, next_state;
    reg [2:0] m;
    
    always @ (posedge clk or posedge areset) begin
        if (areset)
            state <= lna;
        else
            state <= next_state;
    end
    
    always @ (*) begin
        m = {bump_left, bump_right, ground};
        case (state)
            lna: next_state = (m == 3'b001 || m==3'b011)? lna :
                (m == 3'b111 || m == 3'b101) ? rna:la;
            rna: next_state = (m == 3'b001 || m == 3'b101) ? rna:
                (m == 3'b011 || m == 3'b 111)? lna: ra;
            la: next_state = (ground)? lna: la;
            ra: next_state = (ground) ? rna: ra;
            default : next_state = lna;
        endcase
    end
    
    assign walk_left = (state == lna);
    assign walk_right = (state == rna);
    assign aaah = (state == la || state == ra);

endmodule
