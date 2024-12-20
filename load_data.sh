#!/bin/bash
## declare an array variable 
declare -a arr=(GCF_000859985.2 GCA_027936265.1 GCF_000858285.1 GCF_000848845.1 GCF_000839725.1 GCF_000840765.1 GCF_000845245.1 GCF_008792765.1 GCF_000848125.1 GCF_002402265.1 GCF_000838265.1 GCF_000839325.1 GCF_000846065.1) 

datasets download genome accession --inputfile accessions.txt --include gff3,genome
unzip ncbi_dataset.zip

## now loop through the above array 
for i in "${arr[@]}" 
do 
    echo "$i" 
    samtools faidx ncbi_dataset/data/$i/*genomic.fna
    
    jbrowse add-assembly ncbi_dataset/data/$i/*genomic.fna  -n "$i" --out $APACHE_ROOT/jbrowse2 --type indexedFasta --load copy --force
    
    jbrowse sort-gff ncbi_dataset/data/$i/genomic.gff | bgzip > ncbi_dataset/data/$i/genomic.gff.gz > ncbi_dataset/data/$i/$i"_genomic_sorted.gff.gz"
    tabix ncbi_dataset/data/$i/$i"_genomic_sorted.gff.gz"

    jbrowse add-track ncbi_dataset/data/$i/$i"_genomic_sorted.gff.gz" --out $APACHE_ROOT/jbrowse2 --load copy --assemblyNames "$i" --force
done 
jbrowse text-index --out $APACHE_ROOT/jbrowse2 --force

# concatenate files into multiple sequence input
cat ncbi_dataset/data/*/*genomic.fna >> multiple_genomic.fna
