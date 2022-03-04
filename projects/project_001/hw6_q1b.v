module hw6_q1b (
	input [3:0] A,
	input [3:0] B,
	input [3:0] C,
	input [3:0] D,
	output [4:0] F
);
	
	wire [4:0] ApB, CpD;
	wire [3:0] ApBcout, CpDcout;

	bit_adder ApB0(.a(A[0]), .b(B[0]), .cin(1'b0), .sum(ApB[0]), .cout(ApBcout[0]));
	bit_adder ApB1(.a(A[1]), .b(B[1]), .cin(ApBcout[0]), .sum(ApB[1]), .cout(ApBcout[1]));
	bit_adder ApB2(.a(A[2]), .b(B[2]), .cin(ApBcout[1]), .sum(ApB[2]), .cout(ApBcout[2]));
	bit_adder ApB3(.a(A[3]), .b(B[3]), .cin(ApBcout[2]), .sum(ApB[3]), .cout(ApBcout[3]));
	assign ApB[4] = ApBcout[3];

	bit_adder CpD0(.a(C[0]), .b(D[0]), .cin(1'b0), .sum(CpD[0]), .cout(CpDcout[0]));
	bit_adder CpD1(.a(C[1]), .b(D[1]), .cin(CpDcout[0]), .sum(CpD[1]), .cout(CpDcout[1]));
	bit_adder CpD2(.a(C[2]), .b(D[2]), .cin(CpDcout[1]), .sum(CpD[2]), .cout(CpDcout[2]));
	bit_adder CpD3(.a(C[3]), .b(D[3]), .cin(CpDcout[2]), .sum(CpD[3]), .cout(CpDcout[3]));
	assign CpD[4] = CpDcout[3];


	wire [4:0] Fcout;
	
	bit_adder F0(.a(ApB[0]), .b(~CpD[0]), .cin(1'b1), .sum(F[0]), .cout(Fcout[0]));
	bit_adder F1(.a(ApB[1]), .b(~CpD[1]), .cin(Fcout[0]), .sum(F[1]), .cout(Fcout[1]));
	bit_adder F2(.a(ApB[2]), .b(~CpD[2]), .cin(Fcout[1]), .sum(F[2]), .cout(Fcout[2]));
	bit_adder F3(.a(ApB[3]), .b(~CpD[3]), .cin(Fcout[2]), .sum(F[3]), .cout(Fcout[3]));
	bit_adder F4(.a(ApB[4]), .b(~CpD[4]), .cin(Fcout[3]), .sum(F[4]), .cout(Fcout[4]));
endmodule
