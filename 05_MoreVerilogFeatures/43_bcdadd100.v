module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire [99:0] cout_temp;
    bcd_fadd add0(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(cout_temp[0]),
        .sum(sum[3:0])
    );
    
    genvar i;
    generate 
        for(i=1; i<100; i++)
            begin: loop
                bcd_fadd add400(
                    .a(a['d4*i+3: 'd4*i]),
                    .b(b['d4*i+3: 'd4*i]),
                    .cin(cout_temp[i-1]),
                    .cout(cout_temp[i]),
                    .sum(sum['d4*i+3:'d4*i])
                );
             end
     endgenerate
     assign cout = cout_temp[99];
endmodule
