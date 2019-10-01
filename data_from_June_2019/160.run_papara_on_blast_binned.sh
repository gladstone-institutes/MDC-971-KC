#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/150.fasta_binned/*.fasta
do
	a=$(basename $i)
	/data/home/kchoudha/softwares/papara_nt-master/papara_nt-2.5/papara -t /data/projects/mdc-971/msa_of_L1_targets_from_Maria/RAxML_bestTree.hpv_ref_tree \
		-s /data/projects/mdc-971/msa_of_L1_targets_from_Maria/Target_seqs_from_Maria.aligned.phy \
		-q "$i" \
		-r -n "$a" \
		-j 16
done

