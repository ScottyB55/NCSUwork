module fa_tb;
  reg a, b, c;
  wire cout, sum;

  fa DUT ( a, b, c, cout, sum);

  initial begin
    $monitor( $time, " %b + %b + %b = %b%b", a, b, c, cout, sum );

        {a, b, c} = 3'b000;
    #10 {a, b, c} = 3'b001;
    #10 {a, b, c} = 3'b010;
    #10 {a, b, c} = 3'b011;
    #10 {a, b, c} = 3'b100;
    #10 {a, b, c} = 3'b101;
    #10 {a, b, c} = 3'b110;
    #10 {a, b, c} = 3'b111;

    #10 $stop;
  end

endmodule

module fa_4bit_tb;
  reg [3:0] A, B;
  wire [4:0] F;

  fa_4bit DUT ( .A(A), .B(B), .Cin(1'b0), .F(F) );

  initial begin
    $monitor( $time, " %4b (%2d) + %4b (%2d) = %5b (%2d)", A, A, B, B, F, F );

        {A, B} = 8'b0000_0000;
    #10 {A, B} = 8'b0100_0110;
    #10 {A, B} = 8'b1100_0111;
    #10 {A, B} = 8'b1111_1111;
    #10 {A, B} = 8'b0011_0001;

    #10 $stop;
  end

endmodule

module sub_5bit_tb;
  reg [4:0] A, B;
  wire [4:0] F;

  sub_5bit DUT ( .A(A), .B(B), .F(F) );

  initial begin
    $monitor( $time, " %5b (%3d) - %5b (%3d) = %5b (%3d)", A, A, B, B, F, F );

        {A, B} = 10'b11110_01010;
    #10 {A, B} = 10'b00110_00100;
    #10 {A, B} = 10'b01100_00111;
    #10 {A, B} = 10'b01111_01111;
    #10 {A, B} = 10'b00011_00001;

    #10 $stop;
  end

endmodule

module hw6_q1c;
  reg [3:0] A, B, C, D;
  wire [4:0] F;

  hw6_q1b DUT ( .A(A), .B(B), .C(C), .D(D), .F(F) );

  initial begin
    $monitor( $time, " (%2d + %2d) - (%2d + %2d) = %2d", A, B, C, D, F );

        A =  8; B =  7; C =  3; D =  6;  // should be  6
    #10 A = 15; B = 15; C = 15; D = 15;  // should be  0
    #10 A =  1; B =  1; C =  0; D =  1;  // should be  1
    #10 A = 15; B = 10; C =  8; D =  3;  // should be 14

    #10 $stop;
  end

endmodule
