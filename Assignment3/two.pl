#!/bin/perl

use strict; 
use warnings;
my $unknownCount = 0; 
my $knownCount = 0; 
my %known;
my %unknown;
my $ip;  
my $lastKnownIndex = 0; 
my $lastUnknownIndex = 0; 
my @field;
my @field2;  

open (my $data, '<', "log2") or die $!; 

while (my $line = <$data>) {
    chomp $line; 

    if($line =~ m/postfix/ && $line =~ /\sconnect\sfrom/)
    {    
        if($line =~ /unknown/)
        {
            $unknownCount++;
        
            $unknown{$1}++ if($line =~ /\[(\d+\.\d+\.\d+\.\d+)\]/); 

#           foreach $ip (sort {$unknown{$a} <=> $unknown{$b} } keys %unknown) 
#           {    
#               print "$ip: $unknown{$ip}\n";              
#           }    
        } 
        else
        {
            $knownCount++;

            $known{$1}++ if($line =~ /\[(\d+\.\d+\.\d+\.\d+)\]/); 

#           foreach $ip (sort {$known{$a} <=> $known{$b} } keys %known) 
#           {
#               print "$ip: $known{$ip}\n";
#           } 
        }
    }        
} 

@field2 = sort{$known{$a} <=> $known{$b} } keys %known; 
$lastKnownIndex = $#field2;
print "Total Known connection: $knownCount-[$field2[$lastKnownIndex]] accounts for $known{$field2[$lastKnownIndex]} connections.\n";      

@field = sort{$unknown{$a} <=> $unknown{$b} } keys %unknown; 
$lastUnknownIndex = $#field; 
print "Total Unknown connections $unknownCount-[$field[$lastUnknownIndex]] accounts for $unknown{$field[$lastUnknownIndex]} connections.\n"; 

close $data; 
