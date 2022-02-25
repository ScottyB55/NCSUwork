module fa3bit_tb;
	reg [2:0] A, B;
	wire [3:0]  F;

	fa3bit DUT (
		.A(A), .B(B), .F(F)
	);

	initial begin
		$monitor( $time, ": %1d + %1d = %2d",
				A, B, F);
	end
	
	integer i;

	initial begin
		for (i=0; i<64; i=i+1) begin
			{ A, B } = i;
			#10;
		end
	end
endmodule
