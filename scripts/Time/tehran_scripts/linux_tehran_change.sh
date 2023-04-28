#!/bin/bash
#########################VARIABLE##################
MT=`who am i |awk '{print $2}'`
HOSTNAME=`hostname|tr '[:upper:]' '[:lower:]'`
##################################################
########################Functions##################
killsess() {
for OT in `who|awk '{print $2}'|grep -v $MT`
    do
      pkill -KILL -t $OT
    done

if (test ! `who|awk '{print $2}'|grep -v $MT`)
  then
     echo "There is not any other session"
else
     echo "There are some open session!!!!!"
fi
echo "Press any key to exit...."
read a
pkill -KILL -t $MT
}
#change OS TZ Configuration file
change_tz(){
      if [ -f /etc/timezone ] 
      then
         sed -i '/TZ/d' /etc/timezone
         echo 'export TZ="Asia/Tehran"'>>/etc/timezone
         cp /usr/share/zoneinfo/Asia/Tehran /etc/localtime
         echo "/etc/timezone changed..."
      else
         touch /etc/timezone
         echo -e '#!/bin/bash\n'>>/etc/timezone 
         echo 'export TZ="Asia/Tehran"'>>/etc/timezone
         cp /usr/share/zoneinfo/Asia/Tehran /etc/localtime
         echo 'source /etc/timezone'>>/etc/profile
         echo "/etc/timezone changed..."
      fi
      sed -i '/TIMEZONE/d' /etc/sysconfig/clock
      echo 'TIMEZONE="Asia/Tehran"'>>/etc/sysconfig/clock
      echo 'DEFAULT_TIMEZONE="Asia/Tehran"'>>/etc/sysconfig/clock
      echo "/etc/sysconfig/clock changed"
}
#Change Oracle RAC configuration file 
change_oracletz(){
      if [ -f /u01/crs/oracle/product/11gr2/crs/install/s_crsconfig_"$HOSTNAME"_env.txt ]
      then
        T=`grep -n "TZ=" /u01/crs/oracle/product/11gr2/crs/install/s_crsconfig_"$HOSTNAME"_env.txt|cut -d: -f1`
        sed -i "$T"c\ 'TZ=Asia/Tehran' /u01/crs/oracle/product/11gr2/crs/install/s_crsconfig_"$HOSTNAME"_env.txt
        echo "/u01/crs/oracle/product/11gr2/crs/install/s_crsconfig_"$HOSTNAME"_env.txt changed"
      else 
        echo "/u01/crs/oracle/product/11gr2/crs/install/s_crsconfig_"$HOSTNAME"_env.txt does not exists!"
      fi   
      if [ -f /u01/crs/oracle/product/11gr2/crs/install/crsconfig_params ]
      then
        T=`grep -n "TZ=" /u01/crs/oracle/product/11gr2/crs/install/crsconfig_params|cut -d: -f1`
        sed -i "$T"c\ 'TZ=Asia/Tehran' /u01/crs/oracle/product/11gr2/crs/install/crsconfig_params
        echo "/u01/crs/oracle/product/11gr2/crs/install/crsconfig_params changed"
      else
        echo "/u01/crs/oracle/product/11gr2/crs/install/crsconfig_params does not exists!"
      fi
}

#####################Main Body#######################
change_tz
change_oracletz
killsess
