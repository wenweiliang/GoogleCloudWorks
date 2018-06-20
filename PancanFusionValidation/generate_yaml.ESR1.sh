#!/bin/bash
while read lines;
do 
bampath=$(echo $lines | awk -F " " '{print $15}')
Lsite=$(echo $lines | awk -F " " '{print $18}')
Rsite=$(echo $lines | awk -F " " '{print $19}')
filename=$(echo $lines | awk -F " " '{print $17}')
Lgene=$(echo $lines | awk -F " " '{print $10}')
Rgene=$(echo $lines | awk -F " " '{print $11}')
cat samtools_fusion.qc.yaml | sed "s/LSITE/${Lsite}/g" | sed "s/RSITE/${Rsite}/g" | sed "s/LGENE/${Lgene}/g" | sed "s/RGENE/${Rgene}/g"> run14/${filename}
done < ESR1.coordinate.txt
