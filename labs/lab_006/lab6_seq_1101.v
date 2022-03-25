module lab6_seq_1101 (
	input rst_n, clock, d_in,
	output found
);
	wire [3:0] data;
dff U0 ( .rst_n(rst_n), .clock(clock), .d(d_in), .q(data[0]) );
dff U1 ( .rst_n(rst_n), .clock(clock), .d(data[0]), .q(data[1]) );
dff U2 ( .rst_n(rst_n), .clock(clock), .d(data[1]), .q(data[2]) );
dff U3 ( .rst_n(rst_n), .clock(clock), .d(data[2]), .q(data[3]) );

assign found = (data == 4'b1101);

endmodule
