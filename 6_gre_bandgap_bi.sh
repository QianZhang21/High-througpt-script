#!/bin/bash

rm -f gap_information.txt
echo material" "gaptype" "gapvalue" "E" "VBMLx" "VBMLy" "cordtype" "element" "elementnum" "hm1" "hm2" "h1" "h2" "h3" "h4" "Ef >>gap_information.txt


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
		element=`cat CONTCAR | sed -n '6p' | sed 's/[ ][ ]*/-/g'`
                elementnum=`cat CONTCAR | sed -n '7p' | sed 's/[ ][ ]*/-/g'`
                hm1=`nl CONTCAR | sed -n '9p' | awk '{print $4}'`
		hm2=`nl CONTCAR | sed -n '10p' | awk '{print $4}'`
		h1=`nl CONTCAR | sed -n '11p' | awk '{print $4}'`
                h2=`nl CONTCAR | sed -n '12p' | awk '{print $4}'`
                h3=`nl CONTCAR | sed -n '13p' | awk '{print $4}'`
                h4=`nl CONTCAR | sed -n '14p' | awk '{print $4}'`
		cd ./band
		cp ../CONTCAR POSCAR
		vaspkit -task 211 >/dev/null 2>&1
		gaptype=`grep Character BAND_GAP | awk '{print $3}'`
		gapvalue=`grep Gap BAND_GAP | awk '{print $4}'`
		VBMLx=`grep "Location of VBM" BAND_GAP | awk '{print $4}'`
		VBMLy=`grep "Location of VBM" BAND_GAP | awk '{print $5}'`
		Ef=`grep 'E-fermi' OUTCAR | awk '{print $3}'`
		if [ $gaptype == 'Direct' ]; then
			cp ~/work/material_design/high_throughput/INCAR_file/band_plot/* ./
                	sh plot_band.sh
			cp band.png ../../../../direct_band/$material'-'$cordf'.png'
			cp BAND.dat ../../../../direct_band/$material'-'$cordf'.dat'
			#rm CHG*
			#rm POTCAR
			#rm POSCAR
			cd ../scf
		else
			#rm band.png
			#rm BAND.dat
			#rm BAND_GAP
			#rm CHG*
			#rm POTCAR 
                        #rm POSCAR
			cd ../scf
			#rm CHG*
                	#rm POTCAR
                	#rm POSCAR
		fi
		#cd ../scf
		E=`tail -1 OSZICAR | awk '{print $5}'`
		cd ../../../..
		echo $material" "$gaptype" "$gapvalue" "$E" "$VBMLx" "$VBMLy" "$cordprefix" "$element" "$elementnum" "$hm1" "$hm2" "$h1" "$h2" "$h3" "$h4" "$Ef >>gap_information.txt
		cd ./$material/$cordprefix
	#else
	#	rm $cordf
	fi
	done
	cd ../..
done
fi
done

