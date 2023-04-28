# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
ORACLE_BASE=/u01/app/oracle
export ORACLE_BASE

ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1
export ORACLE_HOME

ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data
export ORA_NLS33


TNS_ADMIN=$ORACLE_HOME/network/admin
export TNS_ADMIN


ORACLE_DOC=$ORACLE_HOME/doc
export ORACLE_DOC

NLS_LANG=AMERICAN_AMERICA.AR8MSWIN1256
export NLS_LANG

TMPDIR=/tmp
export TMPDIR

TMP=/tmp
export TMP

TZ=Asia/Tehran
export TZ

ORACLE_SID=dbtestn
export ORACLE_SID

LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORACLE_HOME/gg
export LD_LIBRARY_PATH

ORACLE_UNQNAME=dbtestn
export ORACLE_UNQNAME

ORACLE_HOSTNAME=S1VLDBAMAR01.enb.local
export ORACLE_HOSTNAME

PATH=$PATH:/bin:/usr/bin:/usr/local/bin/OPatch:$ORACLE_HOME/bin:/usr/bin/X11:/usr/local/bin:/usr/sbin::/sbin:.
export PATH
export PATH=$PATH:$ORACLE_HOME/OPatch
unset USERNAME


OWB_HOME=$ORACLE_HOME
export ORACLE_HOME

DISPLAY=172.50.251.168:1.0
export DISPLAY

echo ".profile has been DONE successfully"

