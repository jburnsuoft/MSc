#!/bin/bash
#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --account=def-zhaolei
#SBATCH --cpus-per-task=40
#SBATCH --mail-type=ALL
#SBATCH --output=ADAR_R3_R4
conda activate condaclip
cutadapt --action=none --no-indels -e 0 -g ADAR1_R4_2=^NNNAACCNN -g ADAR1_R3_2=^NNNTTGTNN -o "demultiplex/{name}.fastq.1.gz" ADAR.fastq.gz

