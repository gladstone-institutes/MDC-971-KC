#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/merged_unmapped/fasta/*.fa
do
	a=$(basename $i)
	/data/home/kchoudha/softwares/papara_nt-master/papara_nt-2.5/papara -t /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/RAxML_bestTree.hpv_ref_tree.tre -s /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/final_aligned_L1_hpv.phy -q "$i" -r -n "$a" -j 15
done

