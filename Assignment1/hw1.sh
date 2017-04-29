#!/bin/sh

if [ $# -eq 0 ]; then 
    exit;
else
    cat $@
fi         
