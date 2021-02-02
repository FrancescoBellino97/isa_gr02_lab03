#leggo la netlist del circuito
read_verilog -netlist ../netlist/Risc_V.v

#leggo file della switching activity
read_saif -input ../saif/RiscV_syn.saif -instance testbench/DUT -unit ns -scale 1

create_clock -name MY_CLK Clk

#salvo il report power
report_power > ./output_report/report_power_syn.txt

quit
