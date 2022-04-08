module size_count(
	input rst_n,
	input clock,
	input [31:0] size,
	input size_valid,
	input data_start,
	output reg last
);

reg flag;
reg[31:0] counter, capt;

always @ ( posedge clock ) begin
	if ( !rst_n ) begin
		last <= 1'b0;
		counter <= 6'b0;
	end
	
	else begin
		if (size_valid) begin
			capt[31:0] <= size[31:0];
		end
		
		if (data_start) begin
			flag <= 1'b1;
		end

		if (flag) begin		
			if (counter[31:0] < capt[31:0]) begin
				counter[31:0] = counter[31:0] + 1;
			end
		end

		if (counter[31:0] == capt[31:0]) begin
			last <= 1'b1;
			flag <= 1'b0;
		end
	end
end

endmodule
