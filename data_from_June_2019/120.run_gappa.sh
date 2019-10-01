#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

d=/data/projects/mdc-971/data_from_June_2019
for i in /data/projects/mdc-971/data_from_June_2019/110.epa_placements/epa.split*.jplace
do
	a=$(basename $i)
	/data/home/kchoudha/softwares/gappa-master/bin/gappa analyze assign \
		--jplace-path "$i" \
		--taxon-file "$d/../msa_of_L1_targets_400nt/taxonomic_labels_for_targeted_HPVs.txt" \
		--out-dir "$d/120.gappa_summary/"
	mv "$d/120.gappa_summary/labelled_tree.newick" "$d/120.gappa_summary/$a.labelled_tree.newick"
	mv "$d/120.gappa_summary/per_query.tsv" "$d/120.gappa_summary/$a.per_query.tsv"
	mv "$d/120.gappa_summary/profile.tsv" "$d/120.gappa_summary/$a.profile.tsv"
done

