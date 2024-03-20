#!/bin/bash

vbm_index=`grep 'HOMO & LUMO Bands' BAND_GAP | awk '{print $5}'`
cbm_index=`grep 'HOMO & LUMO Bands' BAND_GAP | awk '{print $6}'`

python band_read.py $vbm_index $cbm_index
