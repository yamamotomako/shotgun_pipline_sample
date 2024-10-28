#! /bin/bash
#$ -S /bin/bash
#$ -pe def_slot 2
#$ -l s_vmem=20G,mem_req=20G
#$ -N prinseq

CUR_DIR=$1
sample=`cat $CUR_DIR/sample.txt | head -n $SGE_TASK_ID | tail -n 1`

mkdir -p $CUR_DIR/result_prinseq/${sample}

${HOME}/miniconda3/envs/prinseq/bin/prinseq-lite.pl \
-trim_tail_right 10 \
-trim_tail_left 10 \
-trim_qual_right 20 \
-trim_qual_left 20 \
-trim_qual_window 20 \
-min_len 30 \
-derep 1 \
-lc_method dust \
-lc_threshold 7 \
-trim_ns_right 1 \
-ns_max_n 0 \
-fastq $CUR_DIR/result_cutadapt/${sample}/${sample}_1.cutadapt.fastq \
-fastq2 $CUR_DIR/result_cutadapt/${sample}/${sample}_2.cutadapt.fastq \
-out_good $CUR_DIR/result_prinseq/${sample}/${sample}_good \
-out_bad $CUR_DIR/result_prinseq/${sample}/${sample}_bad \
-graph_data $CUR_DIR/result_prinseq/${sample}/${sample}_graph \
> $CUR_DIR/result_prinseq/${sample}/${sample}.result.txt 2>&1

exit

gzip -f $CUR_DIR/result_prinseq/${sample}/${sample}_good_1.fastq
gzip -f $CUR_DIR/result_prinseq/${sample}/${sample}_good_2.fastq
