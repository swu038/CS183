#!/bin/perl

use strict; 
use warnings; 
my %from; 
my %to;
my $lastFromIndex = 0; 
my $lastToIndex = 0; 
my $address;
my @field;
my @field2;   

my $file = $ARGV[0] or die;

open(my $data, '<', $file) or die $!; 

while( my $line = <$data>) 
{
    chomp $line; 

    if($line =~ /from=</) 
    {
        $from{$1}++ if ($line =~ /from=\<(\w+\@\S+)\>/); #note that the thing in parenthesis is $1. 

#        foreach $address (sort {$from{$a} <=> $from{$b} } keys %from) 
#        {
#            print "$address: $from{$address}\n"; 
#        }     
    }
    elsif($line =~ /to=</) 
    {
        $to{$1}++ if ($line =~ /to=\<(\w+\@\S+)\>/);

#        foreach $address (sort {$to{$a} <=> $to{$b} } keys %to) 
#        {
#            print "$address: $to{$address}\n"; 
#        } 
    }

}

@field = sort{$from{$a} <=> $from{$b}} keys %from; 
$lastFromIndex = $#field; 
for(my $i = 0; $i < 5; $i++)
{
    print "From $field[$lastFromIndex - $i] $from{$field[$lastFromIndex - $i]}\n" 
}

@field2 = sort{$to{$a} <=> $to{$b}} keys %to; 
$lastToIndex = $#field2; 
for(my $i = 0; $i < 5; $i++) 
{
    print "To $field2[$lastToIndex -$i] $to{$field2[$lastToIndex - $i]}\n"
}

close $data; 
