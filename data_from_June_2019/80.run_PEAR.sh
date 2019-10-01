#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/70.unaligned_reads/*.1.unaligned.fq.gz
do
	a=$(basename $i)
	/data/home/kchoudha/softwares/pear-src-0.9.11/src/pear -f "$i" -r "${i/.1.unaligned.fq.gz/.2.unaligned.fq.gz}" -o "/data/projects/mdc-971/data_from_June_2019/80.merged_unaligned/${a/_cutadapt.1.unaligned.fq.gz/}" -j 16
done

