#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/01_adapter-trimmed/*_cutadapt.1.fq.gz
do
	f=$(basename $i)
	out="/data/projects/mdc-971/runs/initial_trim_plus_qc/map_to_HBB/$f"
	#mkfifo "$out.fifo"
	#mkfifo "$out.2.fifo"
	#zcat "$out" > "$out.fifo" &
	#zcat "${out/.1.fq.gz/.2.fq.gz}" > "$out.2.fifo" &
	bowtie2 -p 10 -x /data/projects/mdc-971/bowtie2_index/HBB -1 <( zcat "$i" ) -2 <( zcat "${i/.1.fq.gz/.2.fq.gz}" ) -S "${out/.1.fq.gz/.sam}" --un-conc-gz "${out/.1.fq.gz/.unmapped.fq.gz}" --al-conc-gz "${out/.1.fq.gz/.align.fq.gz}" --met-file "${out/.1.fq.gz/.align.stat}" --no-unal
	#cutadapt -g ACGTTGGATGTTTGTTACTAAGGTAGATACCACTC -g ACGTTGGATGAATATATGTGTGCTTATTTG -g ACGTTGGATGTTTGTTACTGTGGTGGATACTAC -g ACGTTGGATGTTTGTTACTGTTGTGGATACAAC -g ACGTTGGATGTTTGTTACCGTTGTTGATACTAC -g ACGTTGGATGTTTGTTACTATGGTAGATACCACAC -G ACGTTGGATGGAAAAATAAATTGTAAATCATACTC -G ACGTTGGATGGAAAAATAAACTGTAAATCATATTC -G ACGTTGGATGAGATTAGGGAAAGTATTAGA -G ACGTTGGATGGAAAAATAAACTGTAAATCATATTCCT -G ACGTTGGATGGAAAAATAAACTGCAAATCATATTC -G ACGTTGGATGGAAAAATAAATTGTAAATCAAATTC -o "${i/_R1_001_val_1.fq.gz/_cutadapt.1.fq.gz}" -p "${i/_R1_001_val_1.fq.gz/_cutadapt.2.fq.gz}" "$i" "${i/_R1_001_val_1.fq.gz/_R2_001_val_2.fq.gz}" > "${i/_R1_001_val_1.fq.gz/.log}"
done
