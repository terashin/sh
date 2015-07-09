#!/bin/sh

# define variable and array
a=0
Files=("$@")
TIME_ST_temp=`date +%s`
TIME_ST=`date '+%y/%m/%d %H:%M:%S'`

# run simulator "hspice filename > out"
while [ $a -ne $# ]
do
	echo "hspice ${Files[$a]} > out"
	hspice ${Files[$a]} > out   # put arguments in an array
	a=`expr $a + 1`
done

#measure time
TIME_ED_temp=`date +%s`
TIME_ED=`date '+%y/%m/%d %H:%M:%S'`
PT=`expr ${TIME_ED_temp} - ${TIME_ST_temp}`
H=`expr ${PT} / 3600`
PT=`expr ${PT} % 3600`
M=`expr ${PT} / 60`
S=`expr ${PT} % 60`
echo "${TIME_ST} START"
echo "${TIME_ED} END"
echo "${H}h:${M}m:${S}s time passed"
