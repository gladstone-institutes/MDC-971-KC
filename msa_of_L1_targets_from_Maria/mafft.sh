#!/bin/bash
#PBS -l walltime=55:00:00
#PBS -l mem=60gb
set -e           # <-- abort if ANY command returns non-zero value
set -u           # <-- abort on undefined variables
set -o pipefail  # <-- show failed exit codes properly

#unset PS1
#PS=${PS:-}
set +u
source activate /data/home/kchoudha/miniconda3/envs/kc_env
set -u

mafft-linsi --thread 16 /data/projects/mdc-971/msa_of_L1_targets_from_Maria/Target_seqs_from_Maria.fa > /data/projects/mdc-971/msa_of_L1_targets_from_Maria/Target_seqs_from_Maria.aligned.fa


