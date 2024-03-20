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
		cd ./$cordf/band
		gaptype=`grep Character BAND_GAP | awk '{print $3}'`
		if [ $gaptype != 'Direct' ]; then
			cd ../..
			rm -rf $cordf
		else
			cd ../..
		fi
	fi
	done
	cd ../..
done
fi
done


cordlist=('cord1' 'cord2' 'cord3' 'cord4' 'cord5')
for rows in `cat formula_list.txt`
do
material=`echo $rows | sed 's/[^0-9a-Z]//g'`
if [ -d $material ]; then
cd ./$material
for cordprefix in ${cordlist[@]}
do
        if [ "`ls -A $cordprefix`" = ""  ]; then
                rm -rf $cordprefix
        fi
done
cd ..
fi
done


for rows in `cat formula_list.txt`
do
material=`echo $rows | sed 's/[^0-9a-Z]//g'`
if [ -d $material ]; then
if [ "`ls -A $material`" = ""  ]; then
rm -rf $material
fi
fi
done
