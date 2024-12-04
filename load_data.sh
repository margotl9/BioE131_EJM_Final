#!/bin/bash
## declare an array variable 
declare -a arr=(GCF_000859985.2 GCA_027936265.1 GCF_000858285.1 GCF_000848845.1 GCF_000839725.1 GCF_000840765.1 GCF_000845245.1 GCF_008792765.1 GCF_000848125.1 GCF_002402265.1 GCF_000838265.1 GCF_000839325.1 GCF_000846065.1) 
## now loop through the above array 
for i in "${arr[@]}" 
do 
    echo "$i $i"
    echo $i
    datasets download genome accession "$i" --include gff3,genome
    echo datasets download genome accession "$i" --include gff3,genome
    jbrowse add-assembly genes.gff --out $APACHE_ROOT/jbrowse2 --load copy --name "$i"

    jbrowse text-index --out $APACHE_ROOT/jbrowse2

done