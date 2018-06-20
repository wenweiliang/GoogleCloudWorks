#!/bin/bash
echo "#" > ./run11_HighPass/gcloudcommand_samtool_HighPass.sh
while read lines;
do
index=$(echo $lines | awk -F " " '{print $1}')
bampath=$(echo $lines | awk -F " " '{print $11}')
filename=$(echo $lines | awk -F " " '{print $12}')

echo "gcloud alpha genomics pipelines run \
  --pipeline-file ${filename} \
  --inputs bamfile=${bampath},baifile=${bampath}.bai \
  --outputs outputPath=gs://dinglab/wliang_fusion/output/all_100kb_2nd_HighPass \
  --logging gs://dinglab/wliang_fusion/logging/all_100kb_2nd_HighPass \
  --disk-size datadisk:1500" >> ./run11_HighPass/gcloudcommand_samtool_HighPass.sh

done < all.coordinate.HighPassBAM.100kb.final.txt
