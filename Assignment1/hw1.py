#!/bin/py

import sys 

for i in range(1, len(sys.argv)):  
    with open(sys.argv[i], 'r') as f: 
        contents = f.read() 
        sys.stdout.write(contents)   #prints contents without newline

#note the file name is counted as argument.  
