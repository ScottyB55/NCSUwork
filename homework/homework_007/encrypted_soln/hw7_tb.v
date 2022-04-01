module hw7_tb;

  reg rst_n, clock;
  wire ser_in, p_load, overlap, o_load;
  wire [3:0] pattern;
  wire found;

  wire [7:0] play;

  hw7 DUT (
    .rst_n( rst_n ),
    .clock( clock ),
    .ser_in( ser_in ),
    .found( found ),
    .pattern( pattern ),
    .p_load( p_load ),
    .overlap( overlap ),
    .o_load( o_load )
  );

  tb_player #(
    .WIDTH( 8 ),
    .PFILE( "tb_player.dat" ),
    .RAND_DELAY( 0 )
  ) player (
    .rst_n( rst_n ),
    .clock( clock ),
    .play( play )
  );

  assign {ser_in, p_load, pattern, o_load, overlap} = play;

  initial clock <= 0;
  always #5 clock <= ~clock;

  initial begin
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial begin
    #620 $stop();
  end

endmodule
