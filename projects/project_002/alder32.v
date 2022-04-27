module alder32 (
input clock,
input rst_n,
input data_start,
input size_valid,
input[31:0] size,
input[7:0] data,
output[31:0] checksum,
output checksum_valid
);

	wire data_started;

	// Datapath
	UDatapath datapath(
	// inputs
	.clock(clock),
	.rst_n(rst_n),
	.data_started(data_started),
	.data(data),
	// output
	.checksum(checksum)
	);

	// Controller
	UController controller(
	// inputs
	.clock(clock),
	.rst_n(rst_n),
	.size_valid(size_valid),
	.data_start(data_start),
	.size(size),
	// outputs
	.data_started(data_started),
	.checksum_valid(checksum_valid)
	);

endmodule


module datapath (
input clock,
input rst_n,
input data_started,
input[7:0] data,
output[31:0] checksum
);

reg[15:0] A, B;

// Checksum Output
assign checksum[31:16] = B;
assign checksum[15:0] = A;

// Everything assigned within an always block must be a reg datatype
always @ (posedge clock) begin

	// The dominant, highest priority mux is for the reset
	if (!rst_n) begin
		A <= 1;
		B <= 0;
	end
	else begin
		// Keep in mind that all of these run at the same time using
		// the values initially present @ the posedge of the clock,
		// nonblocking	
		
		// Create a mux to handle A and B
		if (data_started) begin
			
			// Using nonblocking assignments
			if (A + data >= 65521)
				A <= A + data - 65521;
			else
				A <= A + data;

			if (B + A + data >= 65521)
				B <= B + A + data - 65521;
			else
				B <= B + A + data;
		end
		else begin
			A <= A;
			B <= B;
		end
	end

end
endmodule


// Controls muxes in the datapath by adjusting data_started
module controller (
input clock,
input rst_n,
input size_valid,
input data_start,
input[31:0] size,
output reg data_started,
output reg checksum_valid // keep in mind we could assign this to an and gate to advance it
);

reg[31:0] size_countdown;

// Everything assigned within an always block must be a reg datatype
always @ (posedge clock) begin
	
	// The dominant, highest priority mux is for the reset
	if (!rst_n) begin
		data_started = 0;
		size_countdown = 0;
		checksum_valid = 0;
	end
	else begin
		// Keep in mind that all of these run at the same time using
		// the values initially present @ the posedge of the clock,
		// nonblocking			
	
		// Create a mux to load and handle size_countdown
		if (size_valid)
			size_countdown <= size;
		else begin
			if (data_started)
				size_countdown <= size_countdown - 1;
			else
				size_countdown <= size_countdown;
		end

		// Create a mux to handle data_started
		if (data_start)
			data_started = 1;
		else begin
			if (checksum_valid)
				data_started = 0;
			else
				data_started = data_started;
		end
		
		// Create a mux to handle checksum_valid
		if (data_started && (size_countdown == 0))
			checksum_valid <= 1;
		else
			checksum_valid <= 0;

	end
end

endmodule
