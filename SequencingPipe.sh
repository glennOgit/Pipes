#!/bin/bash

#get fastq file name for read 1 and read two and store into variables
for r1file in ./*_R1*.fastq*
do
	sampleID=${r1file%%_R1*}
	for r2file in ./*_R2*.fastq*
	do
		if [[ "$r2file" == "${sampleID}_R"* ]]
		then
			let pair++
			echo "Here is the read pair $pair:"
			echo $r1file
			echo $r2file
			echo "GlennTools version 0.1"
			echo "==========================================================================================================================================================="
			
			cutadapt -m 16 -A TCGGACTGTAGAACTCTGAACGTGTAGATCTCGGTGGTCGCCGTATCATT -a TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACNNNNNNATCTCGTATGCCGTCTTCTGCTTG -o ${sampleID}_trim_R1.fastq -p ${sampleID}_trim_R2.fastq $r1file $r2file 
			
			
			bwa mem -t 32 /gpfs/home/goliveir/Refs/ZIKVPletconstr.fa ${sampleID}_trim_R1.fastq ${sampleID}_trim_R2.fastq | samtools view -@ 16 -bS - | samtools sort -@ 16 - > $sampleID.srt.bam
		fi
done
done
