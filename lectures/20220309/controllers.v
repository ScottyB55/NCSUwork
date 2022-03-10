module ctrl_moore (
  input rst_n, clock,
  input start, tc,

  // notice here that the outputs are declared as type reg;
  // remember that these are assigned to within a procedural
  // block and that's what requires them to be a reg type,
  // however, they're not in a clock procedural block so even
  // though they are type reg they are not flip flops
  output reg clr, inc, done
);

  // here I've made the local parameters integers; the
  // simulator will make them the correct width by truncating
  // them
  localparam S0 = 0;
  localparam S1 = 1;
  localparam S2 = 2;

  // this is where the most mistakes are made; ensure that the
  // width of the cstate and nstate variables is sufficient to
  // hold the number of bits required
  reg [1:0] cstate, nstate;

  // the sequential part of the state machine; this won't
  // change except for the type of reset for all of the
  // machines that you build
  always @( posedge clock )
    if( !rst_n )
      cstate <= S0;
    else
      cstate <= nstate;

  // the combinational part; here we evaluate outputs and the
  // next state based on the state that we're in
  always @*
    case( cstate )

      // E.g. if cstate is S0 then we evaluate these expressions;
      // note that I need to include a begin ... end since there
      // are multiple expressions (I forgot this in class)
      S0 : begin
        // this is using concatenation on the LHS just for
        // convenience
        {clr, inc, done} = 3'b100;

        // similarly, this is a ternary assignment and used only
        // for convenience; generally I would use an if clause
        // here
        nstate = start ? S1 : S0;
      end

      S1 : begin
        {clr, inc, done} = 3'b010;
        nstate = tc ? S2 : S1;
      end

      S2 : begin
        {clr, inc, done} = 3'b001;
        nstate = S0;
      end

      // you should always include a default case even though
      // you think that you got all of them above; for the
      // simulator there are 4 values for each bit that
      // include x and z and we've only handled the ones where
      // the bits are 0 and 1
      default : begin
        {clr, inc, done} = 3'b100;
        nstate = S0;
      end
    endcase

endmodule

module ctrl_mealy (
  input rst_n, clock,
  input start, tc,
  output reg clr, inc, done
);

  localparam S0 = 0;
  localparam S1 = 1;

  reg cstate, nstate;

  always @( posedge clock )
    if( !rst_n )
      cstate <= S0;
    else
      cstate <= nstate;

  always @*
    case( cstate )
      S0 : begin
        {clr, inc, done} = 3'b100;
        nstate = start ? S1 : S0;
      end

      // this is the major difference from the implementation
      // above; here the done output of the controller is a
      // Mealy type output based on the cstate begin S1 and the
      // value of TC being asserted
      S1 : begin
        {clr, inc} = 2'b01;
        done = tc;
        nstate = tc ? S0 : S1;
      end

      default : begin
        {clr, inc, done} = 3'b100;
        nstate = S0;
      end
    endcase

endmodule
