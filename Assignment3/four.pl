#!/bin/perl

use strict; 
use warnings;
my $rejectCount = 0; 
my %ips; 
my %from; 
my %to; 
my $key;
my $value;
my @field; 
my @field2;
my @field3; 

open(my $data, '<', "log4") or die $!; 

while( my $line = <$data>) 
{
    chomp $line; 

    if($line =~ /dnsbl.sorbs.net/) 
    {
        $rejectCount++; 
        
        $ips{$1}++ if ($line =~ /IP=(\d+\.\d+\.\d+\.\d+)/);

#        while (($key, $value) = each(%ips)) 
#        {
#            print "$key: $value\n"
#        }

        $from{$1}++ if ($line =~ /from=\<(\w+\@\S+)\>/); 

#        while (($key, $value) = each(%from))
#        {
#            print "$key: $value\n";
#        }
        
        $to{$1}++ if ($line =~ /to=\<(\w+\@\S+)\>/);

#        while (($key, $value) = each(%to))
#         {
#             print "$key: $value\n";
#         }
    }
} 

print "$rejectCount messages rejected\n"; 
@field = keys %ips;
print "$#field unique IP's\n"; 
@field2 = keys %from;
print "$#field2 unique from addresses\n";
@field3 = keys %to;  
print "$#field3 unique to addresses\n"; 

