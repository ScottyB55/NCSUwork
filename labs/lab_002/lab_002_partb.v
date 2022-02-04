module lab_002_partb (
  input A,
  input B,
  input C,
  output F
);

  // Dataflow Verilog
  // assign F = A&B&C | ~A&B;

  // Structural Verilog
  /* put your variable declarations here */
  wire notA, nAB, ABC;

  /* put your gate instances here */
  not U1 (notA, A);
  and U2 (nAB, notA, B);
  and U3 (ABC, A, B, C);
  or  U4 (F, nAB, ABC);
 
endmodule
