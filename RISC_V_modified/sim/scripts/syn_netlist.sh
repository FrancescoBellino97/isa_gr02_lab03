#!/bin/bash

source /software/scripts/init_msim6.2g

rm -rf work
rm -f transcript
rm -f vsim.wlf

vlib work

#compilo netlist

vlog -work ./work ../netlist/Risc_V.v

#compilo file VHDL testbench
vcom -93 -work ./work  ../tb/clock_gen.vhd
vcom -93 -work ./work  ../tb/RAM_data.vhd
vcom -93 -work ./work  ../tb/ROM_instruction.vhd
vcom -93 -work ./work  ../tb/rst_gen.vhd

vlog -work ./work ../tb/testbench.v

vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftype /testbench/DUT=../netlist/Risc_V.sdf work.testbench
