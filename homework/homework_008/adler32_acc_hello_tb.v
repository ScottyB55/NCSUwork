module adler32_acc_hello_tb();

  reg rst_n, clk;
  reg [7:0] data;
  wire [31:0] checksum;

  always #5 clk = ~clk;

  adler32_acc DUT (
    .rst_n( rst_n ),
    .clk( clk ),
    .data( data ),
    .checksum( checksum )
  );

  initial
  begin
        clk   = 0;
        rst_n = 0;
    #10 rst_n = 1;
  end

  initial
  begin

    $monitor( $time, ": checksum is 32'h%08x", checksum );

    // delay of 6 units is here just to emphasize that
    // the data change values as a result of the clock
    // edge
    #6  data =  72;
    #10 data = 101;
    #10 data = 108;
    #20 data = 111;
    #10 $stop;

  end

endmodule
