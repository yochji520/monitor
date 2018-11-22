#!/bin/bash
#
#获取status信息,判断连接信息是否正常，
#

set -e 

source /home/youchuanjiang/monitor/conf/dbs.conf
source /home/youchuanjiang/monitor/scripts/getprocesslist.sh
source /home/youchuanjiang/monitor/scripts/capturetrxwait.sh
source /home/youchuanjiang/monitor/scripts/getstatus.sh
source /home/youchuanjiang/monitor/scripts/getvariables.sh
source /home/youchuanjiang/monitor/scripts/getopentables.sh

#获取实例连接信息
function getDbaddr(){
        SQL="use monitor;select insadress from monitor.dbinstance;"
        CONNS=`${ADMINPWD} -N -e "${SQL}"`
        for CONN in ${CONNS}
        do
		echo $CONN
		DATETIME=`date '+%Y-%m-%d %H:%M:%S'`
                opStatus ${CONN} "${DATETIME}"
        done	
}		
		
#获取所有状态信息，
function opStatus(){
	INSADDRSS=$1
	CURRDATE=$2
        INSTANCEID=`echo "select instanceid from monitor.dbinstance where insadress='${INSADDRSS}'"|${ADMINPWD} -N`
	getVariables ${INSADDRSS} "${CURRDATE}" ${INSTANCEID}
	getStatus ${INSADDRSS} "${CURRDATE}" ${INSTANCEID}
	#判断连接是否异常是否异常
	ALARMMAXCONN=`echo "${max_connections} * 0.2 "|bc`
	MAXCONNBULE=$(echo "$Threads_connected > $ALARMMAXCONN")|bc
	if [[ ${MAXCONNBULE} -eq 1 ]]
	then
		TITLE="【too_many_connections.】"
	        CONENTTEXT="hostname:${INSADDRSS},datetime:${CURRDATE},too_many_connections."
		getTrxWait ${INSTANCEID} ${INSADDRSS} "${CURRDATE}"
		sendmail ${CONENTTEXT} ${TITLE}
		
	fi		
	#判断打开的表
	ALARMOPENTABLE=`echo "${open_files_limit} * 0.4"|bc`
	OPENTABLEBULE=$(echo "$Open_files > $ALARMOPENTABLE")|bc
	if [[ ${OPENTABLEBULE} -eq 1 ]]
	then
		TITLE="【open_too_many_tables.】"
                CONENTTEXT="hostname:${INSADDRSS},datetime:${CURRDATE},open_too_many_tables."
		getProcessList ${INSTANCEID} ${INSADDRSS} "${CURRDATE}"
		openTables $[INSTANCEID] ${INSADDRSS} "${CURRDATE}"
		sendmail ${CONENTTEXT} ${TITLE}
	fi
	#判断缓存表
	ALARMTABLECACHE=`echo "${table_open_cache} * 0.3"|bc`
	TABLECACHEBULE=$(echo "$Open_files > $ALARMTABLECACHE")|bc
	if [[ ${TABLECACHEBULE} -eq 1 ]]
	then
                TITLE="【Too_many_cached_tables.】"
                CONENTTEXT="hostname:${INSADDRSS},datetime:${CURRDATE},Too_many_cached_tables."
		getProcessList ${INSTANCEID} ${INSADDRSS} "${CURRDATE}"
		sendmail ${CONENTTEXT} ${TITLE}
	fi	
	
}			
