#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=60gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

/data/home/kchoudha/softwares/standard-RAxML-master/raxmlHPC-SSE3 -f a -x 12345 -p 12345 -# 100 -m GTRGAMMA -s /data/projects/mdc-971/msa_of_L1_targets_from_Maria/Target_seqs_from_Maria.aligned.fa -n hpv_ref_tree

