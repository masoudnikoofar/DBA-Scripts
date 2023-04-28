# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
# User specific environment and startup programs
export ORACLE_BASE=/u01/app/grid_base
export ORACLE_HOME=/u01/app/grid
export ORA_NLS33=$ORACLE_HOME/ocommon/nls/admin/data
export TNS_ADMIN=$ORACLE_HOME/network/admin
export ORACLE_DOC=$ORACLE_HOME/doc
export NLS_LANG=AMERICAN_AMERICA.AR8MSWIN1256
export TMPDIR=/tmp
export TMP=/tmp
export TZ=Asia/Tehran
export ORACLE_SID=+ASM2
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORACLE_HOME/gg
export ORACLE_UNQNAME=dbtest
export ORACLE_HOSTNAME=dbtestnode2.enb.local
export PATH=$PATH:/bin:/usr/bin:/usr/local/bin/OPatch:$ORACLE_HOME/bin:/usr/bin/X11:/usr/local/bin:/usr/sbin::/sbin:.
export OWB_HOME=$ORACLE_HOME
unset USERNAME
echo ".profile has been DONE successfully"

