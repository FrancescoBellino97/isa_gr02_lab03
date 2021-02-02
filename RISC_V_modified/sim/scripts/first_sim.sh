#!/bin/bash

source /software/scripts/init_msim6.2g

rm -rf work
rm -f transcript
rm -f vsim.wlf

vlib work

#compilo file VHDL sorgente
vcom -93 -work ./work ../src/*.vhd


#compilo file VHDL testbench
vcom -93 -work ./work  ../tb/clock_gen.vhd
vcom -93 -work ./work  ../tb/RAM_data.vhd
vcom -93 -work ./work  ../tb/ROM_instruction.vhd
vcom -93 -work ./work  ../tb/rst_gen.vhd

#vcom -93 -work ./work  ../tb/testbench_risc-v.vhd
vlog -work ./work ../tb/testbench.v


vsim work.testbench
