#!/bin/sh 

x=$( wc -l < a.cpp ) 
y=$( wc -l < a.h )     

for (( i = 1; i <= $x; i++ )) do
     variable=$(awk -v c="$i" -F":" 'BEGIN {ORS=""} NR==c, NR==c{ print $1 }' /home/csmajs/swu038/CS183/lab2/a.cpp)  
     awk -v a="$i" -F":" 'BEGIN { ORS="" } NR==a,NR==a{ print $1, $3 } END { print " " }' /home/csmajs/swu038/CS183/lab2/a.cpp
     for (( k = 1; k <= $y; k++ )) do
        group=$(awk -v e="$k" -F":" 'NR==e, NR==e{ print $1 } ' /home/csmajs/swu038/CS183/lab2/a.h) 
        awk -v b="$k" -F":" 'NR==b,NR==b{ print $4 } ' /home/csmajs/swu038/CS183/lab2/a.h | awk -v var="$variable" -v G="$group" -F"," 'BEGIN { ORS=" " } { for ( j = 1; j <= NF; j++ )
        if( var == $j )
            print G               
        }'      
    done 
    printf "\n"  
done 

#echo "test 2" 
#i=3
#variable=$(awk -F":" 'BEGIN {ORS="" } NR==3, NR==3{ print $1 }' /home/csmajs/swu038/CS183/lab2/a.cpp) 

#echo "hi $variable hi"
#echo "yo $( awk -v b="$i" -F":" 'NR==b,NR==b{ print $4 } ' /home/csmajs/swu038/CS183/lab2/a.h | awk -F"," 'BEGIN {ORS=""} { for ( j = 1; j <= NF; j++ ) print $j }') yo"  
 
 
#    awk -v b="$i" -F":" 'BEGIN {ORS=""} NR==b,NR==b{ print $4 } ' /home/csmajs/swu038/CS183/lab2/a.h | awk -v var="$variable" -F"," '{ for ( j = 1; j <= NF; j++ ) 
#        if( var == $j ) 
#            print "true"
#        else
#            print var  
#}'  



