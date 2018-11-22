#!/bin/bash
#
#
#

set -e 

source /home/youchuanjiang/monitor/conf/dbs.conf

#查看当前打开的表情况
function openTables(){
	INSTANCEID=$1
        INSADDRSS=$2
        CURRDATE=$3
	LOGDIR=${BASELOGDIR}/${INSTANCEID} && mkdir -p ${LOGDIR}
        LOGFILE=${LOGDIR}/opentables.log
	echo "==============================================================${CURRDATE}================================================================" >> ${LOGFILE}
	${DBAPWD} -h${INSADDRSS} -e "show open tables where in_use > 0 or name_locked > 0;" >> ${LOGFILE}
	#记录日志，记录日志文件目录
	LOGSQL="insert into monitor.opentablelog(currtime,instanceid,logfile) values('${CURRDATE}',${INSTANCEID},'${LOGFILE}');"
	${ADMINPWD}  -e "${LOGSQL}"	
	
}



