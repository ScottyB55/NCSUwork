The follow are the commands and output that I saw when simulating the
system provided.  Once simulated a vsim.wlf file is present that may be
opened in the Modelsim GUI for inspection.

[bdheard@grendel29 20220309]$ module load modelsim/2021.2
[bdheard@grendel29 20220309]$ vlib work
[bdheard@grendel29 20220309]$ vmap work work
Model Technology ModelSim SE vmap 2021.2 Lib Mapping Utility 2021.04 Apr 14 2021
vmap work work
Copying /mnt/apps/public/COE/mg_apps/modelsim2021.2/linux/../modelsim.ini to modelsim.ini
Modifying modelsim.ini
[bdheard@grendel29 20220309]$ vlog *.v
Model Technology ModelSim SE vlog 2021.2 Compiler 2021.04 Apr 14 2021
Start time: 19:14:26 on Mar 09,2022
vlog controllers.v datapath.v tops.v tops_tb.v
-- Compiling module ctrl_moore
-- Compiling module ctrl_mealy
-- Compiling module datapath
-- Compiling module top_moore
-- Compiling module top_mealy
-- Compiling module tops_tb

Top level modules:
        tops_tb
End time: 19:14:26 on Mar 09,2022, Elapsed time: 0:00:00
Errors: 0, Warnings: 0
[bdheard@grendel29 20220309]$ vsim -c -voptargs="+acc" tops_tb
Reading pref.tcl

# 2021.2

# vsim -c -voptargs="+acc" tops_tb
# Start time: 19:14:40 on Mar 09,2022
# ** Note: (vsim-3812) Design is being optimized...
# ** Note: (vopt-143) Recognized 1 FSM in module "ctrl_moore(fast)".
# //  ModelSim SE 2021.2 Apr 14 2021 Linux 3.10.0-1160.59.1.el7.x86_64
# //
# //  Copyright 1991-2021 Mentor Graphics Corporation
# //  All Rights Reserved.
# //
# //  ModelSim SE and its associated documentation contain trade
# //  secrets and commercial or financial information that are the property of
# //  Mentor Graphics Corporation and are privileged, confidential,
# //  and exempt from disclosure under the Freedom of Information Act,
# //  5 U.S.C. Section 552. Furthermore, this information
# //  is prohibited from disclosure under the Trade Secrets Act,
# //  18 U.S.C. Section 1905.
# //
# Loading work.tops_tb(fast)
# Loading work.top_moore(fast)
# Loading work.datapath(fast)
# Loading work.ctrl_moore(fast)
# Loading work.top_mealy(fast)
# Loading work.ctrl_mealy(fast)
VSIM 1> log -r *
VSIM 2> run -all
# ** Note: $stop    : tops_tb.v(81)
#    Time: 570 ns  Iteration: 0  Instance: /tops_tb
# Break in Module tops_tb at tops_tb.v line 81
# Stopped at tops_tb.v line 81
VSIM 3> quit
# End time: 19:16:44 on Mar 09,2022, Elapsed time: 0:02:04
# Errors: 0, Warnings: 0
[bdheard@grendel29 20220309]$ vsim vsim.wlf &
