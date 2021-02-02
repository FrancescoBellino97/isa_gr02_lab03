rm -f ../saif/RiscV_syn.saif
source /software/scripts/init_synopsys_64.18
vcd2saif -input ../vcd/RiscV_syn.vcd -output ../saif/RiscV_syn.saif
