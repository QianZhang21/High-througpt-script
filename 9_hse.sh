#!/bin/bash


for rows in `cat select_list_gt3.txt`
do
cd $rows
cd ./hse2
cp ../../../../try.* ./
sh try.sh
cd ../../../..
done
