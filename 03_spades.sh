#! /bin/bash
#$ -S /bin/bash
#$ -l a100=2,s_vmem=32G
#$ -pe def_slot 8
#$ -N spades

CUR_DIR=$1
sample=`cat $CUR_DIR/sample.txt | head -n $SGE_TASK_ID | tail -n 1`

export PATH=${HOME}/miniconda3/envs/spades_3.13/bin:${HOME}/miniconda3/envs/fastqc/bin:$PATH

mkdir -p $CUR_DIR/result_spades/${sample}

${HOME}/miniconda3/envs/spades_3.13/bin/spades.py \
--only-error-correction \
--pe1-1 $CUR_DIR/result_prinseq/${sample}/${sample}_good_1.fastq \
--pe1-2 $CUR_DIR/result_prinseq/${sample}/${sample}_good_2.fastq \
--memory 240 \
--threads 8 \
-o $CUR_DIR/result_spades/${sample}


gunzip -c $CUR_DIR/result_spades/${sample}/corrected/${sample}_good_1.00.0_0.cor.fastq.gz > $CUR_DIR/result_spades/${sample}/corrected/${sample}_good_1.00.0_0.cor.fastq
gunzip -c $CUR_DIR/result_spades/${sample}/corrected/${sample}_good_2.00.0_0.cor.fastq.gz > $CUR_DIR/result_spades/${sample}/corrected/${sample}_good_2.00.0_0.cor.fastq


${HOME}/miniconda3/envs/spades_3.13/bin/spades.py \
--only-assembler \
--pe1-1 $CUR_DIR/result_spades/${sample}/corrected/${sample}_good_1.00.0_0.cor.fastq.gz \
--pe1-2 $CUR_DIR/result_spades/${sample}/corrected/${sample}_good_2.00.0_0.cor.fastq.gz \
--memory 240 \
--threads 8 \
-o $CUR_DIR/result_spades/${sample}




