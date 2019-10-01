#!/usr/bin/env python

import json
import os
import pandas as pd
import numpy as np

dir = '/data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/epa_results/'
files = os.listdir(dir)
files = [x for x in files if x.endswith('.jplace')] 

for f in files:
	with open(dir + "/" + f, 'r') as json_file:
		dat = json.load(json_file)
		plc = dat['placements']
		for i in range(len(plc)):
			v = pd.DataFrame(plc[i]['p'])
			good_qual = v.loc[(v.loc[:, 2] > 0.9) & (v.loc[:, 3] < 0.1) & (v.loc[:, 4] < 0.1), ]
			if (good_qual.shape[0]):
				good_qual = np.array(good_qual).tolist()
				plc[i] = {'p': good_qual, 'n': plc[i]['n']}
			else:
				plc[i] = None
		plc = [x for x in plc if x!= None]
		dat['placements'] = plc
		with open(dir + 'epa_results_filtered/' + f +'.filtered.jplace', 'w') as outfile:
			json.dump(dat, outfile)
