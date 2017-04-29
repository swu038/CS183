#!/bin/bash

chkconfig mdmonitor off
#I am turning off mdmonitor because I don't have RAID storage in my system. Therefore, this service would be useless for me, and just taking up memory and time to run. 

chkconfig postfix off
#I don't need the postfix service becuase I don't need a mail transport agent. My system is not a mail relay server, and thus this service is unnecessary. 

chkconfig netconsole off 
#This service allows functionality for debugging and kernel logging over network connections. Since I won't be viewing my kernel log, or debugging messages on another computer, this service is just taking up booting time.   

chkconfig saslauthd off 
#I'm not on a server that communicates using SASL mechanisms, and therefore this daemon is not needed. 

chkconfig netfs off
#Not using NFS, and leaving this service on could present a secruity risk.  
  





