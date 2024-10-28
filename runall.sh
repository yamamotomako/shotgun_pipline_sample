#! /bin/bash

CUR_DIR=${HOME}/

NUM=`cat $CUR_DIR/sample.txt | wc -l`

LOG_DIR=$CUR_DIR/log

#make result directory
mkdir -p $CUR_DIR/result_cutadapt
mkdir -p $CUR_DIR/result_prinseq
mkdir -p $CUR_DIR/result_fastqc
mkdir -p $CUR_DIR/result_spades
mkdir -p $CUR_DIR/result_cdhit
mkdir -p $CUR_DIR/result_orf
mkdir -p $CUR_DIR/result_mpa3

mkdir -p $LOG_DIR

#01 trim adapter sequence
qsub -t 1-${NUM} -o $LOG_DIR -e $LOG_DIR $CUR_DIR/01_cutadapt.sh $CUR_DIR

#02 trim both ends and get high/low quarity ratio
qsub -t 1-${NUM} -hold_jid cutadapt -o $LOG_DIR -e $LOG_DIR $CUR_DIR/02_prinseq.sh $CUR_DIR

#02 get quality report
qsub -t 1-${NUM} -hold_jid prinseq -o $LOG_DIR -e $LOG_DIR $CUR_DIR/02_fastqc.sh $CUR_DIR

#03 correct error reads & assembly
qsub -t 1-${NUM} -hold_jid prinseq -o $LOG_DIR -e $LOG_DIR $CUR_DIR/03_spades.sh $CUR_DIR

#04 (optional) clusterling
qsub -t 1-${NUM} -hold_jid spades -o $LOG_DIR -e $LOG_DIR $CUR_DIR/04_cdhit.sh $CUR_DIR

#08 relative abundance
qsub -t 1-${NUM} -hold_jid prinseq -o $LOG_DIR -e $LOG_DIR $CUR_DIR/08_metaphlan3.sh $CUR_DIR

#orf prediction from (03 or 04 or after virsorter)
qsub -t 1-${NUM} -hold_jid cdhit -o $LOG_DIR -e $LOG_DIR $CUR_DIR/12_orf_prediction.sh $CUR_DIR

exit
