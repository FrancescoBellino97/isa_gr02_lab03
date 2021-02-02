#preparo file di output switching activity
vcd file ../vcd/Risc_V_innovus.vcd
vcd add /testbench/DUT/*

#preparo file di output report power
power add *

add wave *
add wave RAM/result
run 1900 ns

#salvo report power
power report -file ./output_report/Esw_Risc_V_innovus.txt
