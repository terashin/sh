#!/bin/sh

# define variable and array
Files=("$@")
TIME_ST_temp=`date +%s`
TIME_ST=`date '+%y/%m/%d %H:%M:%S'`

# define functions
## run simulator "hspice filename > out"
function cmd_hspice()
{
	hspice $1.sp > out
	rm -f $1.ic* $1.pa* $1.st* $1.sp
}

# main
## edit arg name
temp=$1
temp=${#temp}
temp=`expr $temp - 3`
file=`echo $1 | cut -c 1-$temp`

aaa=2
	while [ $aaa -le 135 ]
	do
		cp ${file}.sp ${file}_aaa_$aaa.sp
		echo -e "%s/aaa=.*/aaa=${aaa}e-6/g\\nw" | ed - ${file}_aaa_$aaa.sp
		echo "aaa=${aaa}e-6"
		echo "hspice ${file}_aaa_$aaa.sp > out"
		cmd_hspice ${file}_aaa_$aaa
		aaa=`expr $aaa + 20`
	done

## measure time
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
