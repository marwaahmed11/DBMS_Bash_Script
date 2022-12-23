#!/usr/bin/bash


head -1 metadata | tr ":" "" |wc -w => 4
while (i<4)
{

head -1 metadata | cut -d: -f $i 


((i=$i+1)
}


read 'enter number' i

cut -d : -f $i
