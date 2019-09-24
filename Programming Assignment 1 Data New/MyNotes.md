
#### notes on extract.sh
*   `read` ususally read a whole line of a file. To process each word on a line read  
    use `read -a wordarray` instead to save each word in to a `wordarray` variable which is an array  
*   `"${#wordarray[@]}"` is the length of the array
*   To redirect input so that `read` read from a file, see the end of the `while` loop in `extract.sh`  
    i.e. use ` done < filename`
*   the variable in `awk` command: `$0` stands for the whole line, `$1` stands for the first column, etc.   
    `$NF` stands for the last column  
    What I want is to read the first row the file, which is header for each column, then process the   corresponding column and redirects the output to a newfile with name given by the header.    
*   Here is a link to how to use shell variable in `awk` [shell variable in awk](https://stackoverflow.com/questions/19075671/how-do-i-use-shell-variables-in-an-awk-script)
```
    do
        let v="$i"+1
        echo $v
        word="${wordarray[i]}"
        awk -v var="$i"+1 '{out=""; {out=out" "$var}; print out}' ./ExcelFormattedGISTEMPData2TXT.txt > ${word}.txt
    done
```  

```
    awk: illegal field $(0+1), name "var"
    input record number 1, file ./ExcelFormattedGISTEMPData2TXT.txt
    source line number 1
 ```  
 Possible reason is that the var is like `3 + 1` instead of 4  
 so the modified version  
 ```
    let v="$i"+1
    echo $v
    word="${wordarray[i]}"
    awk -v var="$v" '{out=""; {out=out" "$var}; print out}' ./ExcelFormattedGISTEMPData2TXT.txt > ${word}.txt
```
OK  
Another way to do it is to use the difference between **single quote** and **double quote**. here is a link  
to explain it [single quote double quote](https://wiki.jikexueyuan.com/project/13-questions-of-shell/double-single.html) (in chinese)  

change the `awk` command to  
```
    awk "{print \$$v}" ./ExcelFormattedGISTEMPData2TXT.txt > ${word}.txt
```  
some notes to that link:   
```
$ a=";;;test"                              
$ IFS=";"                                  
$ echo $a                                  
   test                                                                         
$ a="   test"                              
$ echo $a                                  
   test                                                                         
$ IFS=" "                                  
$ echo $a                                  
test 
```  
Note the difference between `IFS=";"` and `IFS=;`  the first is set the `IFS` to `;` and  
the second sets the `IFS` to `null`  and I guess that to print `IFS` will use space to interepret it