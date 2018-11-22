#!/bin/bash
#
#main,脚本入口
#

source /home/youchuanjiang/monitor/scripts/capturestatus.sh
source /home/youchuanjiang/monitor/conf/dbs.conf

SLEEPTIME=60

function main(){
	while true;
	do
		getDbaddr
		sleep ${SLEEPTIME}
	done;
}

main
