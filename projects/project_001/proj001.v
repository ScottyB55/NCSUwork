module proj001 (
	input rst_n, clock,
	input [3:0] d_in,
	input [1:0] op,
	input capture,
	output [4:0] result,
	output valid
);
	wire [3:0] dA, dB, dC, dD;
	wire	   vA, vB, vC, vD;
	wire rst_n_int;

	wire valid_delay;

	regV4 UA (
	.data_in(d_in), .capture({~op[1], ~op[0], capture}), .rst_n(rst_n_int), .clock(clock), .valid_out(vA), .data_out(dA));
	regV4 UB (
	.data_in(d_in), .capture({~op[1], op[0], capture}), .rst_n(rst_n_int), .clock(clock), .valid_out(vB), .data_out(dB));
	regV4 UC (
	.data_in(d_in), .capture({op[1], ~op[0], capture}), .rst_n(rst_n_int), .clock(clock), .valid_out(vC), .data_out(dC));
	regV4 UD (
	.data_in(d_in), .capture({op[1], op[0], capture}), .rst_n(rst_n_int), .clock(clock), .valid_out(vD), .data_out(dD));

	hw6_q1b Ucalc (
	.A(dA), .B(dB), .C(dC), .D(dD), .F(result));

	assign valid = vA & vB & vC & vD;

	dff Uvdelay (
	.rst_n(rst_n_int), .clock(clock), .d(valid), .q(valid_delay));

	assign rst_n_int = ~valid_delay & rst_n;

endmodule
