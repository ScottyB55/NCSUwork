// an iteresting thing here is that we are testing two
// different controllers but the datapath is the same in
// both cases; we only need to build it once
module datapath (
  input rst_n, clock,
  input clr, inc,
  output tc
);

  // I've chosen not to make the count value an output so
  // it gets declared here; it's type reg because it's on
  // the LHS in a procedural block
  //
  // since the procedural block, in this case, is a clocked
  // procedural block it does become flop flops
  reg [3:0] count;

  // simple priority chain of muxes that allow for clearing
  // and incrementing; if neither are asserted then the
  // value will stay the same
  always @( posedge clock )
    if( !rst_n )
      count <= 0;
    else
      if( clr )
        count <= 0;
      else
        if( inc )
          count <= count + 1;
        else
          count <= count;

  // rather than place the tc output inside the procedural
  // block I make the comparison here; recall that the ==
  // performs a logical comparison and produces a logical
  // result; the logical result is a single bit quantity
  // that has a numeric equivalent of 0/1 that is assigned
  // to tc
  assign tc = (count == 10);

endmodule
