module lab_003_parta (
  input A, B, C,
  output G
  );

  assign G = (A | B | C) & (~A | ~(B ^ C));
endmodule
