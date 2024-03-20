#!/bin/bash

cordlist=('cord2' 'cord3' 'cord4' 'cord5')
#cordlist=('cord1')
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
		ionstep=`tail -1 OSZICAR | awk '{print $1}'`
		if [ $ionstep -gt 2 ];then
			echo $material'/'$cordprefix'/'$cordf
			echo $ionstep
			cd ..
		else 
			cd ..
		fi
	fi
	done
	cd ../..
done
fi
done
