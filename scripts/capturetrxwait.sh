#!/bin/bash

set -e

source /home/youchuanjiang/monitor/conf/dbs.conf
source /home/youchuanjiang/monitor/scripts/sendmail.sh
source /home/youchuanjiang/monitor/scripts/getprocesslist.sh


#处理阻塞信息入库，
function getTrxWait(){
        INSTANCEID=$1
        INSADDRSS=$2
        CURRDATE=$3
        TITLE="【blocking_transactions】"
        CONENTTEXT="hostname:${INSADDRSS}.datetime:${CURRDATE},there_are_transactions_waits."
        BLOCKTRX=`echo "select count(*) from information_schema.innodb_lock_waits;"|${DBAPWD} -h${INSADDRSS} -N`
        if [[ ${BLOCKTRX} -gt 0 ]]
        then
                WAITTRXSQL="insert into monitor.capturetrxwait(instanceid,capturetime,trx_start,lock_table,lock_mode,lock_index,trx_id,trx_state,wait_start,trx_query,thread_id,killsql) select ${instanceid},now(),a.trx_started,c.lock_table,c.lock_mode,c.lock_index,b.blocking_trx_id as trx_id,a.trx_state,a.trx_wait_started,a.trx_query,a.trx_mysql_thread_id,concat('KILL ', a.trx_mysql_thread_id ,';') as killthrid from information_schema.innodb_trx a join information_schema.innodb_lock_waits b on b.blocking_trx_id=a.trx_id join information_schema.innodb_locks c on a.trx_id=c.lock_trx_id;commit;"
                ${ADMINPWD} -e "${WAITTRXSQL}"
                sendmail ${CONENTTEXT} ${TITLE}
	else 
		getProcessList ${INSTANCEID} ${INSADDRSS} "${CURRDATE}"
	fi
}

