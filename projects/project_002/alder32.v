module alder32 (
input clock,
input rst_n,
input size_valid,
input[31:0] size,
input data_start,
input[7:0] data,
output checksum_valid,
output[31:0] checksum
);

reg[31:0] size_countdown;
reg data_started;
reg[15:0] A, B;

// Checksum Output
assign checksum[31:16] = B;
assign checksum[15:0] = A;

always @ (posedge clock) begin
	if (data_start) begin
		data_started = 1;
	end

	// Handle reset
	if (!rst_n) begin
		A = 1;
		B = 0;
		data_started = 0;
		size_countdown = 0;
	end
	else begin
		if (data_started) begin
			A = A + data;	// Blocking assignment
			B = B + A;
		
			if (A >= 65521) begin
				A = A - 65521;
			end
			if (B >= 65521) begin
				B = B - 65521;
			end
		end

		// Handle the size input
		if (size_valid) begin
			size_countdown = size;
		end
		else if (data_started) begin
			size_countdown = size_countdown - 1;
		end

		// Handle the checksum_valid output
		if (size_countdown == 0) begin
			checksum_valid = 1;
		end
		else begin
			checksum_valid = 0;
		end
	end
end
endmodule
