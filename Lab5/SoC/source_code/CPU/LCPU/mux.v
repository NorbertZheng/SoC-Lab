module mux1(
s, y,
d0, d1, d2, d3,
d4, d5, d6, d7,
d8, d9, d10, d11,
d12, d13, d14, d15
);
    parameter num=2,width=32,sigwid=1;
    input [width-1:0]d0;
    input [width-1:0]d1;
    input [width-1:0]d2;
    input [width-1:0]d3;
    input [width-1:0]d4;
    input [width-1:0]d5;
    input [width-1:0]d6;
    input [width-1:0]d7;
    input [width-1:0]d8;
    input [width-1:0]d9;
    input [width-1:0]d10;
    input [width-1:0]d11;
    input [width-1:0]d12;
    input [width-1:0]d13;
    input [width-1:0]d14;
    input [width-1:0]d15;
    input [sigwid-1:0]s;
    output reg [width-1:0]y;
    always@(s or d0 or d1 or d2 or d3 or d3 or d4 or d5 or d6 or d7 or d8 or d9 or d10 or d11 or d12 or d13 or d14 or d15)
      case(s)
        0:y=d0;
        1:y=d1;
        2:y=d2;
        3:y=d3;
        4:y=d4;
        5:y=d5;
        6:y=d6;
        7:y=d7;
        8:y=d8;
        9:y=d9;
        10:y=d10;
        11:y=d11;
        12:y=d12;
        13:y=d13;
        14:y=d14;
        15:y=d15;
        default:y=0;
      endcase
endmodule

module mux2(
s, y,
d0, d1, d2, d3,
d4, d5, d6, d7,
d8, d9, d10, d11,
d12, d13, d14, d15
);
    parameter num=2,width=32,sigwid=2;
    input [width-1:0]d0;
    input [width-1:0]d1;
    input [width-1:0]d2;
    input [width-1:0]d3;
    input [width-1:0]d4;
    input [width-1:0]d5;
    input [width-1:0]d6;
    input [width-1:0]d7;
    input [width-1:0]d8;
    input [width-1:0]d9;
    input [width-1:0]d10;
    input [width-1:0]d11;
    input [width-1:0]d12;
    input [width-1:0]d13;
    input [width-1:0]d14;
    input [width-1:0]d15;
    input [sigwid-1:0]s;
    output reg [width-1:0]y;
    always@(s or d0 or d1 or d2 or d3 or d3 or d4 or d5 or d6 or d7 or d8 or d9 or d10 or d11 or d12 or d13 or d14 or d15)
      case(s)
        0:y=d0;
        1:y=d1;
        2:y=d2;
        3:y=d3;
        4:y=d4;
        5:y=d5;
        6:y=d6;
        7:y=d7;
        8:y=d8;
        9:y=d9;
        10:y=d10;
        11:y=d11;
        12:y=d12;
        13:y=d13;
        14:y=d14;
        15:y=d15;
        default:y=0;
      endcase
endmodule
