#!/bin/sh 

x=$( wc -l < a.cpp )   
 
for (( i = 1; i <= $x; i++ )) do
    awk -v a="$i" -F":" 'NR==a,NR==a{ printf $1 }' /home/csmajs/swu038/CS183/lab2/a.cpp
    awk -v b="$i" -F":" 'NR==b,NR==b{ print "", $4 } ' /home/csmajs/swu038/CS183/lab2/a.h 
done

#the -F sets the deliminator to : instead of a blank space 
#the -v is the variable setter. Note: in awk, variables must be set within awkitself and not in shell. 
 
