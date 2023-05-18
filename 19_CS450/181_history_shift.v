module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    reg [31:0] predict_temp;
    always @ (posedge clk or posedge areset)
        begin
            if (areset)
                predict_temp <= 32'b0;
            else if (train_mispredicted)
                predict_temp <= {train_history[30:0], train_taken};
            else if (predict_valid)
                predict_temp <= {predict_temp[30:0], predict_taken};
            else
                predict_temp <= predict_temp;
        end
    
    assign predict_history = predict_temp;
            

endmodule
