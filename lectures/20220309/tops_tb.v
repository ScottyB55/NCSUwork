module tops_tb;

  // these are each signals that the testbench will be
  // changing over time; since they are assigned inside of a
  // procedural block (the initial block) they must be of
  // type reg
  //
  // these are also common signals that will connect to the
  // inputs of the DUTs providing each with the same
  // stimulus; in that way we can compare how each of the
  // controllers behaves
  reg rst_n, clock;
  reg start;

  // we're instantiating two different DUTs, one each for the
  // Mealy and Moore type outputs; each one needs it's own
  // done signal
  wire done_moore, done_mealy;

  // Moore type done output
  top_moore DUT_moore (
    .rst_n( rst_n ),
    .clock( clock ),
    .start( start ),
    .done( done_moore )
  );

  // Mealy type done output
  top_mealy DUT_mealy (
    .rst_n( rst_n ),
    .clock( clock ),
    .start( start ),
    .done( done_mealy )
  );

  // while these are written on a single line each, they are
  // both independent procedural blocks; the initial is there
  // to tell the simulation that at the very beginning of the
  // simulation the clock should be assigned 0
  //
  // the always procedural block doesn't have a sensitivity
  // list that we're used to seeing; instead is uses a time
  // specification as the sensitivity list; what this does is
  // schedule the procedural block to evaluate after 5 units
  // of time; once the block completes its evaluation it is
  // scheduled to be evaluated after the next 5 units of time
  initial clock = 0;
  always #5 clock = ~clock;

  // another initial block that controls the reset; at the
  // beginning of simulation the value of the reset is low;
  // then, after 10 units of time, it goes high; this means
  // that it is low across the first rising clock edge created
  // by the blocks above
  //
  // note that this only evaluates once at the beginning of
  // simulation; that's a property of the initial block
  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  // this is where the stimulus is applied; start begins with
  // a value of 0 and after 50 units of time pulses for 10 units
  // of time; this creates the condition where start is asserted
  // over a rising clock edge so that it may be "seen" by the
  // DUTs
  //
  // the process repeats 300 units of time later to demonstrate
  // how the DUT controllers go back to an initial state to be
  // able to respond to another start pulse
  initial begin
         start = 0;
    #50  start = 1;
    #10  start = 0;
    #300 start = 1;
    #10  start = 0;

    // the $stop directive tells the simulator to stop the
    // simulation while leaving the simulator open
    #200 $stop;
  end

endmodule
