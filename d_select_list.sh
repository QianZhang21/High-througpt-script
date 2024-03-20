#!/bin/bash
rm gap_3.txt indirect_list.txt
echo path"    "gapvalue"    "indirect_gap"   "direct_gap_v"    "direct_gap_c"    "flag"    " >> gap_3.txt 

for rows in `cat select_list_gt3.txt`
do
mpath=$rows
cd $mpath'/hse'
vbm_index=`grep 'HOMO & LUMO Bands' BAND_GAP | awk '{print $5}'`
cbm_index=`grep 'HOMO & LUMO Bands' BAND_GAP | awk '{print $6}'`
gapo=`grep Gap BAND_GAP | awk '{print $4}'`
cd ../../../..
python try.py $mpath $vbm_index $cbm_index $gapo
done
