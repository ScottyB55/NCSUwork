module xs3_2digit_add (
  input [7:0] A, B,
  output [11:0] F
);

  xs3_digit_add lsb (
    .Cin(1'b0),
    .A(A[3:0]),
    .B(B[3:0]),
    .Cout(carry),
    .F(F[3:0])
  );

  xs3_digit_add msb (
    .Cin(carry),
    .A(A[7:4]),
    .B(B[7:4]),
    .Cout(cout),
    .F(F[7:4])
  );

  plus3 inc3 (
    .A({3'b000,cout}),
    .F(F[11:8])
  );

endmodule

module xs3_2digit_add_tb;

  reg [7:0] a, b;
  wire [11:0] f;
  integer i, j, k, l;

  xs3_2digit_add DUT (
    .A(a),
    .B(b),
    .F(f)
  );

  initial begin
    $monitor( $time, ": %04b_%04b (%04b_%04b / %1d%1d) + %04b_%04b (%04b_%04b / %1d%1d) = %04b_%04b_%04b (%04b_%04b_%04b / %1d%1d%1d)",
      a[7:4], a[3:0], a[7:4]-3, a[3:0]-3, a[7:4]-3, a[3:0]-3,
      b[7:4], b[3:0], b[7:4]-3, b[3:0]-3, b[7:4]-3, b[3:0]-3,
      f[11:8], f[7:4], f[3:0], f[11:8]-3, f[7:4]-3, f[3:0]-3, f[11:8]-3, f[7:4]-3, f[3:0]-3 );
    a = 8'b0011_0011; // 00
    b = 8'b0011_0011; // 00
    for(i=3;i<=12;i=i+1) begin
      for(j=3;j<=12;j=j+1) begin
        for(k=3;k<=12;k=k+1) begin
          for(l=3;l<=12;l=l+1) begin
            #10 a[7:4] = i;
                a[3:0] = k;
                b[7:4] = j;
                b[3:0] = l;
          end
        end
      end
    end
    #10 $stop;
  end

endmodule

module xs3_digit_add (
  input Cin,
  input [3:0] A, B,
  output Cout,
  output [3:0] F
);

  wire [3:0] sum;
  wire [3:0] sum_p3;
  wire [3:0] sum_m3;

  assign F = Cout ? sum_p3 : sum_m3;

  fa_4bit add (
    .Cin(Cin),
    .A(A),
    .B(B),
    .Cout(Cout),
    .Sum(sum)
  );

  plus3 inc3 (
    .A(sum),
    .F(sum_p3)
  );

  minus3 dec3 (
    .A(sum),
    .F(sum_m3)
  );

endmodule

module fa_1bit (
  input Cin, A, B,
  output Cout, Sum
);

  assign Sum = Cin ^ A ^ B;
  assign Cout = (Cin & A) | (A & B) | (Cin & B);

endmodule

module fa_4bit (
  input Cin,
  input [3:0] A, B,
  output Cout,
  output [3:0] Sum
);

  wire [3:1] carry;

  fa_1bit bit0 ( .A(A[0]), .B(B[0]), .Cin(Cin),      .Cout(carry[1]), .Sum(Sum[0]) );
  fa_1bit bit1 ( .A(A[1]), .B(B[1]), .Cin(carry[1]), .Cout(carry[2]), .Sum(Sum[1]) );
  fa_1bit bit2 ( .A(A[2]), .B(B[2]), .Cin(carry[2]), .Cout(carry[3]), .Sum(Sum[2]) );
  fa_1bit bit3 ( .A(A[3]), .B(B[3]), .Cin(carry[3]), .Cout(Cout),     .Sum(Sum[3]) );

endmodule

module fa_4bit_tb;

  reg cin;
  reg [3:0] a, b;
  wire [4:0] s;
  integer i;

  fa_4bit DUT (
    .Cin(cin),
    .A(a),
    .B(b),
    .Cout(s[4]),
    .Sum(s[3:0])
  );

  initial begin
    $monitor( $time, ": %01b (%1d) + %04b (%2d) + %04b (%2d) = %05b (%2d)",
      cin, cin, a, a, b, b, s, s );
    {cin, a, b} = 0;
    for(i=0; i<2**9; i=i+1) begin
      #10 {cin, a, b} = i;
    end
    #10 $stop;
  end

endmodule

module plus3 (
  input [3:0] A,
  output [3:0] F
);

  assign F[3] = (A[3] & ~A[2]) | (A[3] & ~A[1] & ~A[0]) | (~A[3] & A[2] & (A[1] | A[0]));
  assign F[2] = (A[2] & ~A[1] & ~A[0]) | (~A[2] & (A[1] | A[0]));
  assign F[1] = ~(A[1] ^ A[0]);
  assign F[0] = ~A[0];

endmodule

module minus3 (
  input [3:0] A,
  output [3:0] F
);

  assign F[3] = (A[3] & A[2]) | (A[3] & A[1] & A[0]) | (~A[3] & ~A[2] & (~A[1] | ~A[0]));
  assign F[2] = (A[2] & A[1] & A[0]) | (~A[2] & (~A[1] | ~A[0]));
  assign F[1] = A[1] ^ A[0];
  assign F[0] = ~A[0];

endmodule

module plus3_tb;

  wire [3:0] f;
  reg [3:0] a;
  integer i;

  plus3 DUT (
    .A(a),
    .F(f)
  );

  initial begin
    $monitor( $time, ": %04b (%2d) + 3 = %04b (%2d)", a, a, f, f );
    a = 0;
    for(i=1; i<16; i=i+1) begin
      #10 a = i;
    end
    #10 $stop;
  end

endmodule

module minus3_tb;

  wire [3:0] f;
  reg [3:0] a;
  integer i;

  minus3 DUT (
    .A(a),
    .F(f)
  );

  initial begin
    $monitor( $time, ": %04b (%2d) + 3 = %04b (%2d)", a, a, f, f );
    a = 0;
    for(i=1; i<16; i=i+1) begin
      #10 a = i;
    end
    #10 $stop;
  end

endmodule
