#!/bin/bash

formulalist=formula_list.txt
poscarfile=POSCAR_file_hete_MXY

cordlist=('cord5')
for cordprefix in ${cordlist[@]}
do
for rows in `cat $formulalist`
do
	material=`echo $rows | sed 's/[^0-9a-Z]//g'`
	cd $material/$cordprefix
	rm *POSCAR*
	cd ../..
done
done
