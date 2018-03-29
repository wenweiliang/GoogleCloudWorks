#!/bin/bash
while read lines;
do 
index=$(echo $lines | awk -F " " '{print $1}')
bampath=$(echo $lines | awk -F " " '{print $11}')
Lsite=$(echo $lines | awk -F " " '{print $13}')
Rsite=$(echo $lines | awk -F " " '{print $14}')
filename=$(echo $lines | awk -F " " '{print $12}')
Lgene=$(echo $lines | awk -F " " '{print $2}')
Rgene=$(echo $lines | awk -F " " '{print $3}')
cat samtools_fusion.qc.yaml | sed "s/LSITE/${Lsite}/g" | sed "s/RSITE/${Rsite}/g" | sed "s/LGENE/${Lgene}/g" | sed "s/RGENE/${Rgene}/g"> run11_HighPass/${filename}
done < all.coordinate.HighPassBAM.100kb.final.txt
