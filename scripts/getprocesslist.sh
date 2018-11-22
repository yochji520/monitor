#!/bin/bash
#
#获取processlist信息，写入日志文件
#

set -e

source /home/youchuanjiang/monitor/conf/dbs.conf

#获取连接信息，写日志文件，同时将写日志的信息记录入库,表名：printprocesslog
function getProcessList(){
	INSTANCEID=$1
        INSADDRSS=$2
        CURRDATE=$3
	LOGDIR=${BASELOGDIR}/${INSTANCEID} && mkdir -p ${LOGDIR}
        LOGFILE=${LOGDIR}/processlist.log
	${DBAPWD} -h${INSADDRSS} -e "select '${CURRDATE}' as currtime, a.* from information_schema.processlist a;" >> ${LOGFILE}
	#记录日志，记录日志文件目录
	LOGSQL="insert into monitor.printprocesslog(currtime,instanceid,logfile) values('${CURRDATE}',${INSTANCEID},'${LOGFILE}');"
	${ADMINPWD}  -e "${LOGSQL}"
}

	







