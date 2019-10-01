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

dir=/data/projects/mdc-971/data_from_June_2019/
outdir=185.bin_paired_reads_by_quality

for i in /data/projects/mdc-971/data_from_June_2019/70.unaligned_reads/180335*.1.unaligned.fq.gz
do
	a=$(basename $i)

	bbduk.sh in1=$i \
		in2=${i/.1.unaligned/.2.unaligned} \
		out1=$dir/$outdir/${a/.unaligned/.qual_above_30} \
		out2=$dir/$outdir/${a/.1.unaligned/.2.qual_above_30} \
		maq=10

done
