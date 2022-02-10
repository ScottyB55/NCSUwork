module lab_003_partc (
  input A, B, C, D,
  output F
);
  wire G;	// Intermediate wire

  // Instantiate other modules
  // <modulename> <reference> (<portconnections>)
  // portconnection order defined in module definition
  // Can be explicitly defined
  lab_003_parta PARTA(.G(G), .A(A), .B(B), .C(C));
  lab_003_partb PARTB(.F(F), .G(G), .D(D));

endmodule
