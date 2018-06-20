####
#Aim: Generate google cloud command
#Usage: bash generate_command.sh ${List_of_BAMs} ${JobName}
#1. bash generate_command.gatk.sh TCGA_WGS_gspath_WWL_Mar2018.HighPass.txt HighPass 
#2. bash generate_command.gatk.sh TCGA_WGS_gspath_WWL_Mar2018.LowPass.txt LowPass
#Author: Wen-Wen Liang @ Wash U (liang.w@wustl.edu)
####

mkdir -p cloud
echo "#" > cloud/gcloud_command.$2.msisensor.sh
while read lines; do
	passvalue=$2
	nbampath=$(echo $lines | awk -F " " '{print $5}')
	nbam=$(echo ${nbampath} | awk -F "/" '{print $10}')
	tbampath=$(echo $lines | awk -F " " '{print $4}')
	tbam=$(echo ${tbampath} | awk -F "/" '{print $10}')
	tumorid=$(echo $lines | awk -F " " '{print $2}')
	size=$(echo $lines | awk -F " " '{print ($8*1.1)/1000000000}' | awk '{printf "%.0f", $1}')
	#Disk size in GB
	yaml="../msisensor.yaml"

	echo "gcloud alpha genomics pipelines run --pipeline-file ${yaml} --inputs normalbam=${nbampath},normalbai=${nbampath}.bai,tumorbam=${tbampath},tumorbai=${tbampath}.bai,id=${tumorid},msilist=gs://dinglab/wliang_msi/microsatellites.list,nbam=${nbam},tbam=${tbam} --outputs outputPath=gs://dinglab/wliang_msi/output/${tumorid}/${passvalue}/ --logging gs://dinglab/wliang_msi/logging/ --disk-size datadisk:${size}" >> cloud/gcloud_command.$2.msisensor.sh
done < $1
