#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

topDir=/data/projects/mdc-971/reprocess_June_2019_data/analysis
inDir=/data/projects/mdc-971/reprocess_June_2019_data/analysis/40.aligned_with_STAR
outDir=$topDir/45.featureCounts_STAR_mapped

featureCounts -a /data/projects/mdc-971/data_from_Jan_2020/analysis/45.featureCounts_STAR_mapped/reference.saf \
	-o $outDir/counts.txt \
	-F SAF \
	-p \
	-C \
	$inDir/*.dir/Aligned.out.sam

