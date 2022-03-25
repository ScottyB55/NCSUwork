module lab6_seq_101(
	input rst_n, clock, d_in,
	output found
);
	wire[2:0] data;
	wire rst_int;

assign rst_int = ~found & rst_n;

dff U0 ( .rst_n(rst_n), .clock(clock), .d(d_in), .q(data[0]) );
dff U1 ( .rst_n(rst_int), .clock(clock), .d(data[0]), .q(data[1]) );
dff U2 ( .rst_n(rst_int), .clock(clock), .d(data[1]), .q(data[2]) );

assign found = (data == 3'b101);

endmodule
