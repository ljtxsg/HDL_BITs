// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations

    reg present_state, next_state;
    parameter A = 1'b0, B = 1'b1;

    always @(posedge clk) begin
        if (reset) begin  
            next_state <= B;
            // Fill in reset logic
        end else begin
            case (present_state)
                A: next_state <= in ? A : B;
                B: next_state <= in ? B : A;
                // Fill in state transition logic
            endcase
        end
    end
    always @ (*)
        begin
            // State flip-flops
            present_state = next_state;  
        end
    always @ (*) begin
        case (next_state)
                A: out = 1'b0;
                B: out = 1'b1;
                // Fill in output logic
            endcase
    end


endmodule
