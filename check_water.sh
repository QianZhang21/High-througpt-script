#!/bin/bash

filename="direct_list.txt"

path=`pwd -P`
for material in `ls $path`
do
if [ -d $material ]; then
if [ `grep -c $material $filename` -ne 0 ]; then
echo $material
fi
fi
done

