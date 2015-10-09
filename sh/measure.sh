##!/bin/sh

# define variable and array
mres=$(find -name "*.mres")
TIME_ST_temp=`date +%s`
TIME_ST=`date '+%y/%m/%d %H:%M:%S'`

# replace csv
for e in ${mres[@]}; do
	sed -e '1i'${e}'' -i ${e}
	sed -i -e '/At/d' ${e}
	sed -i -e '/^$/d' ${e}
	echo -e "%s/)//g\\nw" | ed - ${e}
	echo -e "%s/(//g\\nw" | ed - ${e}
	mv ${e} ${e%.mres}.csv
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
echo "${H}h:${M}m:${S}s time passed"!/bin/sh
