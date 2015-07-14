#!/bin/sh
VCS=0.5
VCS=`echo "scale=2; $VCS + 0.1" | bc`
temp=$1
temp=${#temp}
temp=`expr $temp - 3`
file=`echo $1 | cut -c 1-$temp`
echo "$file"

X=`echo "0.8 > $VCS" | bc`
echo "$X"
if test $X -eq 1;
then
 echo "ok"
fi

find ./ -
