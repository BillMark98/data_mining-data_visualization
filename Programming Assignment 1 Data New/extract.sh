#!/bin/bash
filename='ExcelFormattedGISTEMPData2TXT.txt'
count=0
while read -a wordarray; do
    # if "$word" = "\n"
    # then
    #     echo "match"
    # fi
    length="${#wordarray[@]}"
    echo length
    for (( i = 0; i<$length; i++)) 
    do
        let v="$i"+1
        echo $v
        word="${wordarray[i]}"
        # awk -v var="$v" '{out=""; {out=out" "$var}; print out}' ./ExcelFormattedGISTEMPData2TXT.txt > ${word}.txt
        # awk "{print \$$v}" ./ExcelFormattedGISTEMPData2TXT.txt > ${word}.txt
        awk "{print \$($i + 1)}" ./ExcelFormattedGISTEMPData2TXT.txt > ${word}.txt
    done
    let count=count+1
    # [] stands for test condition and must be surrounded by blanks
    if [ $count -eq 1 ];  
    then
        break;
    fi
    # echo 
done < "$filename"

# why no output?
# read -r line < ExcelFormattedGISTEMPData2TXT.txt
