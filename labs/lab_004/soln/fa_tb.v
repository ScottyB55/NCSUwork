// Testbench for both implementations
module fa_tb;

  integer i;
  reg a, b, c;
  wire cout, sum;

  fa DUT (
    .Cin(a),
    .A(b),
    .B(c),
    .Cout( cout ),
    .Sum( sum )
  );

  initial begin
    $display( $time, ": C A B | C S" );
    $display( $time, ":-------+----" );
    $monitor( $time, ": %0b %0b %0b | %0b %0b",
      a, b, c, cout, sum );
  end

  initial
  begin
        {a, b, c} = 0;
    #10 {a, b, c} = 1;
    #10 {a, b, c} = 2;
    #10 {a, b, c} = 3;
    #10 {a, b, c} = 4;
    #10 {a, b, c} = 5;
    #10 {a, b, c} = 6;
    #10 {a, b, c} = 7;
    #10 $stop;
  end

endmodule
