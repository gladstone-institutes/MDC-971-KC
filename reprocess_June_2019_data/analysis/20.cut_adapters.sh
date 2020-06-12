#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
#PBS -l ncpus=16
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

inDir=/data/projects/mdc-971/reprocess_June_2019_data/analysis/10.151st_trimmed
outDir=/data/projects/mdc-971/reprocess_June_2019_data/analysis/20.adapter_trimmed

#Function for this script.
func(){
	i="$1"
	f=$(basename "$i")
	f2=${f/_R1_/_R2_}
	/data/applications/2015_06/bin/fastq-mcf -q 10 \
		-o $outDir/${f/.fastq.gz/.trimmed.fastq.gz} \
		-o $outDir/${f2/.fastq.gz/.trimmed.fastq.gz} \
		/data/work/Code/alexgw/monkey_agw/support/adapter_seq_to_trim.fasta \
		$i \
		${i/_R1_/_R2_} > \
		$outDir/${f/.fastq.gz/.fastqmcf_log.txt}
}

for i in $inDir/*R1*
do
	func $i
done

wait
echo "All done"
