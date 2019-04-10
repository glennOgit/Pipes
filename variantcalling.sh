#!/bin/bash

for bam in ./*bam
do
	
	samtools mpileup -d 8000 -f /gpfs/home/goliveir/Refs/ZikaPRVABC59.fa $bam | java -jar /gpfs/home/goliveir/tools/VarScan.v2.3.9.jar pileup2snp > $bam.pileup
done
