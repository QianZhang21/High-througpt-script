#!/bin/bash

rm -f select_list_0.4.txt

cordlist=('cord1' 'cord2' 'cord3' 'cord4' 'cord5')
for rows in `cat hse_stable.txt`
do
material=`echo $rows | sed 's/[^0-9a-Z]//g'`
if [ -d $material ]; then
cd ./$material
for cordprefix in ${cordlist[@]}
do
if [ -d $cordprefix ]; then
	cd ./$cordprefix
	for cordf in `ls`
	do
	if [ -d $cordf ]; then
		cd ./$cordf/band
		if test -s BAND_GAP
		then
		gaptype=`grep Character BAND_GAP | awk '{print $3}'`
		gapvalue=`echo $str | grep Gap BAND_GAP | awk '{print $4}'`	
		basenum=0.4
		if [ $gaptype == 'Direct' ]; then
			if [ `echo "$gapvalue>$basenum" |bc` -eq 1 ]; then
				cd ../../../..
				echo $material'/'$cordprefix'/'$cordf >> select_list_0.4.txt
				cd ./$material/$cordprefix/$cordf/band
			fi
		fi
		fi
		cd ../..

	fi
	done
	cd ../
fi
done
cd ../
fi
done

