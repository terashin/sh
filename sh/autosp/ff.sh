#!/bin/sh

# define variable and array
Files=("$@")
TIME_ST_temp=`date +%s`
TIME_ST=`date '+%y/%m/%d %H:%M:%S'`

# define functions
## run simulator "hspice filename > out"
function cmd_hspice()
{
	hspice $1.sp > ./out_result/$1
	rm -f $1.ic* $1.pa* $1.st* $1.sp
}

## parametric vin_clk
function mode_vin_clk()
{
		cp -f $1.sp $1_20Gbps.sp
		cp -f $1.sp $1_22Gbps.sp
		cp -f $1.sp $1_22.5Gbps.sp
		cp -f $1.sp $1_28Gbps.sp
		cp -f $1.sp $1_30Gbps.sp
		echo -e "%s/^vinclk1.*/vinclk1 INP 0 pulse(0.8 1.2 0 0.03ps 0.03ps 0.06ps ${FMCLKT}ps)/g\\nw" | ed - $1_vcs_$FMCLK.sp
		echo -e "%s/^vinclk2.*/vinclk2 INN 0 pulse(1.2 0.8 0 0.03ps 0.03ps 0.06ps ${FMCLKT}ps)/g\\nw" | ed - $1_vcs_$FMCLK.sp
		echo "hspice $1_20Gbps.sp > out"
		cmd_hspice $1_20Gbps
}

# main
## edit arg name
temp=$1
temp=${#temp}
temp=`expr $temp - 3`
file=`echo $1 | cut -c 1-$temp`

mode_vin_clk $file

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
