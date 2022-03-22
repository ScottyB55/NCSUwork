module lab6_seq_1101_tb;

  reg rst_n, clock;
  wire d_in;
  wire found;

  // will be our shift register
  reg [31:0] shiftReg;

  lab6_seq_1101 DUT (
    .rst_n( rst_n ),
    .clock( clock ),
    .d_in( d_in ),
    .found( found )
  );

  // free-running clock
  initial clock = 0;
  always #5 clock = ~clock;

  // active low synchronous reset
  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end
  
  // this controls how long the testbench runs; it's
  // designed to tell the simulation to stop once 400
  // units of time have passed
  //   I settled on this number because the clock
  // periods are 10 units and there are 32 bits in the
  // shift register that are shifted out ... and then
  // a few extra
  initial
    #400 $stop;

  // this is a parallel in serial out shift register
  // that is loaded with stimulus on the reset.  the
  // value loaded is a 32-bit quantity that represents
  // the string that we want to send from left to
  // right (that way it's easy to see the pattern in
  // the string).  note that the output to the DUT is
  // taken from the left bit
  //   the shift is to shift left and bring in a 0 at
  // the least significant bit
  always @( posedge clock )
    if( !rst_n )
      // should match      .  .    .      .      .  .
      shiftReg <= 32'b00110110111101000110100011011010;
    else
      shiftReg <= {shiftReg[30:0], 1'b0};

  // the serial output of the register is driven to
  // the input of the DUT.  note that the bit of the
  // shift register chosen is the most significant;
  // this was to make it easy to write the value that
  // is shifted to the DUT.  specifically, we can read
  // it left to right above
  assign d_in = shiftReg[31];

endmodule
