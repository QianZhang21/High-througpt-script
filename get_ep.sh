#!/bin/bash

prefix=/public/home/jlyang/zhangqian/work/material_design/high_throughput/hetebilayers_MXY_MXY_hse/MoSTeHfBrCl
savepath=/public/home/jlyang/zhangqian/work/material_design/high_throughput/hetebilayers_MXY_MXY_hse/ep_dir

cordlist=('cord1' 'cord2' 'cord4' 'cord3' 'cord5')
for cordprefix in ${cordlist[@]}
do
cd $prefix'/'$cordprefix"/"$cordprefix"-2/hse"
echo -e "426\n3" | vaspkit >/dev/null 2>&1
cp PLANAR_AVERAGE.dat $savepath"/"$cordprefix"-2-PLANAR_AVERAGE.dat" 

done

prefix=/public/home/jlyang/zhangqian/work/material_design/high_throughput/hetebilayers_MXY_MXY/MoSTeHfBrCl
cordlist=('cord1' 'cord2' 'cord4' 'cord3' 'cord5')
for cordprefix in ${cordlist[@]}
do
cd $prefix'/'$cordprefix"/"$cordprefix"-4/hse"
echo -e "426\n3" | vaspkit >/dev/null 2>&1
cp PLANAR_AVERAGE.dat $savepath"/"$cordprefix"-4-PLANAR_AVERAGE.dat"

done

