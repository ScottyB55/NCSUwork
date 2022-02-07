module fsmopt_tb;

  wire [3:0] capture;

  reg rst_n, clk, arm, trigger;

  impl_dff DUT_DFF ( rst_n, clk, arm, trigger, capture[0] );
  impl_alt_dff DUT_ALT_DFF ( rst_n, clk, arm, trigger, capture[1] );
  impl_tff DUT_TFF ( rst_n, clk, arm, trigger, capture[2] );
  impl_jkff DUT_JKFF ( rst_n, clk, arm, trigger, capture[3] );

  always #5 clk <= ~clk;

  initial begin
        clk   = 0;
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
        {arm, trigger} = 2'b00;
    #50 {arm, trigger} = 2'b10;
    #10 {arm, trigger} = 2'b00;
    #80 {arm, trigger} = 2'b01;
    #10 {arm, trigger} = 2'b00;
    #20 $stop;
  end

endmodule

module impl_dff (
  input rst_n,
  input clk,
  input arm,
  input trigger,
  output capture
);

  wire [1:0] Q, Q_n, D;

  dff Q1 ( rst_n, clk, D[1], Q[1], Q_n[1] );
  dff Q0 ( rst_n, clk, D[0], Q[0], Q_n[0] );

  assign D[1] = Q_n[1] & Q[0] & trigger;
  assign D[0] = Q_n[1] & Q[0] & ~trigger | Q_n[1] & Q_n[0] & arm;
  assign capture = Q[1];

endmodule

module impl_alt_dff (
  input rst_n,
  input clk,
  input arm,
  input trigger,
  output capture
);

  wire [1:0] Q, Q_n, D;

  dff Q1 ( rst_n, clk, D[1], Q[1], Q_n[1] );
  dff Q0 ( rst_n, clk, D[0], Q[0], Q_n[0] );

  assign D[1] = Q_n[1] & Q[0] & trigger;
  assign D[0] = Q_n[1] & Q[0] | Q_n[1] & arm;
  assign capture = Q[1];

endmodule

module impl_tff (
  input rst_n,
  input clk,
  input arm,
  input trigger,
  output capture
);

  wire [1:0] Q, Q_n, T;

  tff Q1 ( rst_n, clk, T[1], Q[1], Q_n[1] );
  tff Q0 ( rst_n, clk, T[0], Q[0], Q_n[0] );

  assign T[1] = Q[1] | Q[0] & trigger;
  assign T[0] = Q[1] & Q[0] | Q_n[1] & Q_n[0] & arm;
  assign capture = Q[1];

endmodule

module impl_jkff (
  input rst_n,
  input clk,
  input arm,
  input trigger,
  output capture
);

  wire [1:0] Q, Q_n, J, K; 

  jkff Q1 ( rst_n, clk, J[1], K[1], Q[1], Q_n[1] );
  jkff Q0 ( rst_n, clk, J[0], K[0], Q[0], Q_n[0] );

  assign J[1] = Q[0] & trigger;
  assign K[1] = 1'b1;
  assign J[0] = Q_n[1] & arm;
  assign K[0] = 1'b0;
  assign capture = Q[1];

endmodule

module dff (
  input rst_n,
  input clk,
  input D,
  output reg Q,
  output Q_n
);

  always @( posedge clk )
    if( !rst_n )
      Q <= 0;
    else
      Q <= D;

  assign Q_n = ~Q;

endmodule

module tff (
  input rst_n,
  input clk,
  input T,
  output reg Q,
  output Q_n
);

  always @( posedge clk )
    if( !rst_n )
      Q <= 0;
    else
      if( T )
        Q <= ~Q;
      else
        Q <= Q;

  assign Q_n = ~Q;

endmodule

module jkff (
  input rst_n,
  input clk,
  input J,
  input K,
  output reg Q,
  output Q_n
);

  always @( posedge clk )
    if( !rst_n )
      Q <= 0;
    else
      case ( {J,K} )
        2'b00 : Q <= Q;
        2'b01 : Q <= 1'b0;
        2'b10 : Q <= 1'b1;
        2'b11 : Q <= Q_n;
        default : Q <= 1'b0;
      endcase

  assign Q_n = ~Q;

endmodule
