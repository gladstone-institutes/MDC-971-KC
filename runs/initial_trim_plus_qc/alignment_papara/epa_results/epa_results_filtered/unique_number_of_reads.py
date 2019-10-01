#!/usr/bin/python

import os
import json

dir = '/data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/epa_results/epa_results_filtered/'
files = os.listdir(dir)
files = [x for x in files if x.endswith('jplace')]

with open(dir + 'Number_of_reads.txt', 'w') as outfile:
	for x in files:
		conn = open(dir + x, 'r')
		nreads = len(json.load(conn)['placements'])
		conn.close()
		
		this_id = x.split('_S')[0].split('.')[2]
		outfile.write(this_id + '\t' + str(nreads) + '\n')	
	
