# -*- coding:utf-8 -*-
import sys

vbm_index, cbm_index = int(sys.argv[1]), int(sys.argv[2])

import numpy as np
import matplotlib as mpl

mpl.use('Agg')  # silent mode
from matplotlib import pyplot as plt
import matplotlib.ticker as ticker

# ------------------ FONT_setup ----------------------
font = {'family': 'DejaVu Sans',
        'color': 'black',
        'weight': 'normal',
        'size': 13.0,
        }

# ------------------- Data Read ----------------------
group_labels = []
xtick = []
with open('KLABELS', 'r') as reader:
    lines = reader.readlines()[1:]
for i in lines:
    s = i.encode('utf-8')  # .decode('latin-1')
    if len(s.split()) == 2 and not s.decode('utf-8', 'ignore').startswith('*'):
        group_labels.append(s.decode('utf-8', 'ignore').split()[0])
        xtick.append(float(s.split()[1]))
datas = np.loadtxt('REFORMATTED_BAND.dat', dtype=np.float64)
for index in range(len(group_labels)):
    if group_labels[index] == 'GAMMA':
        group_labels[index] = u'Γ'

# vbm_index, cbm_index = input("vbm_and_cbm_index: \n").split()
dot_y = [max(datas[:, vbm_index]), min(datas[:, cbm_index])]
dot_x = [datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][0], 0],
         datas[np.where(datas[:, cbm_index] == dot_y[1])[0][0], 0]]
# print(dot_y, dot_x)

# # --------------------- PLOTs ------------------------
axe = plt.subplot(111)
axe.axhline(y=0, xmin=0, xmax=1, linestyle='--', linewidth=0.5, color='0.5')
for i in xtick[1:-1]:
    axe.axvline(x=i, ymin=0, ymax=1, linestyle='--', linewidth=0.5, color='0.5')
colormaps = 'blue'
axe.plot(datas[:, 0], datas[:, 1:], linewidth=1.0, color=colormaps)
axe.plot(dot_x, dot_y, 'o', color='red')
axe.set_ylabel(r'E-E$_\mathrm{f}$ (eV)', fontdict=font)
axe.set_xticks(xtick)
plt.yticks(fontsize=font['size'] - 2, fontname=font['family'])
axe.set_xticklabels(group_labels, rotation=0, fontsize=font['size'] - 2, fontname=font['family'])
axe.set_xlim((xtick[0], xtick[-1]))
plt.ylim((-5, 5))  # set y limits manually
fig = plt.gcf()
fig.set_size_inches(8, 6)
plt.savefig('band.png', dpi=100)
# plt.show()
