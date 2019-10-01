#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

touch summary_bowtie2_primer_anywhere.stats
for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/map_to_HBB/*.unmapped.fq.1.gz
do
	k=$(basename $i)
	j=$(zcat "$i" | wc -l)
	#l=$(zcat "${i/.unmapped.fq.1.gz/.1.align}" | wc -l)
	l=$(zcat "/data/projects/mdc-971/runs/initial_trim_plus_qc/01_adapter-trimmed/${k/.unmapped.fq.1.gz/.1.fq.gz}" | wc -l)
	echo "$k\t$j\t$l\n" >> summary_bowtie2_primer_anywhere.stats
done
