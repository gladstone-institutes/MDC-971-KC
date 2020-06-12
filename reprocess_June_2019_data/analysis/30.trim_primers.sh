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

inDir=/data/projects/mdc-971/reprocess_June_2019_data/analysis/20.adapter_trimmed
outDir=/data/projects/mdc-971/reprocess_June_2019_data/analysis/30.primer_trimmed

for i in $inDir/*_R1_001.bbduked.trimmed.fastq.gz
do
	f=$(basename $i)
	cutadapt -g ACGTTGGATGTTTGTTACTATGGTAGATACCACAC \
		-g ACGTTGGATGTTTGTTACTAAGGTAGATACCACTC \
		-g ACGTTGGATGTTTGTTACTGTGGTGGATACTAC \
		-g ACGTTGGATGTTTGTTACTGTTGTGGATACAAC \
		-g ACGTTGGATGTTTGTTACCGTTGTTGATACTAC \
		-g ACGTTGGATGAATATATGTGTGCTTATTTG \
		-G ACGTTGGATGTTTGTTACTATGGTAGATACCACAC \
		-G ACGTTGGATGTTTGTTACTGTGGTGGATACTAC \
		-G ACGTTGGATGTTTGTTACTGTTGTGGATACAAC \
		-G ACGTTGGATGTTTGTTACCGTTGTTGATACTAC \
		-G ACGTTGGATGAATATATGTGTGCTTATTTG \
		-G ACGTTGGATGTTTGTTACTAAGGTAGATACCACTC \
		-g ACGTTGGATGGAAAAATAAACTGCAAATCATATTC \
		-g ACGTTGGATGGAAAAATAAACTGTAAATCATATTC \
		-g ACGTTGGATGGAAAAATAAATTGTAAATCATACTC \
		-g ACGTTGGATGAGATTAGGGAAAGTATTAGA \
		-g ACGTTGGATGGAAAAATAAATTGTAAATCAAATTC \
		-g ACGTTGGATGGAAAAATAAACTGTAAATCATATTCCT \
		-G ACGTTGGATGGAAAAATAAACTGCAAATCATATTC \
		-G ACGTTGGATGAGATTAGGGAAAGTATTAGA \
		-G ACGTTGGATGGAAAAATAAATTGTAAATCATACTC \
		-G ACGTTGGATGGAAAAATAAACTGTAAATCATATTCCT \
		-G ACGTTGGATGGAAAAATAAACTGTAAATCATATTC \
		-G ACGTTGGATGGAAAAATAAATTGTAAATCAAATTC \
		--minimum-length=1 \
		-o "$outDir/${f/_R1_001.bbduked.trimmed.fastq.gz/_cutadapt.1.fq.gz}" \
		-p "$outDir/${f/_R1_001.bbduked.trimmed.fastq.gz/_cutadapt.2.fq.gz}" \
		"$i" "${i/_R1_001/_R2_001}" > \
		"$outDir/${f/_R1_001.bbduked.trimmed.fastq.gz/.primers_anywhere.log}"
done
