#!/bin/bash
material=`head -n 1 POSCAR`
vbm_index=`grep 'HOMO & LUMO Bands' BAND_GAP | awk '{print $5}'`
cbm_index=`grep 'HOMO & LUMO Bands' BAND_GAP | awk '{print $6}'`
gap_value=`grep Gap BAND_GAP | awk '{print $4}'`

python bandos_read.py $vbm_index $cbm_index $material $gap_value



