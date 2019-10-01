#!/bin/bash
#PBS -l walltime=20:00:00
#PBS -l mem=20gb
#PBS -l ncpus=16

dir=/data/projects/mdc-971/data_from_June_2019

bcl2fastq --runfolder-dir "$dir/bcl/190621_NS500835_0126_AHKC7WAFXY/" --sample-sheet "$dir/SampleSheet_paired_07_2019_FR_indices.csv" -p 16 --output-dir "$dir/rawdata5" --no-lane-splitting
