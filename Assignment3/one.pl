#!/bin/perl 

use strict; 
use warnings; 

my $file = $ARGV[0] or die; 
my $numPostfix = 0;
my $numAmavis = 0;
my $min = 00;
my $lastMin;
my @field; 
my @time;
my @test;  
 
open( my $data, '<', $file ) or die $!;
open( FILE, '>', "hourlyInfo") or die $!; 
 
while(my $line = <$data>) { 
    chomp $line;  

    @test = split( / /, $line); 
    if($test[0] =~ /\w+/) 
    {
        @field = split( / /, $line);
        @time = split( /:/, $field[3]); 
    }

    if ( $min == $time[1] ) 
    {
        $lastMin = $time[1]; 
        if( $line =~ m/postfix/ && $line =~ /reject/)
        {
            $numPostfix++;   
        }
        elsif( $line =~ m/amavis/ && $line =~ /Not-Delivered/) 
        {
            $numAmavis++; 
        }
    }
    else
    {
        if($field[0] =~ /\w+/) 
        {
            print FILE "$field[0] $field[2] $time[0]:$lastMin [postfix rejects:$numPostfix] [amavis quarantines:$numAmavis]\n";  
            
            $min = $time[1];
            $numPostfix = 0; 
            $numAmavis = 0;
        }
 
    }
}   

if($field[0] =~ /\w+/)
{
    print FILE "$field[0] $field[2] $time[0]:$lastMin [postfix rejects:$numPostfix] [amavis quarantines:$numAmavis]\n";  
}
#note must add FILE before print! 

close $data;  
close FILE;  
