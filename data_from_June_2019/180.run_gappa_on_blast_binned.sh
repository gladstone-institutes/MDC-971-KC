#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

d=/data/projects/mdc-971/data_from_June_2019
for i in /data/projects/mdc-971/data_from_June_2019/170.epa_blast/epa.split*.jplace
do
	a=$(basename $i)
	/data/home/kchoudha/softwares/gappa-master/bin/gappa analyze assign \
		--jplace-path "$i" \
		--taxon-file "$d/../msa_of_L1_targets_from_Maria/taxonomic_labels.txt" \
		--out-dir "$d/180.gappa_blast/"
	mv "$d/180.gappa_blast/labelled_tree.newick" "$d/180.gappa_blast/$a.labelled_tree.newick"
	mv "$d/180.gappa_blast/per_query.tsv" "$d/180.gappa_blast/$a.per_query.tsv"
	mv "$d/180.gappa_blast/profile.tsv" "$d/180.gappa_blast/$a.profile.tsv"
done

