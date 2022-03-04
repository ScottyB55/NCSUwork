module fa (
  input a, b, cin,
  output cout, sum
);

  wire gen;
  wire prop;

  assign prop = a ^ b;
  assign gen  = a & b;

  assign cout = ( cin & prop ) | gen;
  assign sum  = prop ^ cin;

endmodule

module fa_4bit (
  input [3:0] A, B,
  input Cin,
  output [4:0] F
);

  wire [3:1] carry;

  fa U0 ( .a(A[0]), .b(B[0]), .cin(Cin),      .cout(carry[1]), .sum(F[0]) );
  fa U1 ( .a(A[1]), .b(B[1]), .cin(carry[1]), .cout(carry[2]), .sum(F[1]) );
  fa U2 ( .a(A[2]), .b(B[2]), .cin(carry[2]), .cout(carry[3]), .sum(F[2]) );
  fa U3 ( .a(A[3]), .b(B[3]), .cin(carry[3]), .cout(F[4]),     .sum(F[3]) );

endmodule

module sub_5bit (
  input [4:0] A, B,
  output [4:0] F
);

  wire [4:1] carry;
  wire [4:0] Bn;
  assign Bn = ~B;

  fa U0 ( .a(A[0]), .b(Bn[0]), .cin(1'b1),     .cout(carry[1]), .sum(F[0]) );
  fa U1 ( .a(A[1]), .b(Bn[1]), .cin(carry[1]), .cout(carry[2]), .sum(F[1]) );
  fa U2 ( .a(A[2]), .b(Bn[2]), .cin(carry[2]), .cout(carry[3]), .sum(F[2]) );
  fa U3 ( .a(A[3]), .b(Bn[3]), .cin(carry[3]), .cout(carry[4]), .sum(F[3]) );
  fa U4 ( .a(A[4]), .b(Bn[4]), .cin(carry[4]),                  .sum(F[4]) );

endmodule

module hw6_q1b (
  input [3:0] A, B, C, D,
  output [4:0] F
);

  wire [4:0] AB, CD;

  fa_4bit ApB ( .A(A), .B(B), .Cin(1'b0), .F(AB) );
  fa_4bit CpB ( .A(C), .B(D), .Cin(1'b0), .F(CD) );
  sub_5bit ABsCD ( .A(AB), .B(CD), .F(F) );

endmodule
