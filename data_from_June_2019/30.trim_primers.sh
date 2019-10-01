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

dir=/data/projects/mdc-971/data_from_June_2019

for i in $dir/20.trim_151st_nt/*_R1_001.bbduked.fastq.gz
do
	f=$(basename $i)
	cutadapt -g ACGTTGGATGTTTGTTACTATGGTAGATACCACAC -g ACGTTGGATGTTTGTTACTAAGGTAGATACCACTC -g ACGTTGGATGTTTGTTACTGTGGTGGATACTAC -g ACGTTGGATGTTTGTTACTGTTGTGGATACAAC -g ACGTTGGATGTTTGTTACCGTTGTTGATACTAC -g ACGTTGGATGAATATATGTGTGCTTATTTG -G ACGTTGGATGTTTGTTACTATGGTAGATACCACAC -G ACGTTGGATGTTTGTTACTGTGGTGGATACTAC -G ACGTTGGATGTTTGTTACTGTTGTGGATACAAC -G ACGTTGGATGTTTGTTACCGTTGTTGATACTAC -G ACGTTGGATGAATATATGTGTGCTTATTTG -G ACGTTGGATGTTTGTTACTAAGGTAGATACCACTC -g ACGTTGGATGGAAAAATAAACTGCAAATCATATTC -g ACGTTGGATGGAAAAATAAACTGTAAATCATATTC -g ACGTTGGATGGAAAAATAAATTGTAAATCATACTC -g ACGTTGGATGAGATTAGGGAAAGTATTAGA -g ACGTTGGATGGAAAAATAAATTGTAAATCAAATTC -g ACGTTGGATGGAAAAATAAACTGTAAATCATATTCCT -G ACGTTGGATGGAAAAATAAACTGCAAATCATATTC -G ACGTTGGATGAGATTAGGGAAAGTATTAGA -G ACGTTGGATGGAAAAATAAATTGTAAATCATACTC -G ACGTTGGATGGAAAAATAAACTGTAAATCATATTCCT -G ACGTTGGATGGAAAAATAAACTGTAAATCATATTC -G ACGTTGGATGGAAAAATAAATTGTAAATCAAATTC \
		--minimum-length=1 -o "$dir/30.primer_trimmed/${f/_R1_001.bbduked.fastq.gz/_cutadapt.1.fq.gz}" \
		-p "$dir/30.primer_trimmed/${f/_R1_001.bbduked.fastq.gz/_cutadapt.2.fq.gz}" "$i" "${i/_R1_001.bbduked.fastq.gz/_R2_001.bbduked.fastq.gz}" > "$dir/30.primer_trimmed/${f/_R1_001.bbduked.fastq.gz/.primers_anywhere.log}"
done