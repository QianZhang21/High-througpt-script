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

datas = np.loadtxt(mpath+'/band/REFORMATTED_BAND.dat', dtype=np.float64)


#kpoints = datas[:, 0]
vbm_band = datas[:, vbm_index]
cbm_band = datas[:, cbm_index]
gap_value = cbm_band - vbm_band
gap_value = np.sort(gap_value)
print(gap_value[:2])
