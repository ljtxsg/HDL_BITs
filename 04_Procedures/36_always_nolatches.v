// synthesis verilog_input_version verilog_2001
//为了避免创建锁存器，必须在所有可能的条件下为所有输出分配一个值(另见 always _ if2)。
//仅仅有一个默认情况是不够的。您必须为所有四种情况下的所有四个输出和默认情况下的所有四个输出分配一个值。
//这可能涉及大量不必要的输入。解决这个问题的一个简单方法是在 case 语句之前为输出分配一个“默认值”.
//这种类型的代码确保在所有可能的情况下，除非 case 语句重写了赋值，否则输出都会被赋值(0)。
//这也意味着一个 default: case 项变得不必要了。
module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up  ); 
    always @ (*) begin
         left = 1'b0;
         down = 1'b0;
        right = 1'b0;
           up = 1'b0;
        case(scancode)
            16'he06b:  left = 1'b1;
            16'he072:  down = 1'b1;
            16'he074: right = 1'b1;
            16'he075:    up = 1'b1;
        endcase
    end

endmodule
