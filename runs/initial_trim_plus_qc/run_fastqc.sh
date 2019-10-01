#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/map_to_HBB/*align.fq*
do
    #fastqc "$i/Aligned.out.sam"
    j=$(basename $i)
    #j=$(echo $j| cut -d '_' -f 1)
    #echo "$j"
    #cp "$i/Deduped.out.sam" "$i/$j.sam"
    fastqc -t 15 -o "/data/projects/mdc-971/runs/initial_trim_plus_qc/map_to_HBB/fastqc_mapped_only" "$i"
done
