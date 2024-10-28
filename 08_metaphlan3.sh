#! /bin/bash
#$ -S /bin/bash
#$ -l a100=2,s_vmem=32G
#$ -pe def_slot 4
#$ -N mpa3

CUR_DIR=$1
sample=`cat $CUR_DIR/sample.txt | head -n $SGE_TASK_ID | tail -n 1`

export PATH=${HOME}/miniconda3/envs/mpa3/bin:$PATH:${HOME}/miniconda3/envs/bowtie2/bin



${HOME}/miniconda3/envs/mpa3/bin/metaphlan \
$CUR_DIR/result_spades/${sample}/corrected/${sample}_good_1.00.0_0.cor.fastq.gz,$CUR_DIR/result_spades/${sample}/corrected/${sample}_good_2.00.0_0.cor.fastq.gz \
--bowtie2db ${your_db_path} \
--bowtie2out $CUR_DIR/result_mpa3/${sample}.bowtie2.bz2 \
--nproc 4 \
--input_type fastq \
> $CUR_DIR/result_mpa3/${sample}.txt

exit


