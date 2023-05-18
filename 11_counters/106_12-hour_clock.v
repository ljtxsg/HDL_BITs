module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    wire enam, enah;
    assign enam = (ss == 8'h59 && ena);
    assign enah = (ss == 8'h59 && mm == 8'h59 && ena);
    always @ (posedge clk) begin
        if (reset)
            ss <= 8'b0;
        else if (ena) begin
            if (ss[3:0] == 4'd9 && ss[7:4] == 4'd5)
                ss[7:0] <= 8'b0;
            else if (ss[3:0] == 4'd9 && ss[7:4] != 4'd5) begin
                ss[7:4] <= ss[7:4]+4'b1;
                ss[3:0] <= 4'b0;
            end
            else begin
                ss[7:4] <= ss[7:4];
                ss[3:0] <= ss[3:0]+4'b1;
            end
        end
    end
    
    always @ (posedge clk) begin
        if (reset)
            mm <= 8'b0;
        else if (enam) begin
            if (mm[3:0] == 4'd9 && mm[7:4] == 4'd5)
                mm <= 0;
            else if (mm[3:0] == 4'd9 && mm[7:4] != 4'd5) begin
                mm[7:4] <= mm[7:4]+1;
                mm[3:0] <= 0;
            end
            else begin
                mm[7:4] <= mm[7:4];
                mm[3:0] <= mm[3:0]+1;
            end
        end
    end
    
    always @ (posedge clk) begin
        if (reset)
            hh <= 8'b0001_0010;
        else if (enah) begin
            if (hh == 8'b0001_0010)
                hh <= 8'b0000_0001;
            else if (hh[3:0] == 4'd9 && hh[7:4] == 4'd0)
                hh <= 8'b0001_0000;
            else begin
                hh[3:0] <= hh[3:0]+1;
                hh[7:4] <= hh[7:4];
            end
        end
    end
    always @ (posedge clk)
        begin if (reset)
            pm <= 0;
            else if (hh == 8'h11 && mm == 8'h59 && ss == 8'h59)
                pm <= ~pm;
        end

endmodule
