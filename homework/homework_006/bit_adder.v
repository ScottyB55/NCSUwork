module bit_adder(
	input a, b, cin,
	output sum, cout
);
	assign cout = (cin & a) | (cin & b) | (a & b);
	assign sum = cin ^ a ^ b;
endmodule
