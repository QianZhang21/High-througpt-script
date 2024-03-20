#!/bin/bash

cordlist=('cord1')
#cordlist=('cord1' 'cord2' 'cord3' 'cord4' 'cord5')
for rows in `cat formula_list.txt`
do
material=`echo $rows | sed 's/[^0-9a-Z]//g'`
if [ -d $material ]; then
for cordprefix in ${cordlist[@]}
do
        cd ./$material/$cordprefix
        for cordf in `ls`
        do
        if [ -d $cordf ]; then
        	cd ./$cordf/band
		vaspkit -task 211 >/dev/null 2>&1
		#cp ~/work/material_design/high_throughput/INCAR_file/band_plot/* ./
		#sh plot_band.sh
		cd ../..
        fi
        done
        cd ../..
done
fi
done
