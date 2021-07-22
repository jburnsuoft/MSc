#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=40
#SBATCH --time=24:00:00
#SBATCH --job-name FEB28_vivo_NOD
#SBATCH --output=FEB28_vivo_NOD.txt
#SBATCH --mail-type=ALL

cd /scratch/z/zhaolei/jburns
module load CCEnv
module load StdEnv
source ~/.virtualenvs/clippipe/bin/activate
module load fastqc/0.11.9
module load fastx-toolkit/0.0.14
module load seqtk
module load nixpkgs/16.09
module load star/2.7.0a
module load samtools/1.10 ##SHOULD BE 1.5
module load bedtools/2.27.1



OR

cd /scratch/z/zhaolei/jburns
module load CCEnv
module load StdEnv
source ~/.virtualenvs/clippipe/bin/activate
module load fastqc/0.11.9
module load fastx-toolkit/0.0.14
module load nixpkgs/16.09
module load samtools/1.10 ##SHOULD BE 1.5
module load bedtools/2.27.1
module load gcc/7.3.0
module load star
module load intel/2018.3
module load seqtk/1.2
module load bowtie2

OR

cd /scratch/z/zhaolei/jburns/CLIP_PROCESSING
module load CCEnv
module load StdEnv
source activate condaclip
module load fastqc/0.11.9
module load fastx-toolkit/0.0.14
module load seqtk
module load nixpkgs/16.09
module load star/2.7.0a
module load samtools/1.10 ##SHOULD BE 1.5
module load bedtools/2.27.1

perl PipelineCLIP.pl --barcodes=barcodes.txt --fastqc --idLen=45 --trimLast=35 --minLast=25 --piranha --genome=hg19 /scratch/z/zhaolei/jburns/Greenblatt_N/Greenblatt_6plex_pool1_N-L_S1_2_S1_R1_001.fastq.gz


#FASTICLIP
OR

cd /scratch/z/zhaolei/jburns
module load CCEnv
module load StdEnv
source ~/.virtualenvs/clippipe/bin/activate
module load fastqc/0.11.9

module load nixpkgs/16.09
module load samtools/1.10 ##SHOULD BE 1.5
module load bedtools/2.27.1
module load gcc/7.3.0

module load intel/2018.3
module load seqtk/1.2

conda activate iCLIPpro
cd /scratch/z/zhaolei/jburns/FAST-iCLIP
module load CCEnv
module load StdEnv
module load bowtie2
module load star
module load bedtools
module load fastx-toolkit/0.0.14
export FASTICLIP_PATH=/scratch/z/zhaolei/jburns/FAST-iCLIP
export PATH=$FASTICLIP_PATH:$PATH
