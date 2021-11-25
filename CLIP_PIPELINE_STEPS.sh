#!/bin/sh

#  CLIP_PIPELINE_STEPS.sh
#  
#
#  Created by james burns on 2021-01-20.
#  


####STEP 1
###TEMPLATE
#mkdir demultiplex
#cutadapt --action=none --no-indels -e 0 -g _A=^NNNNN -g _B=^NNNNN -g _A=^NNNNN -g _B=^NNNNN -g _A=^NNNNN -g _B=^NNNNN -o "demultiplex/{name}.fastq.1.gz" $1

mkdir demultiplex
cutadapt --action=none --no-indels -e 0 -g G3BP1_N_A=^NNNGGCANN -g G3BP1_N_B=^NNNTTAANN -g G3BP1_N_C=^NNNAATANN -g G3BP1_N_INPUT_A=^NNNCCACNN -g G3BP1_N_ARSENITE_A=^NNNCCGGNN -g G3BP1_N_ARSENITE_B=^NNNTGGCNN -g G3BP1_N_ARSENITE_C=^NNNGGTCNN -g G3BP1_N_ARSENITE_INPUT_A=^NNNCGGANN -g ADAR1_A=^NNNAACCNN -g ADAR1_B=^NNNTTGTNN -o "demultiplex/{name}.fastq.1.gz" ADAR.fastq.gz


####STEP 2 - ADAPTER TRIM + EXTRACT BARCODES
### RUN .sh with $1 - Example == ADAR1_A.fastq.1.gz

cd demultiplex
#mkdir trimmed
#!/bin/bash
#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --account=def-zhaolei
#SBATCH --cpus-per-task=40
cutadapt --times 1 -e 0.15 -O 1 --quality-cutoff 10 -m 15 -a AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG -o trimmed/$1 $1
umi_tools extract --stdin=trimmed/$1 --bc-pattern=NNNNNNNNN --log=$1.log --stdout trimmed/processed/$1




####STEP4
####MAP PROCESSED READS WITH STAR ON NIAGARA
cd trimmed/processed

###SCRIPT -> STARMAP.sh
#!/bin/bash
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --account=def-zhaolei
module load CCEnv
module load nixpkgs/16.09
module load intel/2018.3
module load star/2.7.1a
STAR --runMode alignReads --genomeDir ../STAR/hg19/  --readFilesIn $1 --runThreadN 80 --readFilesCommand zcat --outFilterMultimapNmax 1 --outFileNamePrefix ../mapped_output/$1.output --outSAMtype BAM SortedByCoordinate --outSAMattributes All


####STEP5
#!/bin/bash
#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --account=def-zhaolei
#SBATCH --cpus-per-task=40
umi_tools dedup -I $1 -S ../bam_dedup/$1

#### Duplicate removal (deduplication) using UMI-tools
####umi_tools dedup -I <sampleX.bam> -L <sampleX.duprm.log> -S <sampleX.duprm.bam> --extract-umi-method read_id --method unique


