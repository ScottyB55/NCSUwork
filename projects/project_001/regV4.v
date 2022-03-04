module regV4 (
	input [3:0] data_in,
	input [2:0] capture,
	input rst_n, clock,
	// internal flip flop causes these to be regs
	output valid_out,
	output [3:0] data_out
);
	wire [3:0] data_d;
	wire valid_d;
	wire cap_and;
	
	// Calculate capture signal (from op and capture)
	assign cap_and = capture[2] & capture[1] & capture[0];
	
	// Route and save data
	mux21_4bit Umux4 (
	.sel(cap_and), .in_0(data_out), .in_1(data_in), .f(data_d));

	dff_4bit Udff4 (
	.rst_n(rst_n), .clock(clock), .D(data_d), .Q(data_out));
	
	// Route and save valid
	mux21 Umux1 (
	.sel(cap_and), .in_0(valid_out), .in_1(1'b1), .f(valid_d));

	dff Udff1 (
	.rst_n(rst_n), .clock(clock), .d(valid_d), .q(valid_out));
endmodule
