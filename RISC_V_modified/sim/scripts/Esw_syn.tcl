#preparo file di output switching activity
vcd file ../vcd/RiscV_syn.vcd
vcd add /testbench/DUT/*

#preparo file di output report power
power add *

add wave *
run 1900 ns

#salvo report power
power report -file ./output_report/Esw_RiscV_syn.txt
