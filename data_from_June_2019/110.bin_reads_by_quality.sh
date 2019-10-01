#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

#unset PS1
#PS=${PS:-}
set +u
source activate /data/home/kchoudha/miniconda3/envs/kc_env
set -u

for i in /data/projects/mdc-971/data_from_June_2019/100.merge_all_reads/*.assembled.fastq
do
	a=$(basename $i)
	
	bbduk.sh in=$i \
		out=/data/projects/mdc-971/data_from_June_2019/110.bin_reads_by_quality/${a/.fastq/.qual_above_35.fastq} \
		outm=/data/projects/mdc-971/data_from_June_2019/110.bin_reads_by_quality/${a/.fastq/.qual_below_35.fastq} \
		maq=35
	
	bbduk.sh in=/data/projects/mdc-971/data_from_June_2019/110.bin_reads_by_quality/${a/.fastq/.qual_below_35.fastq} \
		out=/data/projects/mdc-971/data_from_June_2019/110.bin_reads_by_quality/${a/.fastq/.qual_bt_30_and_35.fastq} \
		outm=/data/projects/mdc-971/data_from_June_2019/110.bin_reads_by_quality/${a/.fastq/.qual_below_30.fastq} \
                maq=30
done
