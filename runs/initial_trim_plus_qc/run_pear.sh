#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=16gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/map_to_HBB/*.unmapped.fq.1.gz
#for i in /data/projects/mdc-971/runs/initial_trim_plus_qc/temp_test/*.1.gz
do
	a=$(basename $i)
	/data/home/kchoudha/softwares/pear-src-0.9.11/src/pear -f "$i" -r "${i/.fq.1.gz/.fq.2.gz}" -o "/data/projects/mdc-971/runs/initial_trim_plus_qc/merged_unmapped/${a/_cutadapt.unmapped.fq.1.gz/}" -j 15
	#/data/home/kchoudha/softwares/pear-src-0.9.11/src/pear -f "$i" -r "${i/.fq.1.gz/.fq.2.gz}" -o "/data/projects/mdc-971/runs/initial_trim_plus_qc/temp_test/pear_test" -j 15
done

