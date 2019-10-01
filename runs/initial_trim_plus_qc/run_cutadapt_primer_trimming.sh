#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/01_adapter-trimmed/*_R1_001_val_1.fq.gz
do
	#cutadapt -g ACGTTGGATGTTTGTTACTAAGGTAGATACCACTC -g ACGTTGGATGAATATATGTGTGCTTATTTG -g ACGTTGGATGTTTGTTACTGTGGTGGATACTAC -g ACGTTGGATGTTTGTTACTGTTGTGGATACAAC -g ACGTTGGATGTTTGTTACCGTTGTTGATACTAC -g ACGTTGGATGTTTGTTACTATGGTAGATACCACAC -G ACGTTGGATGGAAAAATAAATTGTAAATCATACTC -G ACGTTGGATGGAAAAATAAACTGTAAATCATATTC -G ACGTTGGATGAGATTAGGGAAAGTATTAGA -G ACGTTGGATGGAAAAATAAACTGTAAATCATATTCCT -G ACGTTGGATGGAAAAATAAACTGCAAATCATATTC -G ACGTTGGATGGAAAAATAAATTGTAAATCAAATTC -o "${i/_R1_001_val_1.fq.gz/_cutadapt.1.fq.gz}" -p "${i/_R1_001_val_1.fq.gz/_cutadapt.2.fq.gz}" "$i" "${i/_R1_001_val_1.fq.gz/_R2_001_val_2.fq.gz}" > "${i/_R1_001_val_1.fq.gz/.log}"
	cutadapt -g ACGTTGGATGTTTGTTACTATGGTAGATACCACAC -g ACGTTGGATGTTTGTTACTAAGGTAGATACCACTC -g ACGTTGGATGTTTGTTACTGTGGTGGATACTAC -g ACGTTGGATGTTTGTTACTGTTGTGGATACAAC -g ACGTTGGATGTTTGTTACCGTTGTTGATACTAC -g ACGTTGGATGAATATATGTGTGCTTATTTG -G ACGTTGGATGTTTGTTACTATGGTAGATACCACAC -G ACGTTGGATGTTTGTTACTGTGGTGGATACTAC -G ACGTTGGATGTTTGTTACTGTTGTGGATACAAC -G ACGTTGGATGTTTGTTACCGTTGTTGATACTAC -G ACGTTGGATGAATATATGTGTGCTTATTTG -G ACGTTGGATGTTTGTTACTAAGGTAGATACCACTC -g ACGTTGGATGGAAAAATAAACTGCAAATCATATTC -g ACGTTGGATGGAAAAATAAACTGTAAATCATATTC -g ACGTTGGATGGAAAAATAAATTGTAAATCATACTC -g ACGTTGGATGAGATTAGGGAAAGTATTAGA -g ACGTTGGATGGAAAAATAAATTGTAAATCAAATTC -g ACGTTGGATGGAAAAATAAACTGTAAATCATATTCCT -G ACGTTGGATGGAAAAATAAACTGCAAATCATATTC -G ACGTTGGATGAGATTAGGGAAAGTATTAGA -G ACGTTGGATGGAAAAATAAATTGTAAATCATACTC -G ACGTTGGATGGAAAAATAAACTGTAAATCATATTCCT -G ACGTTGGATGGAAAAATAAACTGTAAATCATATTC -G ACGTTGGATGGAAAAATAAATTGTAAATCAAATTC --minimum-length=1 -o "${i/_R1_001_val_1.fq.gz/_cutadapt.1.fq.gz}" -p "${i/_R1_001_val_1.fq.gz/_cutadapt.2.fq.gz}" "$i" "${i/_R1_001_val_1.fq.gz/_R2_001_val_2.fq.gz}" > "${i/_R1_001_val_1.fq.gz/.primers_anywhere.log}"
done
