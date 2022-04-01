module lab6_seq_1101 (
  input rst_n, clock,
  input d_in,
  output reg found
);

  localparam S0 = 0;
  localparam S1 = 1;
  localparam S2 = 2;
  localparam S3 = 3;
  localparam S4 = 4;

  reg [2:0] cstate, nstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= S0;
    else
      cstate <= nstate;

  always @* begin
    found = 0;
    case ( cstate )
      S0 : nstate = d_in ? S1 : S0;
      S1 : nstate = d_in ? S2 : S0;
      S2 : nstate = d_in ? S2 : S3;
      S3 : nstate = d_in ? S4 : S0;
      S4 : begin
        nstate = d_in ? S2 : S0;
        found  = 1;
      end
      default : nstate = S0;
    endcase
  end

endmodule
