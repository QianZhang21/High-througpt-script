#!/bin/bash

#cordlist=('cord2' 'cord3' 'cord4' 'cord5')
cordlist=('cord1')
for rows in `cat formula_list.txt`
do
material=`echo $rows | sed 's/[^0-9a-Z]//g'`
if [ -d $material ]; then
for cordprefix in ${cordlist[@]}
do
        cd ./$material
        if [ -d $cordprefix ]; then
                cd ./$cordprefix
                for cordf in `ls`
                do
                if [ -d $cordf ]; then
                        cd ./$cordf
                        if [ ! -d scf ];then
				mkdir scf
			fi
			cd ./scf
			cp ../KPOINTS ./
			cp ../POTCAR ./
			cp ../CONTCAR POSCAR
			cp ~/work/material_design/high_throughput/INCAR_file/INCAR_scf INCAR

			cd ..
			if [ ! -d band ];then
                                mkdir band
                        fi
			cd ./band
			cp ../POTCAR ./
			cp ../CONTCAR POSCAR
			cp ~/work/material_design/high_throughput/INCAR_file/INCAR_band INCAR
			cp ~/work/material_design/high_throughput/INCAR_file/KPATH.in KPOINTS
			cd ../..
                fi
                done
                cd ../..
        else
                cd ..
        fi
done
fi
done
