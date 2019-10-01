#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/01_adapter-trimmed/*_cutadapt.1.fq.gz
do
	f=$(basename $i)
	dir="/data/projects/mdc-971/runs/initial_trim_plus_qc/map_to_all_L1_and_HBB/${f%.*}.dir/"
	mkdir "$dir"
	/data/applications/2015_06/bin/STAR --runThreadN 16 --genomeDir /data/projects/mdc-971/runs/initial_trim_plus_qc/map_to_all_L1_and_HBB/star_index/ --readFilesIn "$i" "${i/.1.fq.gz/.2.fq.gz}" --readFilesCommand zcat --outFileNamePrefix "$dir" --chimSegmentMin 10 --outFilterMismatchNmax 4
done
