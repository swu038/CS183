#!/bin/bash

pid=$(ps -e -o user,pid,etime | grep -v root | sed -e '/USER/d' | tr -s " " | cut -d" " -f 2)

count=1 

ps -e -o user,pid,etime | grep -v root | sed -e '/USER/d' | tr -s " " | cut -d " " -f 3 | cut -d":" -f 2 | {
    while IFS= read -r line
        do
            if [ "$line" -gt "2" ]; then
                kill -9 echo $pid | cut -d" " -f $count
            fi 
            count=$((count + 1))  
    done
}
 
 
 
