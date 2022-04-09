module hw7 (
  input rst_n,
  input clock,
  input ser_in,
  input p_load,
  input [3:0] pattern,
  input o_load,
  input overlap,
  output found
);

  reg olap;
  wire olap_n;

  reg [3:0] shreg;
  reg [3:0] p_val;
  wire [3:0] p_swiz;
  wire r_val_n;

  always @( posedge clock )
    if( !rst_n )
      olap <= 1;
    else
      if( o_load )
        olap <= overlap;
      else
        olap <= olap;

  assign olap_n = ~olap;

  always @( posedge clock )
    if( !rst_n )
      p_val <= 4'b1101;
    else
      if( p_load )
        p_val <= pattern;
      else
        p_val <= p_val;

  assign r_val_n = ~p_val[0];
  assign p_swiz = {p_val[0], p_val[1], p_val[2], p_val[3]};

  always @( posedge clock )
    if( !rst_n )
      shreg <= 4'b0000;
    else
      if( olap_n && found )
        shreg <= {ser_in, {3{r_val_n}}};
      else
        shreg <= {ser_in, shreg[3:1]};

  assign found = (shreg == p_swiz);

endmodule
