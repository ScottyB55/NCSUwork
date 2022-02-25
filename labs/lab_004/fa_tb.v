module fa_tb;
	reg A, B, Cin;
	wire Sum, Cout;

	fa DUT (
		.A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout)
	);

	initial begin
		$display( $time, ": A B Cin | Sum Cout" );
		$monitor( $time, ": %b %b %b   | %b   %b",
				A, B, Cin, Sum, Cout);
	end

	initial begin
		{ A, B, Cin } = 3'b000;
	#10	{ A, B, Cin } = 3'b001;
	#10	{ A, B, Cin } = 3'b010;
	#10	{ A, B, Cin } = 3'b011;
	#10	{ A, B, Cin } = 3'b100;
	#10	{ A, B, Cin } = 3'b101;
	#10	{ A, B, Cin } = 3'b110;
	#10	{ A, B, Cin } = 3'b111;
	end
endmodule
