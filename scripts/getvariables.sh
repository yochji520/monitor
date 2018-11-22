#!/bin/bash
#
#获取varibales,
#version:1.0，第一步阈值写死了，第二版将阈值写入存储，实现阈值动态调整

set -e 

source /home/youchuanjiang/monitor/conf/dbs.conf


#定义变量
table_open_cache=""
open_files_limit=""
max_connections=""


function getVariables(){
	INSADDRSS=$1
        #获取server服务参数：variables
        ${DBAPWD} -h${INSADDRSS} -N -e "show global variables;" > ../tmp/var.txt
        table_open_cache=`grep -iw 'table_open_cache' ../tmp/var.txt|awk -F ' ' '{print $2}'`
        open_files_limit=`grep -iw 'open_files_limit' ../tmp/var.txt|awk -F ' ' '{print $2}'`
        max_connections=`grep -iw 'max_connections' ../tmp/var.txt|awk -F ' ' '{print $2}'`
}





