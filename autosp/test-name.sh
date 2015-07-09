#!bin/sh

## edit arg name
temp=$1
temp=${#temp}
temp=`expr $temp - 3`
file=`echo $1 | cut -c 1-$temp`
echo "$file"
