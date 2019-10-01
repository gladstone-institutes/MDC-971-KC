#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/130.blast_mapped_unmapped/*.mapped.sam
do
	a=$(basename $i)
	awk -F '\t' '{print $3}' $i | sort | uniq -c | sort -nr > /data/projects/mdc-971/data_from_June_2019/140.mapped_counting/${a/.sam/.cnts}
done
