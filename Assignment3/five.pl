#!/bin/perl

use strict; 
use warnings; 
my $size = 0; 

#print "@ARGV\n";    

$size = $#ARGV;
 
for ( my $i = 0; $i < $size; $i++)
{
    pop @ARGV;
}

#print "@ARGV\n";     
