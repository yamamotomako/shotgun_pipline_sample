#! /bin/bash
#$ -S /bin/bash
#$ -pe def_slot 2
#$ -l s_vmem=20G,mem_req=20G
#$ -N cutadapt

CUR_DIR=$1
sample=`cat $CUR_DIR/sample.txt | head -n $SGE_TASK_ID | tail -n 1`

adapter_fwd="AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"
adapter_rvs="AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"

mkdir -p $CUR_DIR/result_cutadapt/${sample}

gunzip -c $CUR_DIR/data/${sample}_L001_R1_001.fastq.gz > $CUR_DIR/result_cutadapt/${sample}/${sample}_1.fastq
gunzip -c $CUR_DIR/data/${sample}_L001_R2_001.fastq.gz > $CUR_DIR/result_cutadapt/${sample}/${sample}_2.fastq

${HOME}/miniconda3/envs/cutadapt/bin/cutadapt --minimum-length 50 -a ${adapter_fwd} $CUR_DIR/result_cutadapt/${sample}/${sample}_1.fastq > $CUR_DIR/result_cutadapt/${sample}/${sample}_1.cutadapt.fastq

${HOME}/miniconda3/envs/cutadapt/bin/cutadapt --minimum-length 50 -a ${adapter_fwd} $CUR_DIR/result_cutadapt/${sample}/${sample}_2.fastq > $CUR_DIR/result_cutadapt/${sample}/${sample}_2.cutadapt.fastq


