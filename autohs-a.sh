#!/bin/sh

# define variable and array
sp=$(find -name "*.sp")
TIME_ST_temp=`date +%s`
TIME_ST=`date '+%y/%m/%d %H:%M:%S'`
i=0

# run simulator "hspice filename > out"
for e in ${sp[@]}; do
     echo "hspice ${e} > out"
     hspice ${e} > out
     let i++
done

# measure time
TIME_ED_temp=`date +%s`   #B
TIME_ED=`date '+%y/%m/%d %H:%M:%S'`
PT=`expr ${TIME_ED_temp} - ${TIME_ST_temp}`
H=`expr ${PT} / 3600`
PT=`expr ${PT} % 3600`
M=`expr ${PT} / 60`
S=`expr ${PT} % 60`
echo "${TIME_ST} START"
echo "${TIME_ED} END"
echo "${H}h:${M}m:${S}s time passed"
