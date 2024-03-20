# -*- coding:utf-8 -*-
import sys

vbm_index, cbm_index, material_title, gap_e = int(sys.argv[1]), int(sys.argv[2]), str(sys.argv[3]), str(sys.argv[4])
# vbm_index, cbm_index = 13, 14
material_title_dic = {"MoSTeZrBrCl": "MoSTe/ZrBrCl"}
if material_title in material_title_dic.keys():
    material_title = material_title_dic[material_title]

import warnings
warnings.filterwarnings("ignore")

import numpy as np
import matplotlib as mpl
mpl.use('Agg')  # silent mode
from matplotlib.gridspec import GridSpec
from matplotlib import pyplot as plt

# ------------------- Dos Read ----------------------
from pymatgen.io.vasp.outputs import Vasprun
from pymatgen.electronic_structure.core import Spin
from pymatgen.core import Element

dos_vasprun = Vasprun("./vasprun.xml")
dos_data = dos_vasprun.complete_dos
dos_energies = [e - dos_data.efermi for e in dos_data.energies]
elements = [e.symbol for e in dos_data.structure.composition.elements]

# ------------------ FONT_setup ----------------------
font = {'family': 'Times New Roman',
        'color': 'black',
        'weight': 'normal',
        'size': 20.0,
        }
font_text = {'family': 'Times New Roman',
             'color': 'brown',
             'weight': 'normal',
             'size': 20.0,
             }
fonte = {'family': 'Times New Roman',
         'color': 'black',
         'weight': 'bold',
         'size': 25.0,
         }
# ------------------- Band Read ----------------------
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

dot_y = [max(datas[:, vbm_index]), min(datas[:, cbm_index])]
if len(np.where(datas[:, vbm_index] == dot_y[0])[0]) == 2 and len(np.where(datas[:, cbm_index] == dot_y[1])[0]) == 2:
    tmp_dot_x = [datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][0], 0],
                 datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][1], 0],
                 datas[np.where(datas[:, cbm_index] == dot_y[1])[0][0], 0],
                 datas[np.where(datas[:, cbm_index] == dot_y[1])[0][1], 0]]
elif len(np.where(datas[:, vbm_index] == dot_y[0])[0]) == 2 and len(np.where(datas[:, cbm_index] == dot_y[1])[0]) == 1:
    tmp_dot_x = [datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][0], 0],
                 datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][1], 0],
                 datas[np.where(datas[:, cbm_index] == dot_y[1])[0][0], 0],
                 datas[np.where(datas[:, cbm_index] == dot_y[1])[0][0], 0]]
elif len(np.where(datas[:, vbm_index] == dot_y[0])[0]) == 1 and len(np.where(datas[:, cbm_index] == dot_y[1])[0]) == 2:
    tmp_dot_x = [datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][0], 0],
                 datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][0], 0],
                 datas[np.where(datas[:, cbm_index] == dot_y[1])[0][0], 0],
                 datas[np.where(datas[:, cbm_index] == dot_y[1])[0][1], 0]]
else:
    tmp_dot_x = [datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][0], 0],
                 datas[(np.where(datas[:, vbm_index] == dot_y[0]))[0][0], 0],
                 datas[np.where(datas[:, cbm_index] == dot_y[1])[0][0], 0],
                 datas[np.where(datas[:, cbm_index] == dot_y[1])[0][0], 0]]
dist_ = [abs(tmp_dot_x[0] - tmp_dot_x[2]), abs(tmp_dot_x[1] - tmp_dot_x[2]),
         abs(tmp_dot_x[0] - tmp_dot_x[3]), abs(tmp_dot_x[1] - tmp_dot_x[3])]
min_dist = dist_.index(min(dist_))
if min_dist == 0:
    dot_x = [tmp_dot_x[0], tmp_dot_x[2]]
elif min_dist == 1:
    dot_x = [tmp_dot_x[1], tmp_dot_x[2]]
elif min_dist == 2:
    dot_x = [tmp_dot_x[0], tmp_dot_x[3]]
else:
    dot_x = [tmp_dot_x[1], tmp_dot_x[3]]
# print(dot_y, dot_x)

# # --------------------- PLOTs ------------------------
fig_size = (9, 8.5)
emin = -1.5
emax = 1.5

gs = GridSpec(1, 2, width_ratios=[2, 1])
bs_ax, dos_ax = plt.subplot(gs[0]), plt.subplot(gs[1])

# ------------------- Band plot ----------------------
bs_ax.axhline(y=0, xmin=0, xmax=1, linestyle='--', linewidth=1, color='0.25')
for i in xtick[1:-1]:
    bs_ax.axvline(x=i, ymin=0, ymax=1, linestyle='--', linewidth=1, color='0.25')
