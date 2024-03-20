#!/bin/bash

for rows in `cat select_list_soc_22.txt`
do
cd $rows
if [ ! -d scf_soc ];then
mkdir scf_soc
fi
cd ./scf_soc
cp ../scf/PO* ./
cp ~/work/material_design/high_throughput/INCAR_file/INCAR_scf_soc INCAR

cd ..
if [ ! -d hse_soc ];then
mkdir hse_soc
fi
cd ./hse_soc
cp ../POTCAR ./
cp ../CONTCAR POSCAR
cp ~/work/material_design/high_throughput/INCAR_file/INCAR_hse_soc INCAR

cd ../../../..
done
