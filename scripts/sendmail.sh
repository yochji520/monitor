#!/bin/bash
#
#发送邮件
#

set -e

source /home/youchuanjiang/monitor/conf/dbs.conf

function sendmail(){
	conenttext=$1
	title=$2
	receivednames=`echo "select email from monitor.user;"|${ADMINPWD} -N`
	for receivename in ${receivednames}
	do
		echo "${conenttext}"|mail -s "${title}" ${receivename}
	done
}
