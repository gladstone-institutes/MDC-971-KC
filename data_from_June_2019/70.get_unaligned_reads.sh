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

for i in /data/projects/mdc-971/data_from_June_2019/50.aligned_to_L1_HBB/*.dir
do
	f=$(basename $i)
	samtools view -q 255 "$i/Aligned.out.sam" | cut -f1 | uniq > "$i/uniquely.aligned.read.ids"
	filterbyname.sh in="/data/projects/mdc-971/data_from_June_2019/30.primer_trimmed/${f/.dir/.gz}" \
		in2="/data/projects/mdc-971/data_from_June_2019/30.primer_trimmed/${f/.1.fq.dir/.2.fq.gz}" \
		out="/data/projects/mdc-971/data_from_June_2019/70.unaligned_reads/${f/.fq.dir/.unaligned.fq.gz}" \
		out2="/data/projects/mdc-971/data_from_June_2019/70.unaligned_reads/${f/.1.fq.dir/.2.unaligned.fq.gz}" names="$i/uniquely.aligned.read.ids"
done 
