#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/110.bin_reads_by_quality/*.fastq
do
	a=$(basename $i)

	/data/home/kchoudha/softwares/ncbi-magicblast-1.5.0/bin/magicblast -query $i \
		-infmt fastq \
		-word_size 12 \
		-splice F \
		-limit_lookup F \
		-db /data/home/kchoudha/softwares/ncbi-magicblast-1.5.0/bin/HPV_target_seqs_from_Maria \
		-num_threads 16 \
		-out /data/projects/mdc-971/data_from_June_2019/120.blast_reads/${a/.fastq/.word_size_12.sam} 	
done

