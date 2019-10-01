#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

d=/data/projects/mdc-971/data_from_June_2019

for i in /data/projects/mdc-971/data_from_June_2019/160.papara_blast/papara_alignment*.fasta
do
	echo "$i"
	f=$(basename $i)
	epa-ng --split /data/projects/mdc-971/msa_of_L1_targets_from_Maria/Target_seqs_from_Maria.aligned.phy "$i"
	mv ~/query.fasta "$d/170.epa_blast/${f/papara_alignment/epa.split}"
	epa-ng --tree /data/projects/mdc-971/msa_of_L1_targets_from_Maria/RAxML_bestTree.hpv_ref_tree \
		--ref-msa /data/projects/mdc-971/msa_of_L1_targets_from_Maria/Target_seqs_from_Maria.aligned.fa \
		--query "$d/170.epa_blast/${f/papara_alignment/epa.split}" \
		--out-dir "$d/170.epa_blast/" \
		--model /data/projects/mdc-971/msa_of_L1_targets_from_Maria/RAxML_info.hpv_ref_tree 
	mv "$d/170.epa_blast/epa_info.log" "$d/170.epa_blast/${f/papara_alignment/epa.split}.log"
	mv "$d/170.epa_blast/epa_result.jplace" "$d/170.epa_blast/${f/papara_alignment/epa.split}.jplace"
done

