#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/epa.split*.fa
do
	a=$(basename $i)
	epa-ng --tree /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/RAxML_bestTree.hpv_ref_tree.tre --ref-msa /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/final_aligned_L1_hpv.fa --query "$i" --out-dir /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/epa_results/ --model /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/RAxML_info.hpv_ref_tree
	mv /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/epa_results/epa_info.log "/data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/epa_results/$a.log"
        mv /data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/epa_results/epa_result.jplace "/data/projects/mdc-971/runs/initial_trim_plus_qc/alignment_papara/epa_results/$a.jplace" 
done

