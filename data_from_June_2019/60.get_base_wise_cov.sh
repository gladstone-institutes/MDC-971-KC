#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/50.aligned_to_L1_HBB/*.dir
do
	samtools sort "$i/Aligned.out.sam" -o "$i/Aligned.out.sorted.bam"
	bedtools genomecov -ibam "$i/Aligned.out.sorted.bam" -g /data/projects/mdc-971/runs/initial_trim_plus_qc/map_to_all_L1_and_HBB/gene_lengths.txt -d -pc | awk '$3 > 0' > "$i/Base-wise-summary.txt"
done 
