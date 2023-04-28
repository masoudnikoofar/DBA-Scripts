#!/bin/ksh
#################################################################################
#/u01/crs/oracle/product/11gr2/crs/install/crsconfig_params
#/u01/crs/oracle/product/11gr2/crs/install/s_crsconfig_"$racname"_env.txt
#/usr/lib/tztab
#/etc/TIMEZONE
#/etc/default/tz
#################################################################################

linenum=0
crsparam="/u01/crs/oracle/product/11gr2/crs/install/crsconfig_params"
linenum=`grep -n 'TZ=' $crsparam|cut -f 1 -d ':'`

if [ "$linenum" != "" ]
then
if [ $linenum -gt 1 ]
then
   let "linenum = linenum - 1"
   head -$linenum $crsparam >/tmp/crs_params.temp
   echo "TZ=IRST-3:30IRDT" >>/tmp/crs_params.temp
   let "linenum = linenum + 2"
   tail -n +$linenum $crsparam>>/tmp/crs_params.temp
   cp /tmp/crs_params.temp $crsparam
   echo "$crsparam found and changed"
else
   echo
fi
fi

#################################################################################
#################################################################################

racname=`hostname | awk '{print tolower($0)}'`
crsenvfile="/u01/crs/oracle/product/11gr2/crs/install/s_crsconfig_"$racname"_env.txt"
ls $crsenvfile 1>/dev/null 2>&1
if [ $? -ne 0 ]
then
   if [ -d "/u01/crs/oracle/product/11gr1" ]
   then
      echo "oracle release 11gr1"
   else
      echo "$crsenvfile not found"
      echo "exit"
      exit
   fi
else
   linenum=`grep -n 'TZ=' $crsenvfile|cut -f 1 -d ':'`
   let "linenum = linenum - 1"
   head -$linenum $crsenvfile >/tmp/s_crsconfig.temp
   echo "TZ=IRST-3:30IRDT" >>/tmp/s_crsconfig.temp
   let "linenum = linenum + 2"
   tail -n +$linenum $crsenvfile>>/tmp/s_crsconfig.temp
   cp /tmp/s_crsconfig.temp $crsenvfile
   echo "$crsenvfile found and changed"
fi

#################################################################################
#################################################################################

if [ -f /usr/lib/tztab ]
then
   grep -i iran /usr/lib/tztab 1>/dev/null 2>&1
   if [ $? -eq 0 ]
   then
	echo "Iran timezone previously set"
   else

#########################################################

echo "
#
# Time zone for Iran (Iran Standard Time, Iran Daylight Time)
#

IRST-3:30IRDT
0 1  22 3 2013-2015 0-6 IRDT-4:30
0 23 21 9 2013-2015 0-6 IRST-3:30
0 1  21 3 2016	    0-6 IRDT-4:30
0 23 20 9 2016	    0-6 IRST-3:30
0 1  22 3 2017-2019 0-6 IRDT-4:30
0 23 21 9 2017-2019 0-6 IRST-3:30
0 1  21 3 2020	    0-6 IRDT-4:30
0 23 20 9 2020	    0-6 IRST-3:30
0 1  22 3 2021-2023 0-6 IRDT-4:30
0 23 21 9 2021-2023 0-6 IRST-3:30
0 1  21 3 2024	    0-6 IRDT-4:30
0 23 20 9 2024	    0-6 IRST-3:30
0 1  22 3 2025-2027 0-6 IRDT-4:30
0 23 21 9 2025-2027 0-6 IRST-3:30
0 1  21 3 2028	    0-6 IRDT-4:30
0 23 20 9 2028	    0-6 IRST-3:30
" >> /usr/lib/tztab

echo "IRST-3:30IRDT" > /etc/default/tz

echo "#!/sbin/sh
# @(#)B.11.31_LR        
TZ=IRST-3:30IRDT
export TZ" > /etc/TIMEZONE

#########################################################

        echo "/usr/lib/tztab  found and changed"
        echo "/etc/TIMEZONE   found and changed"
        echo "/etc/default/tz found and changed"
   fi
else
   echo "/usr/lib/tztab not found"
   echo "exit"
   exit
fi

#################################################################################
#################################################################################
MT=`who am i|awk '{print $2}'`
for OT in `who|awk '{print $2}'|grep -v $MT`
do
   pkill -KILL -t $OT
done
echo "TIMEZONE Setting Is Finished [Press ENTER]"
read
pkill -KILL -t $MT

