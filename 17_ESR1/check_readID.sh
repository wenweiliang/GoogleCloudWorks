prefix="WGS_supporting_read.all"
suffix="txt"
range="$*"

for i in ${range}; do
	echo -e "Fusion\tSample\tWGS_Reads" > ${prefix}.${i}.${suffix}
done

while read lines; do
	LGene=$(echo $lines| awk -F " " '{print $10}')
	RGene=$(echo $lines| awk -F " " '{print $11}')
	Filename=$(echo $lines|awk -F " " '{print $15}'| awk -F "/" '{print $10}' )
	Pair=${LGene}--${RGene}
	LgsPath="gs://dinglab/wliang_fusion/output/ESR1/${Filename}.${LGene}.txt"
	RgsPath="gs://dinglab/wliang_fusion/output/ESR1/${Filename}.${RGene}.txt"
	Sample=$(echo $lines| awk -F " " '{print $9}')
	Lfile="${Filename}.${LGene}.txt"
	Rfile="${Filename}.${RGene}.txt"

	gsutil cp ${LgsPath} .
	gsutil cp ${RgsPath} .

	for i in ${range}; do
		LRangeOfLgene=$(echo $lines |awk -F " " -v x=${i} '{split($18, b,  "[:-]"); print b[2]+100000-x}')
		RRangeOfLgene=$(echo $lines |awk -F " " -v x=${i} '{split($18, b,  "[:-]"); print b[3]-100000+x}')
		LRangeOfRgene=$(echo $lines |awk -F " " -v x=${i} '{split($19, c,  "[:-]"); print c[2]+100000-x}')
		RRangeOfRgene=$(echo $lines |awk -F " " -v x=${i} '{split($19, c,  "[:-]"); print c[3]-100000+x}')
		cat ${Lfile} | awk -F "\t" -v x=${LRangeOfLgene} -v y=${RRangeOfLgene} '{if ($3>=x && $3+101<=y) print $1}' >${Lfile}.${i}.temp
		cat ${Rfile} | awk -F "\t" -v x=${LRangeOfRgene} -v y=${RRangeOfRgene} '{if ($3>=x && $3+101<=y) print $1}' >${Rfile}.${i}.temp
		awk -F "\t" 'NR==FNR{a[$1];next}{if ($1 in a) print "Yes"}' ${Lfile}.${i}.temp ${Rfile}.${i}.temp | sort | uniq -c | awk -F " " '{print $2":"$1}'| awk -F "\t" -v x=${Pair} -v y=${Sample} 'END{ OFS="\t"; if (NR>=1) print x, y, $1; else print x, y, "No" }' >> ${prefix}.${i}.${suffix}
		rm ${Lfile}.${i}.temp ${Rfile}.${i}.temp 

	done

	rm ${Lfile} ${Rfile}

done < ../ESR1.coordinate.txt
