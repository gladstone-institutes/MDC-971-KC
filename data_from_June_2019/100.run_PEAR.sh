#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/30.primer_trimmed/*.1.fq.gz
do
	a=$(basename $i)
	/data/home/kchoudha/softwares/pear-src-0.9.11/src/pear -f "$i" \
		-r "${i/.1.fq.gz/.2.fq.gz}" \
		-o "/data/projects/mdc-971/data_from_June_2019/100.merge_all_reads/${a/_cutadapt.1.fq.gz/}" \
		-j 16
done

