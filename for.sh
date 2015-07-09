#!/bin/sh

# define variable and array
a=0
files=("$@")

# run simulator "hspice filename > out"
while [ $a -ne $# ]
do
	hspice ${files[$a]} > out   # put arguments in an array
	a=`expr $a + 1`
done
