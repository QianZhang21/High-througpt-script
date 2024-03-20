#!/bin/bash

formulalist=formula_list.txt
poscarfile=POSCAR_file_hete_MXY

cordlist=('cord1')
for cordprefix in ${cordlist[@]}
do
for rows in `cat $formulalist`
do
	material=`echo $rows | sed 's/[^0-9a-Z]//g'` 
	if [ ! -d $material ];then
        	mkdir $material
	fi
	cd ./$material
	if [ ! -d $cordprefix ];then
        	mkdir $cordprefix
	fi
	cd ./$cordprefix
	poscar='-POSCAR'
	cp ../../../INCAR_file/$poscarfile/$cordprefix/$material$poscar* ./ 
	
	cd ../..
done

pot_path="/public/software/vasp/potpaw_PBE"
for rows in `cat $formulalist`
do
	material=`echo $rows | sed 's/[^0-9a-Z]//g'`
	cd ./$material/$cordprefix
		
	for fn in `ls -al | grep "^-" | awk '{print $9}'`
	do
		cp $fn POSCAR
		break
	done

	for element_i in `sed -n '6p' POSCAR`
        do
                if echo "$element_i"|grep "[a-zA-Z]" >/dev/null;then
                        post_dir=$pot_path/$element_i
                        if [ ! -d $post_dir ];then
                                addstr="_sv"
                                add_file=$element_i$addstr
                                cat $pot_path/$element_i$addstr/POTCAR>> POTCAR
                        else
                                cat $post_dir/POTCAR>> POTCAR
                        fi
                fi
        done

	rm POSCAR

	for cordfile in `ls`
        do
        	if [ $cordfile != POTCAR ];then
        		corddir=${cordfile:0-7}
        		if [ ! -d $corddir ];then
                		mkdir $corddir
        		fi
                	cd ./$corddir
                	cp ../$cordfile POSCAR
			cp ../POTCAR ./
			cp ../../../../INCAR_file/INCAR ./
			cp ../../../../INCAR_file/KPOINTS ./
			cd ..
			rm $cordfile
	        fi
        done
	cd ../../
done

done


