#!/bin/bash

set -veou pipefail

../wgsim-trans  -r 0 -N 1000 -Z 2 trans.fa left.fq right.fq

bowtie2-build trans.fa trans.fa

bowtie2 --local --no-unal -x trans.fa -q  -1 left.fq -2 right.fq | samtools view -Sb - | samtools sort -  alignments

samtools faidx trans.fa

samtools index alignments.bam

igv.sh -g `pwd`/trans.fa `pwd`/alignments.bam



