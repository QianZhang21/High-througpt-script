#!/bin/bash

rm -f hse_gap_information.txt
echo material" "gaptype" "gapvalue" "direct_gap_v" "direct_gap_c" "E" "VBMLx" "VBMLy" "CBMLx" "CBMLy" "cordtype" "element" "elementnum" "hm1" "hm2" "h1" "h2" "h3" "h4 >>hse_gap_information.txt


for rows in `cat select_list_gt3.txt`
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
cd ./hse
gaptype=`grep Character BAND_GAP | awk '{print $3}'`
gapvalue=`grep Gap BAND_GAP | awk '{print $4}'`
VBMLx=`grep "Location of VBM" BAND_GAP | awk '{print $4}'`
VBMLy=`grep "Location of VBM" BAND_GAP | awk '{print $5}'`
CBMLx=`grep "Location of CBM" BAND_GAP | awk '{print $4}'`
CBMLy=`grep "Location of CBM" BAND_GAP | awk '{print $5}'`
#cd ../scf
E=`tail -1 OSZICAR | awk '{print $5}'`
cd ../../../..
gapv=`grep $rows gap_3.txt | awk '{print $4}'`
gapc=`grep $rows gap_3.txt | awk '{print $5}'`
echo $material" "$gaptype" "$gapvalue" "$gapv" "$gapc" "$E" "$VBMLx" "$VBMLy" "$CBMLx" "$CBMLy" "$cordprefix" "$element" "$elementnum" "$hm1" "$hm2" "$h1" "$h2" "$h3" "$h4 >>hse_gap_information.txt
done
