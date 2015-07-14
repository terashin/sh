#!/bin/sh

# define variable and array
a=0
b=0
Files=("$@")
TIME_ST_temp=`date +%s`
TIME_ST=`date '+%y/%m/%d %H:%M:%S'`

# define functions
## run simulator "hspice filename > out"
function cmd_hspice()
{
	hspice $1 > ./out/$1
	rm -f $1.ic* $1.pa* $1.st*
}

function mode_vcs()
{
	VCS=0.5
	while [ $i -ne 6 ]
	do
		echo "hspice $1.sp > out"
		cmd_hspice $1
		i=`expr $i+1`
		vcs=`expr $vcs + 0.1`
	done

}


# main
## make directory
mkdir ac dc tr out

## input mode

	echo "which number"
	echo "resister:1"
	echo "finger number:2"
	echo "vcs:3"
	read mode

if [mode -eq 3] then;
	mode_vcs $1
fi

while [ $a -ne $# ]
do
	sh hspice.sh ${Files[$a]}
	a=`expr $a + 1`
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