bs_ax.plot(datas[:, 0], datas[:, 1:], linewidth=1.3, color='black')
#bs_ax.quiver(dot_x[0], dot_y[0], dot_x[1] - dot_x[0], dot_y[1] - dot_y[0],
#             angles='xy', scale=1, scale_units='xy', color=font_text['color'])
bs_ax.set_xticks(xtick)
bs_ax.set_xlim((xtick[0], xtick[-1]))
bs_ax.set_xticklabels(group_labels, rotation=0, fontdict=font)
bs_ax.set_ylim((emin, emax))  # set y limits manually
# bs_ax.set_yticks(np.arange(emin, emax + 1e-5, 1))
bs_ax.tick_params(direction='in')
bs_ax.set_ylabel(r'E-E$_\mathrm{f}$ (eV)', fontdict=fonte)
bs_ax.set_yticklabels(np.arange(emin, emax+1e-8, 0.5), fontdict=font)



# bs_ax.yaxis.set_ticklabels([])
"""
if abs(dot_x[1] - dot_x[0]) <= 0.001:
    bs_ax.text((dot_x[1] + dot_x[0]) / 2 - (dot_x[1] - dot_x[0]) / 2,
               (dot_y[1] + dot_y[0]) / 2,
               gap_e + " eV", fontdict=font_text)
elif dot_x[1] > dot_x[0]:
    bs_ax.text((dot_x[1] + dot_x[0]) / 2 + (dot_x[1] - dot_x[0]) / 10,
               (dot_y[1] + dot_y[0]) / 2 - (dot_y[1] - dot_y[0]) / 10,
               gap_e + " eV", fontdict=font_text)
else:
    bs_ax.text(dot_x[1] - (dot_x[0] - dot_x[1]) / 2,
               (dot_y[1] + dot_y[0]) / 2 - (dot_y[1] - dot_y[0]) / 6,
               gap_e + " eV", fontdict=font_text)
"""
# ------------------- Dos plot ----------------------
dos_ax.set_ylim((emin, emax))
dos_ax.set_yticklabels([])
dos_ax.set_yticks(np.arange(emin, emax + 1e-5, 1))
dos_ax.grid(color=[0.75, 0.75, 0.75], linestyle="--", linewidth=1)
for spin in (Spin.up, Spin.down):
    if spin in dos_data.densities:
        # plot the total DOS
        dos_densities = dos_data.densities[spin] * int(spin)
        label = "total" if spin == Spin.up else None
        dos_ax.plot(dos_densities, dos_energies, color=(0.6, 0.6, 0.6), label=label)
        dos_ax.fill_betweenx(
            dos_energies,
            0,
            dos_densities,
            color=(0.7, 0.7, 0.7),
            facecolor=(0.7, 0.7, 0.7),
        )

        colors = ["b", "r", "g", "m", "y", "c", "k", "w"]
        el_dos = dos_data.get_element_dos()
        for idx, el in enumerate(elements):
            dos_densities = el_dos[Element(el)].densities[spin] * int(spin)
            label = el if spin == Spin.up else None
            dos_ax.plot(
                dos_densities,
                dos_energies,
                color=colors[idx],
                label=label,
            )

# get index of lowest and highest energy being plotted, used to help auto-scale DOS x-axis
emin_idx = next(x[0] for x in enumerate(dos_energies) if x[1] >= emin)
emax_idx = len(dos_energies) - next(x[0] for x in enumerate(reversed(dos_energies)) if x[1] <= emax)

# determine DOS x-axis range
dos_xmin = (
    0 if Spin.down not in dos_data.densities else -max(dos_data.densities[Spin.down][emin_idx: emax_idx + 1] * 1.05)
)
dos_xmax = max([max(dos_data.densities[Spin.up][emin_idx:emax_idx]) * 1.05, abs(dos_xmin)])

# set up the DOS x-axis and add Fermi level line
dos_ax.set_xlim(dos_xmin, dos_xmax)
dos_ax.set_xticklabels([])
dos_ax.hlines(y=0, xmin=dos_xmin, xmax=dos_xmax, linestyle='--', linewidth=1, color='0.25')
dos_ax.set_xlabel("DOS", fontdict=font)
# add legend for DOS
dos_ax.legend(fancybox=True, prop={"size": 14, "family": font['family']}, loc="best")

plt.subplots_adjust(wspace=0.1)
plt.suptitle(material_title+'\n'+'HSE06', family=font['family'], fontsize=25)
fig = plt.gcf()
fig.set_size_inches(fig_size)
plt.savefig('bandos.png', bbox_inches='tight', dpi=100)

