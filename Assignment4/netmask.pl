#!/usr/bin/perl

use strict; 
use warnings; 

my $var;
my $hostbits; 
my $address;
my $usable; 
my $netmask1 = 255;
my $netmask2 = 255;
my $netmask3 = 255; 
my $netmask4 = 255; 
my $i; 

$var = $ARGV[0];  
$address = 2**(32 - $var);     #squares
$usable = $address -2;    
$hostbits = 32 - $var; 
 
for($i = 0; $i < 8; $i++)
{
    if($hostbits != 0) 
    {
        $netmask4 = $netmask4 - 2**$i;
        $hostbits = $hostbits - 1;  
    }
    else
    {
        last;  #exits for loop 
    } 
}

if( $hostbits != 0) 
{ 
    for($i = 0; $i < 8; $i++) 
    {
        if($hostbits != 0)
        {
            $netmask3 = $netmask3 - 2**$i; 
            $hostbits = $hostbits -1; 
        }
        else
        {
            last;
        }
    }
}


if( $hostbits != 0) 
{ 
    for($i = 0; $i < 8; $i++) 
    {
        if($hostbits != 0)
        {
            $netmask2 = $netmask2 - 2**$i; 
            $hostbits = $hostbits -1; 
        }
        else
        {
            last;
        }
    }
}

if( $hostbits != 0) 
{ 
    for($i = 0; $i < 8; $i++) 
    {
        if($hostbits != 0)
        {
            $netmask1 = $netmask1 - 2**$i; 
            $hostbits = $hostbits -1; 
        }
        else
        {
            last;
        }
    }
}

print "addresses: $address usable: $usable netmask: $netmask1.$netmask2.$netmask3.$netmask4 \n";   
