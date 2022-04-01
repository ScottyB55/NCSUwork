module lab6_seq_101 (
  input rst_n, clock,
  input d_in,
  output found
);

  wire clear;
  reg [2:0] s_reg;

  always @( posedge clock )
    if( !rst_n )
      s_reg <= 0;
    else
      if( clear )
        s_reg <= {d_in, 2'b00};
      else
        s_reg <= {d_in, s_reg[2:1]};

  assign found = ( s_reg == 3'b101 );
  assign clear = found;

endmodule
