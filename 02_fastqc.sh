#! /bin/bash
#$ -S /bin/bash
#$ -pe def_slot 2
#$ -l s_vmem=20G,mem_req=20G
#$ -N fastqc

CUR_DIR=$1
sample=`cat $CUR_DIR/sample.txt | head -n $SGE_TASK_ID | tail -n 1`

mkdir -p $CUR_DIR/result_fastqc/${sample}

#raw data
${HOME}/miniconda3/envs/fastqc/bin/fastqc \
-o $CUR_DIR/result_fastqc/${sample} \
$CUR_DIR/result_cutadapt/${sample}/${sample}_1.fastq

${HOME}/miniconda3/envs/fastqc/bin/fastqc \
-o $CUR_DIR/result_fastqc/${sample} \
$CUR_DIR/result_cutadapt/${sample}/${sample}_2.fastq


#after cutadapt
${HOME}/miniconda3/envs/fastqc/bin/fastqc \
-o $CUR_DIR/result_fastqc/${sample} \
$CUR_DIR/result_cutadapt/${sample}/${sample}_1.cutadapt.fastq

${HOME}/miniconda3/envs/fastqc/bin/fastqc \
-o $CUR_DIR/result_fastqc/${sample} \
$CUR_DIR/result_cutadapt/${sample}/${sample}_2.cutadapt.fastq


#after prinseq
#good
${HOME}/miniconda3/envs/fastqc/bin/fastqc \
-o $CUR_DIR/result_fastqc/${sample} \
$CUR_DIR/result_prinseq/${sample}/${sample}_good_1.fastq

${HOME}/miniconda3/envs/fastqc/bin/fastqc \
-o $CUR_DIR/result_fastqc/${sample} \
$CUR_DIR/result_prinseq/${sample}/${sample}_good_2.fastq

#after corrected
${HOME}/miniconda3/envs/fastqc/bin/fastqc \
-o $CUR_DIR/result_fastqc/${sample} \
$CUR_DIR/result_spades/${sample}/corrected/${sample}_good_1.00.0_0.cor.fastq

${HOME}/miniconda3/envs/fastqc/bin/fastqc \
-o $CUR_DIR/result_fastqc/${sample} \
$CUR_DIR/result_spades/${sample}/corrected/${sample}_good_2.00.0_0.cor.fastq


