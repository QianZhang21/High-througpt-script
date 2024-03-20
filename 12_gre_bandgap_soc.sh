#!/bin/bash

rm -f hse_soc_gap_inf.txt
echo material" "gaptype" "gapvalue" "E" "VBMLx" "VBMLy" "cordtype" "element" "elementnum" "hm1" "hm2" "h1" "h2" "h3" "h4" "Ef >>hse_soc_gap_inf.txt


#for rows in `cat select_list_gt4.txt`
for rows in `cat select_list_gt4.txt`
do
cd $rows
material=`echo $rows | awk -F '/' '{print $1}'`
cordprefix=`echo $rows | awk -F '/' '{print $2}'`
cordf=`echo $rows | awk -F '/' '{print $3}'`
element=`cat CONTCAR | sed -n '6p' | sed 's/[ ][ ]*/-/g'`
elementnum=`cat CONTCAR | sed -n '7p' | sed 's/[ ][ ]*/-/g'`
hm1=`nl CONTCAR | sed -n '9p' | awk '{print $4}'`
hm2=`nl CONTCAR | sed -n '10p' | awk '{print $4}'`
h1=`nl CONTCAR | sed -n '11p' | awk '{print $4}'`
h2=`nl CONTCAR | sed -n '12p' | awk '{print $4}'`
h3=`nl CONTCAR | sed -n '13p' | awk '{print $4}'`
h4=`nl CONTCAR | sed -n '14p' | awk '{print $4}'`
if [ -d hse_soc ]; then
cd ./hse_soc
#cp ../scf/KPATH.in ./
#echo $material'/'$cordprefix'/'$cordf		
vaspkit -task 252 >/dev/null 2>&1
gaptype=`grep Character BAND_GAP | awk '{print $3}'`
gapvalue=`grep Gap BAND_GAP | awk '{print $4}'`
VBMLx=`grep "Location of VBM" BAND_GAP | awk '{print $4}'`
VBMLy=`grep "Location of VBM" BAND_GAP | awk '{print $5}'`
Ef=`grep 'E-fermi' OUTCAR | awk '{print $3}'`
#cp ~/work/material_design/high_throughput/INCAR_file/band_plot/* ./
#sh plot_band.sh
#cp band.png ../../../../hse_soc_band/$material'-'$cordf'.png'
#cp BAND.dat ../../../../hse_soc_band/$material'-'$cordf'.dat'
#cp BAND_GAP ../../../../hse_soc_band/$material'-'$cordf'-BAND_GAP'
E=`tail -1 OSZICAR | awk '{print $5}'`
cd ../../../..
echo $material" "$gaptype" "$gapvalue" "$E" "$VBMLx" "$VBMLy" "$cordprefix" "$element" "$elementnum" "$hm1" "$hm2" "$h1" "$h2" "$h3" "$h4" "$Ef >>hse_soc_gap_inf.txt
else
echo $material'/'$cordprefix'/'$cordf 
cd ../../..
fi
done

