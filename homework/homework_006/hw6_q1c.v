module hw6_q1c;
	reg [3:0] A, B, C, D;
	wire [4:0] F;

	hw6_q1b DUT(
	.A(A), .B(B), .C(C), .D(D), .F(F)
	);

	initial begin
		$monitor( $time, ": (%2d + %2d) - (%2d + %2d) = %2d",
					A, B, C, D, F);
	end

	initial begin
		A = 15; B = 15; C = 0; D = 0; #10;
		A = 9; B = 10; C = 2; D = 1; #10;
		A = 8; B = 10; C = 11; D = 0; #10;
		A = 5; B = 4; C = 3; D = 2; #10;
	end
endmodule
