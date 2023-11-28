free -g 
#At least 8 GB RAM for Oracle Grid Infrastructure installations.
#SWAP: Between 4 GB and 16 GB: Equal to RAM 
#      More than 16 GB: 16 GB
grep MemTotal /proc/meminfo
grep SwapTotal /proc/meminfo



df -h /tmp
df -h /dev/shm




uname -a
cat /etc/*release
#Oracle Linux 7.4 with the Unbreakable Enterprise Kernel 4: 4.1.12-112.16.7.el7uek.x86_64 or later
#Oracle Linux 7.4 with the Unbreakable Enterprise Kernel 5: 4.14.35-1818.1.6.el7uek.x86_64 or later
#Oracle Linux 7.4 with the Red Hat Compatible kernel: 3.10.0-693.5.2.0.1.el7.x86_64 or later

df -h
#12 GB (100G) = Oracle Grid Infrastructure for a cluster home (Grid home). 
#10 GB = Oracle Database Enterprise Edition.





yum install oracle-database-preinstall-19c

#vi /var/log/oracle-database-preinstall-19c/backup/[..........]/orakernel.log


yum install -y bc
yum install -y binutils
yum install -y compat-libcap1
yum install -y compat-libstdc++*
yum install -y dtrace-modules
yum install -y dtrace-modules-headers
yum install -y dtrace-modules-provider-headers
yum install -y dtrace-utils
yum install -y elfutils-libelf
yum install -y elfutils-libelf-devel
yum install -y fontconfig-devel
yum install -y glibc
yum install -y glibc-devel
yum install -y ksh
yum install -y libaio
yum install -y libaio-devel
yum install -y libdtrace-ctf-devel
yum install -y libXrender
yum install -y libXrender-devel
yum install -y libX11
yum install -y libXau
yum install -y libXi
yum install -y libXtst
yum install -y libgcc
yum install -y librdmacm-devel
yum install -y libstdc++
yum install -y libstdc++-devel
yum install -y libxcb
yum install -y make
yum install -y net-tools #(for Oracle RAC and Oracle Clusterware)
yum install -y nfs-utils #(for Oracle ACFS)
yum install -y python #(for Oracle ACFS Remote)
yum install -y python-configshell #(for Oracle ACFS Remote)
yum install -y python-rtslib #(for Oracle ACFS Remote)
yum install -y python-six #(for Oracle ACFS Remote)
yum install -y targetcli #(for Oracle ACFS Remote)
yum install -y smartmontools
yum install -y sysstat
yum install -y kmod
yum install -y kmod-libs





rpm -qi cvuqdisk
rpm -e cvuqdisk# if exists
CVUQDISK_GRP=oinstall;
export CVUQDISK_GRP
rpm -iv cvuqdisk-1.0.10-1.rpm #Grid_home/cv/rpm




cat /sys/kernel/mm/transparent_hugepage/enabled
vi /etc/default/grub
transparent_hugepage=never
grub2-mkconfig -o /boot/grub2/grub.cfg








groupadd oinstall
groupadd dba
groupadd asmdba
groupadd asmoper
groupadd asmadmin
groupadd oper
groupadd backupdba
groupadd dgdba
groupadd kmdba
groupadd racdba



useradd -g oinstall -G dba,asmdba,backupdba,dgdba,kmdba,racdba oracle
usermod -g oinstall -G dba,asmdba,backupdba,dgdba,kmdba,racdba,oper oracle
useradd -g oinstall -G asmadmin,asmdba,racdba,asmoper grid
usermod -g oinstall -G asmadmin,asmdba,racdba,asmoper grid


vi /etc/ssh/sshd_config -> LoginGraceTime 0



#mkdir -p /u01/app/19/grid
mkdir -p /u01/app/grid
mkdir -p /u01/app/grid_base
mkdir -p /u01/app/oracle
mkdir -p /u01/app/oracle/product/19c/dbhome_1/
chown -R grid:oinstall /u01
chown oracle:oinstall /u01/app/oracle
#chmod -R 775 /u01/





mkdir -p /u01/app/grid
mkdir -p /u01/app/grid_base
chown -R oracle:oinstall /u01/app/
unzip LINUX.X64_193000_grid_home.zip -d /u01/app/grid/
rpm -ivh /u01/app/grid/cv/rpm/cvuqdisk-1.0.10-1.rpm
crsctl stat res -t


oracleasm configure -i
grid
asmadmin
y
y


systemctl enable oracleasm.service
systemctl start oracleasm.service
systemctl restart oracleasm.service





./runcluvfy.sh comp nodereach -n dbtestnode1,dbtestnode2 -verbose
./runcluvfy.sh stage -pre crsinst -n dbtestnode1,dbtestnode2 -verbose