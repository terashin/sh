#!/bin/sh

# define variable and array
TIME_ST_temp=`date +%s`
TIME_ST=`date '+%y/%m/%d %H:%M:%S'`

# define functions
## run simulator "hspice filename > out"
function cmd_hspice()
{
	echo "hspice $1.sp > ./out_result/$1"
	hspice $1.sp > ./out_result/$1
	rm -f $1.ic* $1.pa* $1.st*
}

## parametric vin_clk
function mode_vin_clk()
{
		cp -f $1.sp $1_20Gbps.sp
		cp -f $1.sp $1_22Gbps.sp
		cp -f $1.sp $1_25Gbps.sp
		cp -f $1.sp $1_28Gbps.sp
		cp -f $1.sp $1_30Gbps.sp

		### DATA-20Gbps-CLK-20GHz
		echo -e "%s/^vindatap.*/vindatap DIN 0 pulse( 0.8 1.2 0 10ps 10ps 40ps 100ps)/g\\nw" | ed - $1_20Gbps.sp
		echo -e "%s/^vindatan.*/vindatan DINN 0 pulse( 1.2 0.8 0 10ps 10ps 40ps 100ps)/g\\nw" | ed - $1_20Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 15ps 50ps)/g\\nw" | ed - $1_20Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 15ps 50ps)/g\\nw" | ed - $1_20Gbps.sp
		cmd_hspice $1_20Gbps
		
		### DATA-22Gbps-CLK-22GHz
		echo -e "%s/^vindatap.*/vindatap DIN 0 pulse( 0.8 1.2 0 10ps 10ps 35ps 90ps)/g\\nw" | ed - $1_22Gbps.sp
		echo -e "%s/^vindatan.*/vindatan DINN 0 pulse( 1.2 0.8 0 10ps 10ps 35ps 90ps)/g\\nw" | ed - $1_22Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 12.5ps 45ps)/g\\nw" | ed - $1_22Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 12.5ps 45ps)/g\\nw" | ed - $1_22Gbps.sp
		cmd_hspice $1_22Gbps
		
		### DATA-25Gbps-CLK-25GHz
		echo -e "%s/^vindatap.*/vindatap DIN 0 pulse( 0.8 1.2 0 10ps 10ps 30ps 80ps)/g\\nw" | ed - $1_25Gbps.sp
		echo -e "%s/^vindatan.*/vindatan DINN 0 pulse( 1.2 0.8 0 10ps 10ps 30ps 80ps)/g\\nw" | ed - $1_25Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 10ps 40ps)/g\\nw" | ed - $1_25Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 10ps 40ps)/g\\nw" | ed - $1_25Gbps.sp
		cmd_hspice $1_25Gbps

		### DATA-28Gbps-CLK-28GHz
		echo -e "%s/^vindatap.*/vindatap DIN 0 pulse( 0.8 1.2 0 10ps 10ps 25ps 70ps)/g\\nw" | ed - $1_28Gbps.sp
		echo -e "%s/^vindatan.*/vindatan DINN 0 pulse( 1.2 0.8 0 10ps 10ps 25ps 70ps)/g\\nw" | ed - $1_28Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 7.5ps 35ps)/g\\nw" | ed - $1_28Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 7.5ps 35ps)/g\\nw" | ed - $1_28Gbps.sp
		cmd_hspice $1_28Gbps

		### DATA-30Gbps-CLK-30GHz
		echo -e "%s/^vindatap.*/vindatap DIN 0 pulse( 0.8 1.2 0 10ps 10ps 23ps 66ps)/g\\nw" | ed - $1_30Gbps.sp
		echo -e "%s/^vindatan.*/vindatan DINN 0 pulse( 1.2 0.8 0 10ps 10ps 23ps 66ps)/g\\nw" | ed - $1_30Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 6.5ps 33ps)/g\\nw" | ed - $1_30Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 6.5ps 33ps)/g\\nw" | ed - $1_30Gbps.sp
		cmd_hspice $1_30Gbps

}

## parametric vin_ran
function mode_vin_ran()
{
		cp -f $1.sp $1_20Gbps.sp
		cp -f $1.sp $1_22Gbps.sp
		cp -f $1.sp $1_25Gbps.sp
		cp -f $1.sp $1_28Gbps.sp
		cp -f $1.sp $1_30Gbps.sp

		### DATA-20Gbps-CLK-20GHza
		echo -e "%s/tc=.*/tc=40p/g\\nw" | ed - $1_20Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 15ps 50ps)/g\\nw" | ed - $1_20Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 15ps 50ps)/g\\nw" | ed - $1_20Gbps.sp
		cmd_hspice $1_20Gbps
		
		### DATA-22Gbps-CLK-22GHz
		echo -e "%s/tc=.*/tc=35p/g\\nw" | ed - $1_22Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 12.5ps 45ps)/g\\nw" | ed - $1_22Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 12.5ps 45ps)/g\\nw" | ed - $1_22Gbps.sp
		cmd_hspice $1_22Gbps
		
		### DATA-25Gbps-CLK-25GHz
	#	echo -e "%s/tc=.*/tc=30p/g\\nw" | ed - $1_25Gbps.sp
	#	echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 10ps 40ps)/g\\nw" | ed - $1_25Gbps.sp
	#	echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 10ps 40ps)/g\\nw" | ed - $1_25Gbps.sp
	#	cmd_hspice $1_25Gbps

		### DATA-28Gbps-CLK-28GHz
		echo -e "%s/tc=.*/tc=25p/g\\nw" | ed - $1_28Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 7.5ps 35ps)/g\\nw" | ed - $1_28Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 7.5ps 35ps)/g\\nw" | ed - $1_28Gbps.sp
		cmd_hspice $1_28Gbps

		### DATA-30Gbps-CLK-30GHz
		echo -e "%s/tc=.*/tc=23p/g\\nw" | ed - $1_30Gbps.sp
		echo -e "%s/^vinclkp.*/vinclkp CLK 0 pulse( 0.8 1.2 clk_st 10ps 10ps 6.5ps 33ps)/g\\nw" | ed - $1_30Gbps.sp
		echo -e "%s/^vinclkn.*/vinclkn CLKN 0 pulse( 1.2 0.8 clk_st 10ps 10ps 6.5ps 33ps)/g\\nw" | ed - $1_30Gbps.sp
		cmd_hspice $1_30Gbps

}


# main
mkdir tr_result out_result
## edit arg name
temp=$1
temp=${#temp}
temp=`expr $temp - 3`
file=`echo $1 | cut -c 1-$temp`

#mode_vin_clk $file
mode_vin_ran $file

mv *.tr* tr_result/

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
