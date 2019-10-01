#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/130.blast_mapped_unmapped/*.sam
do
	a=$(basename $i)
	awk '{print ">", $1, "\n", $10}' $i | sed 's/ //g' > /data/projects/mdc-971/data_from_June_2019/150.fasta_binned/${a/.sam/.fasta}
done
