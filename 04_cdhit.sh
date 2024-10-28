#! /bin/bash
#$ -S /bin/bash
#$ -l lmem
#$ -l s_vmem=480G,mem_req=480G
#$ -N cdhit

CUR_DIR=${HOME}

sample=`cat $CUR_DIR/sample.txt | head -n $SGE_TASK_ID | tail -n 1`

mkdir -p $CUR_DIR/result_cdhit/${sample}

${HOME}/miniconda3/envs/cdhit/cdhit/cd-hit-est \
-c 0.95 \
-G 1 \
-mask NX \
-d 150 \
-n 10 \
-T 6 \
-M 480000000 \
-i $CUR_DIR/result_spades/${sample}/contigs.fasta \
-o $CUR_DIR/result_cdhit/${sample}/rep.fa


