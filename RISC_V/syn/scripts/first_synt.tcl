analyze -f vhdl -lib WORK ../src/adder_32bit.vhd
analyze -f vhdl -lib WORK ../src/mux2to1_32bit.vhd

analyze -f vhdl -lib WORK ../src/Check_jmp.vhd
analyze -f vhdl -lib WORK ../src/CU.vhd
analyze -f vhdl -lib WORK ../src/hazard_unit.vhd
analyze -f vhdl -lib WORK ../src/immediate_generator.vhd
analyze -f vhdl -lib WORK ../src/mux_2to1.vhd
analyze -f vhdl -lib WORK ../src/Reg_file.vhd
analyze -f vhdl -lib WORK ../src/ID.vhd

analyze -f vhdl -lib WORK ../src/alu.vhd
analyze -f vhdl -lib WORK ../src/and_block.vhd
analyze -f vhdl -lib WORK ../src/compare_block.vhd
analyze -f vhdl -lib WORK ../src/forwarding_unit.vhd
analyze -f vhdl -lib WORK ../src/mux_4to1.vhd
analyze -f vhdl -lib WORK ../src/mux_8to1.vhd
analyze -f vhdl -lib WORK ../src/shift_block.vhd
analyze -f vhdl -lib WORK ../src/sub_block.vhd
analyze -f vhdl -lib WORK ../src/sum_block.vhd
analyze -f vhdl -lib WORK ../src/xor_block.vhd
analyze -f vhdl -lib WORK ../src/execution_unit.vhd

analyze -f vhdl -lib WORK ../src/pc_register.vhd
analyze -f vhdl -lib WORK ../src/register_32bit.vhd
analyze -f vhdl -lib WORK ../src/Instruction_Fetch.vhd

analyze -f vhdl -lib WORK ../src/RegEX_MEM.vhd
analyze -f vhdl -lib WORK ../src/RegID_EX.vhd
analyze -f vhdl -lib WORK ../src/RegMEM_WB.vhd
analyze -f vhdl -lib WORK ../src/Rpipe_IF_ID.vhd

analyze -f vhdl -lib WORK ../src/Risc_V.vhd



set power_preserve_rtl_hier_names true
elaborate Risc_V -arch structural -lib WORK > ./output_report/elaborate.txt
uniquify
link

create_clock -name MY_CLK -period 14.0 Clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] Clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile

report_timing > ./output_report/reportTiming_maxF.txt
report_area > ./output_report/reportArea_maxF.txt

ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/Risc_V.sdf
write -f verilog -hierarchy -output ../netlist/Risc_V.v
write_sdc ../netlist/Risc_V.sdc

quit
