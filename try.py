#~/software/anaconda3/bin/python
# -*- coding:utf-8 -*-

import sys

mpath, vbm_index, cbm_index, gapo=sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), float(sys.argv[4])

import numpy as np
#xtick = []
#with open(mpath+'band/KLABELS', 'r') as reader:
#    lines = reader.readlines()[1:]
#    for i in lines:
#        s = i.encode('utf-8')
#        if len(s.split()) == 2 and not s.decode('utf-8', 'ignore').startswith('*'):
#            xtick.append(float(s.split()[1]))

datas = np.loadtxt(mpath+'/hse/REFORMATTED_BAND.dat', dtype=np.float64)


#kpoints = datas[:, 0]
vbm_band = datas[:, vbm_index]
cbm_band = datas[:, cbm_index]
vbm_point = np.sort(vbm_band)[-1]
cbm_point = np.sort(cbm_band)[0]
#for i in range(len(kpoints)):
#    if abs(kpoints[i] - xtick[2]) <= 0.01:
#        cbm_point2 = cbm_band[i]
#        break
        
for i in range(len(vbm_band)):
    if vbm_band[i] == vbm_point:
        cbm_point_2 = cbm_band[i]
        break
        
for i in range(len(cbm_band)):
    if cbm_band[i] == cbm_point:
        vbm_point_2 = vbm_band[i]
        break

indirect_gap = float(cbm_point - vbm_point)
direct_gap_v = float(cbm_point_2 - vbm_point)
direct_gap_c = float(cbm_point - vbm_point_2)

flag=0
if abs(indirect_gap-direct_gap_v)<=0.1 or abs(indirect_gap-direct_gap_c)<=0.1:
    flag=1

indirect_gap = format(float(cbm_point - vbm_point), '.4f')
direct_gap_v = format(float(cbm_point_2 - vbm_point), '.4f') #float(cbm_point_2 - vbm_point)
direct_gap_c = format(float(cbm_point - vbm_point_2), '.4f') #float(cbm_point - vbm_point_2)

import csv
with open('gap_3.txt', 'a+', newline='') as f:
    writer = csv.writer(f)
    writer.writerow([str(mpath)+"    "+str(gapo)+"    "+str(indirect_gap)+"    "+str(direct_gap_v)+"    "+str(direct_gap_c) +"    "+str(flag)+"    "])


#if flag == 1:
#    with open('indirect_list.txt', 'a+') as f:
#        f.write(mpath+'\n')
