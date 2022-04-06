module hw7 (
	input rst_n, clock, ser_in,
	input [3:0] pattern,
	input p_load, overlap, o_load,
	output found
);

wire [3:0] patternI;
wire [3:0] wPQ;
wire [3:0] wPD;
wire [3:0] patternQ;

// define logic for pattern section
assign patternI[3] = ~pattern[3];
assign patternI[2] = ~pattern[2];
assign patternI[1] = pattern[1];
assign patternI[0] = pattern[0];

mux21_4bit UPM (.sel(p_load), .in_0(wPQ), .in_1(pattern), .f(wPD));
dff_4bit UPD ( .rst_n(rst_n), .clock(clock), .D(wPD), .Q(wPQ));

assign patternQ[3] = ~wPQ[3];
assign patternQ[2] = ~wPQ[2];
assign patternQ[1] = wPQ[1];
assign patternQ[0] = ~wPQ[0];


wire woQ, woD, woQ, overlapQ;

// define logic for overlap section
mux21 UOM (.sel(o_load), .in_0(woQ), .in_1(~overlap), .f(woD));
dff UOD ( .rst_n(rst_n), .clock(clock), .d(woD), .q(woQ), .q_n(overlapQ));


reg [1:0] rCQ;
wire wReady;

// define logic for overlap counter
always @ ( posedge clock ) begin
	if ( !rst_n || found ) begin
		rCQ <= 2'b00;
	end
	else if ( rCQ != 2'b11 ) begin
		rCQ <= rCQ + 1;
	end
	else begin
		rCQ <= rCQ;
	end
end

assign wReady = rCQ[0] & rCQ[1];


reg[3:0] rData;
wire wEqual, wValid;

// define logic for shift register
always @ ( posedge clock ) begin
	if ( !rst_n ) begin
		rData <= 4'b0000;
	end
	else begin
		rData <= rData>>1;
		rData[3] <= ser_in;
	end
end

// define logic for found logic
assign wEqual = (rData == patternQ);
assign wValid = overlapQ | wReady;
assign found = wEqual & wValid;

endmodule
