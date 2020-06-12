#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
#PBS -l ncpus=16
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

#unset PS1
#PS=${PS:-}
set +u
source activate /data/home/kchoudha/miniconda3/envs/kc_env
set -u

dir=/data/projects/mdc-971/data_from_Jan_2020/191223_SF017_MDC-UCSF-NGS3
out=/data/projects/mdc-971/data_from_Jan_2020/analysis/10.151st_trimmed

#Function for this script.
func(){
	i="$1"
	f=$(basename "$i")
	bbduk.sh in1="$i" \
		in2="${i/_R1_/_R2_}" \
		out1="$out/${f/.fastq.gz/.bbduked.fastq.gz}" \
		out2="$out/${f/_R1_001.fastq.gz/_R2_001.bbduked.fastq.gz}" \
		ftm=5 \
		threads=16 \
		ordered=t
}

for i in $dir/*R1*
do
	func $i
done

wait
echo "All done"
