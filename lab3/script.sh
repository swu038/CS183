#!/bin/bash

#1) These files are considered secruity risks because the SETUID means that the executable can run under different permissions than the user who has executed it. That means this user can access high permission levels that should only be reserved for the root, and this can potentially cause security issues.
echo "finding all files in /bin, /sbin, /usr/bin, and /usr/sbin that are setuid and owned by root." 
find /bin /sbin /usr/bin /usr/sbin -user root -perm -4000 
read -p "Hit any key to continue." 

#2)
echo "finding all files in /var that have changed in the last 20 minutes." 
find /var -cmin -20
read -p "Hit any key to continue."

#3)
echo "finding all files in /var that are regular files of zero length."
find /var -type f -size 0
read -p "Hit any key to continue." 

#4) 
echo "finding all files in /dev that are not regular files and also not directories. Also print permissions and modification times." 
find /dev -not -type f -and -not -type d -exec ls -l {} \; 
read -p "Hit any key to continue." 

#5) 
echo "finding all directories in /home that are not owned by root. Also change their permissions to ensure they have 711 permissions."
find /home -type d ! -user root -exec chmod 711 {} \; 
read -p "Hit any key to continue." 

#6) 
echo "finding all regular files in /home that are not owned by root. Also change their permissions to ensure they have 755 permissions." 
find /home -type f ! -user root -exec chmod 755 {} \; 
read -p "Hit any key to continue." 

#7) 
echo "finding all files in /etc that have changed in the last 5 days." 
find /etc -mtime -5
    
