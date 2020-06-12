#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
#PBS -l ncpus=16
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

inDir=/data/projects/mdc-971/data_from_Jan_2020/analysis/30.primer_trimmed
outDir=/data/projects/mdc-971/data_from_Jan_2020/analysis/50.aligned_with_BLAST
dbDir=/data/projects/mdc-971/data_from_Jan_2020/analysis/blast_db

for i in $inDir/*.1.fq.gz
do
	a=$(basename $i)
	gunzip $i
	gunzip ${i/.1./.2.}

	/data/home/kchoudha/softwares/ncbi-magicblast-1.5.0/bin/magicblast -query ${i/.gz/} \
		-query_mate ${i/.1.fq.gz/.2.fq} \
		-infmt fastq \
		-word_size 12 \
		-splice F \
		-limit_lookup F \
		-db $dbDir/HBB_and_L1_targets \
		-num_threads 16 \
		-out $outDir/${a/.1.fq.gz/.sam} \
		-no_unaligned \
		-no_discordant 	
	
	gzip ${i/.gz/}
        gzip ${i/.1.fq.gz/.2.fq}
done

