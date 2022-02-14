
id=("ASM1904710v1", "ASM1602849v1")


#for FAST in FASTA 
#DO
#esearch -db nuccore -query $id | efetch -format fasta > seq.fa
#FINISH

#for i in `$id`; do efetch -db nuccore -id ${i} -format fasta > ${i}.fa ; done

#epost -db nuccore -input id -format acc | efetch -format fasta | grep ">"


#for FAST in $id
#do
#	esearch -db nuccore -query ${FAST} | efetch -format fasta > ${FAST}.fa
#done

DIR=./my_files
rm $DIR
mkdir $DIR
cd $DIR

for FAST in "${id[@]}"
do
    esearch -db assembly -query $FAST </dev/null \
        | esummary \
        | xtract -pattern DocumentSummary -element FtpPath_GenBank \
        | while read -r url ; do
            fname=$(echo $url | grep -o 'GCA_.*' | sed 's/$/_genomic.fna.gz/') ;
            wget "$url/$fname" ;
        done ;
    done

   DIR2=./unziped
   rm $DIR2
   mkdir $DIR2

   for f in *.gz; do
	  STEM=$(basename "${f}" .gz)
 	 gunzip -c "${f}" > $DIR2/"${STEM}"
	done
   
   
   #gunzip -c $(ls *.gz) > $DIR2


echo "DONE"

