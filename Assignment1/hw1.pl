#!/bin/perl

use strict; 
use warnings;    

my $numArgs = @ARGV; 
my $argnum; 
 
foreach $argnum(0 .. $#ARGV)   
{
    my $file_name = shift @ARGV;     #shift del whats in front of array.  
    open(my $fh, '<', $file_name) or die $!; 

   while(my $row = <$fh>) {
       chomp $row; 
        print "$row\n"; 
    }
    close($fh); 
}
       
 
