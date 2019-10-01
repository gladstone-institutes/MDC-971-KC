#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/papara_alignment*.fa
do
	epa-ng --split /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/final_aligned_L1_hpv.phy "$i"
	mv /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/query.fasta "${i/papara_alignment/epa.split}" 
done

