#!/bin/sh 

x=$( wc -l < /etc/passwd ) 
y=$( wc -l < /etc/group )      

for (( i = 1; i <= $x; i++ )) do
     variable=$(awk -v c="$i" -F":" 'BEGIN {ORS=""} NR==c, NR==c{ print $1 }' /etc/passwd)   
     awk -v a="$i" -F":" 'BEGIN { ORS="" } NR==a,NR==a{ print $1, $3 } END { print " " }' /etc/passwd
     for (( k = 1; k <= $y; k++ )) do
        group=$(awk -v e="$k" -F":" 'NR==e, NR==e{ print $1 } ' /etc/group ) 
        awk -v b="$k" -F":" 'NR==b,NR==b{ print $4 } ' /etc/group | awk -v var="$variable" -v G="$group" -F"," 'BEGIN { ORS=" " } { for ( j = 1; j <= NF; j++ )
        if( var == $j )
            print G               
        }'      
    done 
    printf "\n"  
done 

#first for loop prints out the user login, and UID. 
#second for loop compares to see which user matches with what group, and prints the group. 
