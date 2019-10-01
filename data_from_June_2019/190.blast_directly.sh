#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/data_from_June_2019/70.unaligned_reads/*.1.unaligned.fq.gz
do
	a=$(basename $i)
	gunzip $i
	gunzip ${i/.1./.2.}

	/data/home/kchoudha/softwares/ncbi-magicblast-1.5.0/bin/magicblast -query ${i/.gz/} \
		-query_mate ${i/.1.unaligned.fq.gz/.2.unaligned.fq} \
		-infmt fastq \
		-word_size 12 \
		-splice F \
		-limit_lookup F \
		-db /data/home/kchoudha/softwares/ncbi-magicblast-1.5.0/bin/HPV_target_seqs_from_Maria \
		-num_threads 16 \
		-out /data/projects/mdc-971/data_from_June_2019/190.blast_directly/${a/.1.unaligned.fq.gz/.sam} \
		-no_unaligned \
		-no_discordant 	
	
	gzip ${i/.gz/}
        gzip ${i/.1.unaligned.fq.gz/.2.unaligned.fq}
done

