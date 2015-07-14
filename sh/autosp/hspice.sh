#!/bin/sh

# run simulator "hspice [file] > out"
echo "hspice $1 > out"
hspice $1 > out   # put arguments in an array

# remove file without( .ac,.tr,.sw)
rm $1
