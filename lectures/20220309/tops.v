// these tops are purely structural; the each instantiate the
// same datapath but they instantiate unique controllers to be
// able to demonstrate the difference between the Mealy and
// Moore type outputs
module top_moore (
  input rst_n, clock,
  input start,
  output done
);

  datapath DP (
    .rst_n( rst_n ),
    .clock( clock ),
    .clr( clr ),
    .inc( inc ),
    .tc( tc )
  );

  ctrl_moore CTRL (
    .rst_n( rst_n ),
    .clock( clock ),
    .start( start ),
    .tc( tc ),
    .clr( clr ),
    .inc( inc ),
    .done( done )
  );

endmodule

module top_mealy (
  input rst_n, clock,
  input start,
  output done
);

  datapath DP (
    .rst_n( rst_n ),
    .clock( clock ),
    .clr( clr ),
    .inc( inc ),
    .tc( tc )
  );

  ctrl_mealy CTRL (
    .rst_n( rst_n ),
    .clock( clock ),
    .start( start ),
    .tc( tc ),
    .clr( clr ),
    .inc( inc ),
    .done( done )
  );

endmodule
