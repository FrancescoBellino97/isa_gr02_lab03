#!/bin/bash
if ! [ -e design.globals ]
	then
	echo "ERRORE: file design.globals non trovato"
	exit 0
fi
if ! [ -e mmm_design.tcl ]
	then
	echo "ERRORE: file mmm_design.tcl non trovato"
	exit 0
fi

rm -f innovus.cmd
rm -f innovus.log
rm -f innovus.logv

#inizializzo ambiente innovus
source /software/scripts/init_innovus17.11

innovus
