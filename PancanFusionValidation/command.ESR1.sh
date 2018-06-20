#!/bin/bash
echo "#" > ./run14/gcloudcommand_samtool.sh
while read lines;
do
bampath=$(echo $lines | awk -F " " '{print $15}')
filename=$(echo $lines | awk -F " " '{print $17}')

echo "gcloud alpha genomics pipelines run \
  --pipeline-file ${filename} \
  --inputs bamfile=${bampath},baifile=${bampath}.bai \
  --outputs outputPath=gs://dinglab/wliang_fusion/output/ESR1 \
  --logging gs://dinglab/wliang_fusion/logging/ESR1 \
  --disk-size datadisk:1500" >> ./run14/gcloudcommand_samtool.sh

done < ESR1.coordinate.txt
