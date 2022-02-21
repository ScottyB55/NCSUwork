# Verilog Component Library
This directory will grow to contain a library of components that may be used in
your homework, labs, and projects.

## Compiling
Any of these components may be compiled along with all of your other Verilog for
an assignment.  Just include the file that you would like to compile on the
command line.  For example, let's say that you have a directory called
"some_work/" in your repository at the same level as the library so that it
looks like

```
ece310/
  |- library
  `- some_work
```

When you're in the some_work directory to compile your code you should include
the library components that you need on the same command line like

```
% vlog *.v ../library/dff.v
```

## Components
Below are descriptions of the components with input and output ports defined.

### Module: dff
  rst_n  input   Active low synchronous reset
  clock  input   Freerunning clock
  d      input   D input to flop
  q      output  Q output from flop
  q_n    output  Inverted Q output from flop

### Module: dff_4bit
  rst_n        input   Active low synchronous reset
  clock        input   Freerunning clock
  d      [3:0] input   D inputs to flop
  q      [3:0] output  Q outputs from flop

### Module mux21
  sel    input   Select bit
  in_0   input   Value passed when sel == 0
  in_1   input   Value passed when sel == 1
  f      output  Mux output

### Module mux21_4bit
  sel    [1:0] input   Select bit
  in_0   [3:0] input   Value passed when sel == 0
  in_1   [3:0] input   Value passed when sel == 1
  f      [3:0] output  Mux output
