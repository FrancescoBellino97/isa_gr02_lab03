#!/bin/bash

#rimuovo cartella di output e di lavoro precedenti
#rm -rf output_report
rm -rf work
rm -f command.log
rm -f default.svf

if ! [ -e .synopsys_dc.setup ]
	then
	echo "File \".synopsys_dc.setup\" non trovato"
	exit 0
fi



#inizializzo ambiente synopsys
source /software/scripts/init_synopsys_64.18

#creo cartella di lavoro e di output
mkdir work
if [ ! -d output_report ]
then
mkdir output_report
fi

#avvio synopsys in modalità shell
dc_shell-xg-t
