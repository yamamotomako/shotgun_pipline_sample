#! /bin/bash
#$ -S /bin/bash
#$ -pe def_slot 2
#$ -l s_vmem=20G,mem_req=20G
#$ -N orf_prediction

CUR_DIR=$1

sample=`cat $CUR_DIR/sample.txt | head -n $SGE_TASK_ID | tail -n 1`

export PATH=${HOME}/miniconda3/envs/prodigal/bin:$PATH

RESULT_DIR=$CUR_DIR/result_orf

${HOME}/miniconda3/envs/prodigal/bin/prodigal \
-a $RESULT_DIR/${sample}.faa \
-d $RESULT_DIR/${sample}.ffn \
-p meta \
-i $CUR_DIR/result_cdhit/${sample}/rep.fa \
-f gbk \
-o $RESULT_DIR/${sample}.gbk

exit
##-i $CUR_DIR/result_virsorter2/${sample}/final-viral-combined.fa \
