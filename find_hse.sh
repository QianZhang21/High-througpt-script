#!/bin/bash

cordlist=('cord1' 'cord2' 'cord3' 'cord4' 'cord5')
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
		cd ./$cordf
		if [ -d scf_hse ]; then
			echo $material'/'$cordprefix'/'$cordf
		fi
		cd ../
	fi
	done
	cd ../..
done
fi
done

