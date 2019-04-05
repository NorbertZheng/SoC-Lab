module flopr(clk, sig, d, q,rst);
    parameter width=32;
    input clk;
    input sig;
    input [width-1:0] d;
    output reg [width-1:0] q;
    input rst;
    initial
    begin
        q <= 0;
    end

    always @(negedge clk or posedge rst)
    begin
        if (rst)
        begin
            q <= 0;
        end
        else if (sig==1)
            q <= d;
    end
endmodule
