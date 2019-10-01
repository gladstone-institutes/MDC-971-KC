#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/120.blast_reads/*.sam
do
	a=$(basename $i)
	
	samtools view -F 4 $i > /data/projects/mdc-971/data_from_June_2019/130.blast_mapped_unmapped/${a/.sam/.mapped.sam}
	samtools view -f 4 $i > /data/projects/mdc-971/data_from_June_2019/130.blast_mapped_unmapped/${a/.sam/.unmapped.sam}
done
