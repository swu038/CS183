#!/bin/sh 

#1) dd
# The dd command converts the format of the data depending on the given operands, and copies a file. It is important to note that inccorrect usage such as entering wrong variables could cause the data on the hard drive to be overwritten, wiped, or destroyed. 
# Syntax: dd [Operand]  
#Ex) One of the things it can do is disk cloning, which is helpful in making backups, or in recovering data. In this example, we are cloning a partition from the physical disk /dev/sda, partition 1, to the physical disk /dev/sdb, partition 1. 
dd if=/dev/sda1 of=/dev/sdb1 bs=64k conv=noerror,sync 

#2) find 
# The find command is used to search for files from the command line. This command has built in options that allow for the searching of files based on user ownership, modification, permissions, type of file etc. This command is especially helpful when the user needs to look for a file whose location is unknown to the user.
# Syntax: find [path] [option] [filename] 
#EX) In this example, we are searching up a specific file named "test.txt". This command will look up any files named "test.txt" and output its path to the file from the current directory that you are in.  
find -name "test.txt"

#3) file 
#The file command is used to find out a file's type. When running the file command, three tests are performed: filesystem tests, magic tests, and language tests. The filesystem tests examine to see if the file is empty or if its a type of special file. The magic tests see if if the data are in a particular fixed format. The last test will try to determine the language the file is written in.
# Syntax: file [-bchiklLnnprsvz0] [--aple] [--mine-encoding] [--mime-type] [-e testname] [-F separator] [-f namefile] [-m magicfiles] file...
#   file -C [-m magicfiles]  
#Ex) In order to determine the file type of /etc/passwd, this example will output that it is an ASCII English text. 
file /etc/passwd

#4) fuser 
# The fuser command will display which process is using a file, directory, or a socket. This command will also print the process id (PID) of every process using the specified files or files system, and information about which user owns the process and the type of permissions it has. Fuser returns a non-zero return code if none of the specified files is accessed or if there is an error. If at least one acces is found, zero is returned. 
# Synthax: fuser [-fMuv] [-a|-s] [-4|-6] [-c|-m|-n| SPACE] [-k [-i] [SIGNAL]] NAME... 
#   fuser -l
#   fuser -V   
#Ex) Suppose a user wants to look up which processes are using TCP and UDP sockets. The first command creates a TCP listener to port 80. The user would then have to use fuser with the option -n in order to look up a specific name space.  
nc -1 80
fuser -v tcp 80

#5) grep 
# The grep command is one of the most useful commands as its job is to search files for matching text or strings.
# Syntax: [options] pattern [file...] 
#Ex) In this example, we use grep to search recursively for all file under the directory /etc for the string "magic". 
grep -r "magic" /etc

#6) host 
# The host command lookups the DNS name, finds the IP address of a host or vice versa, lists the different types of DNS resource records, checks ISP dns server and internet connectivity, verify spam and blacklisting records, and examinds troubleshooting dns server issues. One of the main reason for using the host command is the resolve a host name into an Internet Portocol (IP) or an IP address into a host name. 
# Syntax: host [Ip Address] 
#   host [host name]
#   host [host name] [DNS server name]
#   host [options] [Ip Address | hostname [DNS server name] 
#Ex) If a user wishes to find the Ip address for the domain, google.com. 
host google.com    

#7) ldd 
# The ldd command displays the shared libraries needed by each program, or the shared library given on the command line. 
# Syntax: ldd [option] file
#Ex) In this example, ldd displays the shared library of the program /bin/bash. 
ldd /bin/bash 

#8) lsof 
# The lsof command, or the list of open files, basically lists information on files that are openned by running processes. 
# Syntax: lsof [option] [path] 
#Ex) This example lists the processes that opened files under the specific directory, log.  
lsof +D /var/log/

#9) mount
# The mount command mounts a storage device or filesystem, and it makes all files spread throughout different devices to be accessible in one big file tree.# Syntax: mount [-lhV] 
#   mount -a [-fFnrsvw] [-t vfstype] [-0 optlist] 
#   mount [-fnrsvw] [-o option[,option]..] device|dir
#   mount [-fnrsvw] [-t vfstype] [-o options] device|dir
#Ex) Mounting a device file for CD that exist under /dev directory. 
mount -t iso9600 -o ro /dev/cdrom /mnt 

#10) ps 
# The ps command reports a snapshot of the current processes. It also provides information such as user id, cpu usage, memory usage, command name etc. 
# syntax: ps [options] 
#Ex) Suppose the user wants to see a full list of the processes, they would simply type: 
ps ax

#11) pkill 
# The command pkill is meant to look up/signal processes based on their name or other attributes. 
#syntax: pkill [options] pattern 
#Ex) If the user wanted to make syslog reread its onfiguration file, they would carry out this example. 
pkill -HUP syslogd 

#12) netstat 
# The netstat command shows network connections, routing tables, interface statistics, masquerade connections, and multicast memberships. One of the uses of this command is to solve problmes in the network, and to examine the traffic flow the network. 
#syntax: netstat [option] 
#Ex) This displays the routing table for all IP addresses bound to the server.
netstat -rn 

#13) renice 
# The renice command changes the priority of processes that are currently running. By setting a process with a higher value, means the process requires fewer system resources, and therefore, makes the process low pirority. Lower value would mean the process is high priority. The highest value that can be assigned is 20 while the lowest is 0. 
#syntax: renice [option] [priority] [pid] 
#Ex) Increases the value of the priority of all processes owned by user root by one. 
renice +1 -u root 

#14) rsync 
# The command rsync is a very handy copying untility as it is very fast and has many features. It can copy locally, to/from another host over any remote shell, or to/from a remote rsync daemon. It is mainly used for backups and mirroring, and a more advanced copy command tool.
# Syntax: rsync [option] source [destination] 
# Ex) Lets say we want to copy the the file test.sh to the folder tmp, we would run these commands: 
touch test.sh 
mkdir tmp 
rsync test.sh tmp

#15) time 
# The command time shows how much time was needed in order for a command to execute. 
# Syntax: time [-p] command [arguments] 
#Ex) This example determines the free disk space using the df command, and then displays how long it took for the df command to carry out.
time df

#16) ssh 
# The ssh command allows the user to log in to a remote machine and execute commands there. In order to exit back to the original user account, one would type the command exit.  
# syntax: ssh [user login name] 
#Ex) In order to ssh into my ucr sledge account I would type the following command: 
ssh swu038@sledge.cs.ucr.edu

#17) stat 
# The stat command reveals a informative status of a specific file or file system. 
# syntax: stat [option] file 
#Ex) In this example, we will be viewing the status of the first hard disk by using the -f option. 
stat -f /dev/sda 

#18) strace 
# The strace command monitors system calls and signals of specific programs. 
# syntax: strace [options] [command]  
#Ex) For this example, we will trace the execution of the execuatable, ls command. 
strace ls

#19) uname
# The uname command print the current system's information. Note that is no option is inputted, uname will automatically use the default option, -s. 
# syntax: uname [option] 
#Ex) If the user wishes to display all system information, they would use the option -a along with the uname command. 
uname -a 

#20) wget 
# The wget command downloads files over a network. It supports HTTP, HTTPS, and FTP protocols, as well as retrieval through HTTP proxies. It is non-interactive, which allows the user to download even though they are not logged in. 
#syntax: wget [website] 
#Ex) This example retrieves the first layer of yahoo links: 
wget -r -l1 http://www.yahoo.com/ 
  
          
