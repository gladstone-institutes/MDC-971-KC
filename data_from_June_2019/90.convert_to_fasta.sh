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

dir=/data/projects/mdc-971/data_from_June_2019

#Function for this script.
func(){
	i="$1"
	f=$(basename "$i")
	reformat.sh in="$i" out="/data/projects/mdc-971/data_from_June_2019/90.merged_unaligned_fasta/${f/.assembled.fastq/.fasta}"
}

for i in /data/projects/mdc-971/data_from_June_2019/80.merged_unaligned/*assembled.fastq
do
	func $i
done

wait
echo "All done"
