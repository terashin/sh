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

## parametric resister


## parametric finger number


## parametric vcs
function mode_vcs()
{
	VCS=0.4
	X=1
	while [ $X -ne 0 ]
	do
		VCS=`echo "scale=2; $VCS + 0.1" | bc`
		cp -f $1.sp $1_vcs_$VCS.sp
		echo -e "%s/VVG.*/VVG VG 0 $VCS/g\\nw" | ed - $1_vcs_$VCS.sp
		echo "VCS=${VCS}V"
		echo "hspice $1_vcs_$VCS.sp > out"
		cmd_hspice $1_vcs_$VCS
		X=`echo "$VCS < 1.2" | bc`
	done
}

## parametric vin_clk
function mode_vin_clk()
{
	FMCLK=7
	while [ $FMCLK -ne 13 ]
	do
		FMCLKT=`echo "scale=2; (1000/$FMCLK)" | bc`
		cp -f $1.sp $1_fmclk_$FMCLK.sp
		echo -e "%s/^vinclk1.*/vinclk1 INP 0 pulse(0.8 1.2 0 0.03ps 0.03ps 0.06ps ${FMCLKT}ps)/g\\nw" | ed - $1_vcs_$FMCLK.sp
		echo -e "%s/^vinclk2.*/vinclk2 INN 0 pulse(1.2 0.8 0 0.03ps 0.03ps 0.06ps ${FMCLKT}ps)/g\\nw" | ed - $1_vcs_$FMCLK.sp
		echo "FMCLK=${FMCLK}GHz"
		echo "hspice $1_vcs_$FMCLK.sp > out"
		cmd_hspice $1_fmclk_$FMCLK
		FMCLK=`expr $FMCLK + 1`
	done
}

## parametric vin_ac


## parametric vin_dc


# main
## make directory
mkdir ac_result dc_result tr_result out_result
## edit arg name
temp=$1
temp=${#temp}
temp=`expr $temp - 3`
file=`echo $1 | cut -c 1-$temp`

## input mode

	echo "which number"
	echo "resister:1"
	echo "finger number:2"
	echo "vcs:3"
	echo "vin_clk:4"
	echo "vin_ac:5"
	echo "vin_dc:6"
	read mode

#run resister mode

## run finger number mode

## run vcs mode
if test $mode -eq 3;
then
	mode_vcs $file
fi

## run vin_clk mode

if test $mode -eq 4;
then
	mode_vin_clk $file
fi

## run vin_ac mode

## run vin_dc mode

## arrange files
mv *.ac* ./ac_result/
mv *.sw* ./dc_result/
mv *.tr* ./tr_result/

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
