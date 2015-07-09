# define variable and array
a=0
Files=("$@")

# comment out [*]
while [ $a -ne $# ]
do
	echo -e "%s/^.TEMP/*.TEMP/g\\nw" | ed - ${Files[$a]}
	echo -e "%s/^.OPTION/*.OPTION/g\\nw" | ed - ${Files[$a]}
	echo -e "%s/^.END/*.END/g\\nw" | ed - ${Files[$a]}
	echo -e "%s/^\+/*+/g\\nw" | ed - ${Files[$a]}
	a=`expr $a + 1`
done
