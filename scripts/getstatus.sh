#!/bin/bash
#
#获取status信息
#

set -e 

source /home/youchuanjiang/monitor/conf/dbs.conf

#声明变量

#innodb_log
Innodb_log_waits=""
Innodb_log_write_requests=""
Innodb_log_writes=""
Innodb_os_log_fsyncs=""
Innodb_os_log_pending_fsyncs=""
Innodb_os_log_pending_writes=""
Innodb_os_log_written=""

#innodb_buffer
Innodb_buffer_pool_pages_data=""
Innodb_buffer_pool_pages_misc=""
Innodb_buffer_pool_wait_free=""
Innodb_buffer_pool_pages_dirty=""
Innodb_buffer_pool_pages_flushed=""
Innodb_buffer_pool_reads=""
Innodb_buffer_pool_read_requests=""
Innodb_buffer_pool_write_requests=""

#innodb_page
Innodb_page_size=""
Innodb_pages_created=""
Innodb_pages_read=""
Innodb_pages_written=""

#innodb_row
Innodb_rows_deleted=""
Innodb_rows_inserted=""
Innodb_rows_read=""
Innodb_rows_updated=""

#innodb_lock
Innodb_row_lock_current_waits=""
innodb_row_lock_time=""
Innodb_row_lock_time_avg=""
Innodb_row_lock_time_max=""
Innodb_row_lock_waits=""

#table_lock
Table_locks_waited=""
Table_locks_immediate=""

#slowlog
Slow_queries=""
Slow_launch_threads=""

#com_operations 
Com_select=""
Com_update=""
Com_insert=""
Com_delete=""

#throughput吞吐量
TPS=""
QPS=""
Bytes_received=""
Bytes_send=""

#sort
#Sort_scan=""
#Sort_rows=""
#Sort_range=""
#Sort_merge_passes=""

#opentables
Open_files=""
Open_table_definitions=""
Open_tables=""
Table_open_cache_hits=""
Table_open_cache_misses=""
Table_open_cache_overflows=""

#thread
Threads_running=""
Threads_created=""
Threads_connected=""
Threads_cached=""


#获取变量
function getStatus(){
	INSADDRSS=$1
	CURRDATE=$2
        INSTANCEID=$3
        #获取两秒之间的数值
        ${DBAPWD} -h${INSADDRSS} -N -e "show global status" > ../tmp/status.txt
        sleep 1                  
        ${DBAPWD} -h${INSADDRSS} -N -e "show global status" > ../tmp/status2.txt
        #获取需要监控的状态值
	#innodb_log
	Innodb_log_waits=`grep -iw 'Innodb_log_waits' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_log_write_requests1=`grep -iw 'Innodb_log_write_requests' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_log_write_requests2=`grep -iw 'Innodb_log_write_requests' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_log_writes1=`grep -iw 'Innodb_log_writes' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_log_writes2=`grep -iw 'Innodb_log_writes' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_os_log_fsyncs1=`grep -iw 'Innodb_os_log_fsyncs' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_os_log_fsyncs2=`grep -iw 'Innodb_os_log_fsyncs' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_os_log_pending_fsyncs1=`grep -iw 'Innodb_os_log_pending_fsyncs' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_os_log_pending_fsyncs2=`grep -iw 'Innodb_os_log_pending_fsyncs' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_os_log_pending_writes1=`grep -iw 'Innodb_os_log_pending_writes' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_os_log_pending_writes2=`grep -iw 'Innodb_os_log_pending_writes' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_os_log_written1=`grep -iw 'Innodb_os_log_written' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_os_log_written2=`grep -iw 'Innodb_os_log_written' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#innodb_buffer
	Innodb_buffer_pool_pages_data=`grep -iw 'Innodb_buffer_pool_pages_data' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_buffer_pool_pages_dirty=`grep -iw 'Innodb_buffer_pool_pages_dirty' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_buffer_pool_pages_flushed=`grep -iw 'Innodb_buffer_pool_pages_flushed' ../tmp/status.txt|awk -F ' ' '{print $2}'`
        Innodb_buffer_pool_wait_free=`grep -iw 'Innodb_buffer_pool_wait_free' ../tmp/status.txt|awk -F ' ' '{print $2}'`
        Innodb_buffer_pool_pages_misc=`grep -iw 'Innodb_buffer_pool_pages_misc' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_buffer_pool_read_requests1=`grep -iw 'Innodb_buffer_pool_read_requests' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_buffer_pool_read_requests2=`grep -iw 'Innodb_buffer_pool_read_requests' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_buffer_pool_reads1=`grep -iw 'Innodb_buffer_pool_reads' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_buffer_pool_reads2=`grep -iw 'Innodb_buffer_pool_reads' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_buffer_pool_write_requests1=`grep -iw 'Innodb_buffer_pool_write_requests' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_buffer_pool_write_requests2=`grep -iw 'Innodb_buffer_pool_write_requests' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#innodb_page
	Innodb_page_size1=`grep -iw 'Innodb_page_size' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_page_size2=`grep -iw 'Innodb_page_size' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_pages_created1=`grep -iw 'Innodb_pages_created' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_pages_created2=`grep -iw 'Innodb_pages_created' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_pages_read1=`grep -iw 'Innodb_pages_read' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_pages_read2=`grep -iw 'Innodb_pages_read' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_pages_written1=`grep -iw 'Innodb_pages_written' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_pages_written2=`grep -iw 'Innodb_pages_written' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#innodb_rows
	Innodb_rows_deleted1=`grep -iw 'Innodb_rows_deleted' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_rows_deleted2=`grep -iw 'Innodb_rows_deleted' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_rows_inserted1=`grep -iw 'Innodb_rows_inserted' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_rows_inserted2=`grep -iw 'Innodb_rows_inserted' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_rows_read1=`grep -iw 'Innodb_rows_read' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_rows_read2=`grep -iw 'Innodb_rows_read' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_rows_updated1=`grep -iw 'Innodb_rows_updated' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_rows_updated2=`grep -iw 'Innodb_rows_updated' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#innodb_lock
	Innodb_row_lock_current_waits=`grep -iw 'Innodb_row_lock_current_waits' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	innodb_row_lock_time1=`grep -iw 'innodb_row_lock_time' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	innodb_row_lock_time2=`grep -iw 'innodb_row_lock_time' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Innodb_row_lock_time_avg=`grep -iw 'Innodb_row_lock_time_avg' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_row_lock_time_max=`grep -iw 'Innodb_row_lock_time_max' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Innodb_row_lock_waits=`grep -iw 'Innodb_row_lock_waits' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	#table_lock
	Table_locks_waited1=`grep -iw 'Table_locks_waited' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Table_locks_waited2=`grep -iw 'Table_locks_waited' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Table_locks_immediate1=`grep -iw 'Table_locks_immediate' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Table_locks_immediate2=`grep -iw 'Table_locks_immediate' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#slowlog
	Slow_queries1=`grep -iw 'Slow_queries' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Slow_queries2=`grep -iw 'Slow_queries' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#com_operations
	Com_select1=`grep -iw 'Com_select' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Com_select2=`grep -iw 'Com_select' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Com_update1=`grep -iw 'Com_update' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Com_update2=`grep -iw 'Com_update' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Com_insert1=`grep -iw 'Com_insert' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Com_insert2=`grep -iw 'Com_insert' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Com_delete1=`grep -iw 'Com_delete' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Com_delete2=`grep -iw 'Com_delete' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#throughput吞吐量
	Bytes_received1=`grep -iw 'Bytes_received' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Bytes_received2=`grep -iw 'Bytes_received' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Bytes_send1=`grep -iw 'Bytes_send' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Bytes_send2=`grep -iw 'Bytes_send' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Queries1=`grep -iw 'Queries' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Queries2=`grep -iw 'Queries' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Com_commit1=`grep -iw 'Com_commit' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Com_commit2=`grep -iw 'Com_commit' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Com_rollback1=`grep -iw 'Com_rollback' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Com_rollback2=`grep -iw 'Com_rollback' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#sort
	Sort_scan1=`grep -iw 'Sort_scan' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Sort_scan2=`grep -iw 'Sort_scan' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Sort_rows1=`grep -iw 'Sort_rows' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Sort_rows2=`grep -iw 'Sort_rows' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Sort_range1=`grep -iw 'Sort_range' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Sort_range2=`grep -iw 'Sort_range' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Sort_merge_passes1=`grep -iw 'Sort_merge_passes' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Sort_merge_passes2=`grep -iw 'Sort_merge_passes' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	#thread
	Threads_running=`grep -iw 'Threads_running' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Threads_created1=`grep -iw 'Threads_created' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Threads_created2=`grep -iw 'Threads_created' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Threads_connected=`grep -iw 'Threads_connected' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Threads_cached=`grep -iw 'Threads_cached' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	#opentable&&file
	Open_files=`grep -iw 'Open_files' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Open_table_definitions=`grep -iw 'Open_table_definitions' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Open_tables=`grep -iw 'Open_tables' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Table_open_cache_hits1=`grep -iw 'Table_open_cache_hits' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Table_open_cache_hits2=`grep -iw 'Table_open_cache_hits' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Table_open_cache_misses1=`grep -iw 'Table_open_cache_misses' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Table_open_cache_misses2=`grep -iw 'Table_open_cache_misses' ../tmp/status2.txt|awk -F ' ' '{print $2}'`
	Table_open_cache_overflows1=`grep -iw 'Table_open_cache_overflows' ../tmp/status.txt|awk -F ' ' '{print $2}'`
	Table_open_cache_overflows2=`grep -iw 'Table_open_cache_overflows' ../tmp/status2.txt|awk -F ' ' '{print $2}'`

	#计算每秒增量
	Innodb_row_lock_time=$[innodb_row_lock_time2 - innodb_row_lock_time1]
	Innodb_page_size=$[Innodb_page_size2 - Innodb_page_size1]
	Innodb_pages_created=$[Innodb_pages_created2 - Innodb_pages_created1]
	Innodb_pages_read=$[Innodb_pages_read2 - Innodb_pages_read1]
	Innodb_pages_written=$[Innodb_pages_written2 - Innodb_pages_written1]
	Innodb_rows_deleted=$[Innodb_rows_deleted2 - Innodb_rows_deleted1]
	Innodb_rows_inserted=$[Innodb_rows_inserted2 - Innodb_rows_inserted1]
	Innodb_rows_read=$[Innodb_rows_read2 - Innodb_rows_read1]
	Innodb_rows_updated=$[Innodb_rows_updated2 - Innodb_rows_updated1]
	Com_select=$[Com_select2 - Com_select1]
	Com_update=$[Com_update2 - Com_update1]
	Com_insert=$[Com_insert2 - Com_insert1]
	Com_delete=$[Com_delete2 - Com_delete1]
	Bytes_received=$[Bytes_received2 - Bytes_received1]
	Bytes_send=$[Bytes_send2 - Bytes_send1]
	QPS=$[Queries2 - Queries1]
	TPS=$[Com_commit2 + Com_rollback2 - Com_commit1 - Com_rollback1]
	Table_locks_waited=$[Table_locks_waited2 - Table_locks_waited1]
	Table_locks_immediate=$[Table_locks_immediate2 - Table_locks_immediate1]
	Slow_queries=$[Slow_queries2 - Slow_queries1]
	Slow_launch_threads=$[Slow_launch_threads2 - Slow_launch_threads1]
	#Sort_scan=$[Sort_scan2 - Sort_scan1]
	#Sort_rows=$[Sort_rows2 - Sort_rows1]
	#Sort_range=$[Sort_range2 - Sort_range1]
	#Sort_merge_passes=$[Sort_merge_passes2 - Sort_merge_passes1]
	Innodb_log_write_requests=$[Innodb_log_write_requests2 - Innodb_log_write_requests1]
	Innodb_log_writes=$[Innodb_log_writes2 - Innodb_log_writes1]
	Innodb_os_log_fsyncs=$[Innodb_os_log_fsyncs2 - Innodb_os_log_fsyncs1]
	Innodb_os_log_pending_fsyncs=$[Innodb_os_log_pending_fsyncs2 - Innodb_os_log_pending_fsyncs1]
	Innodb_os_log_pending_writes=$[Innodb_os_log_pending_writes2 -Innodb_os_log_pending_writes1]
	Innodb_os_log_written=$[Innodb_os_log_written2 - Innodb_os_log_written1]
	Threads_created=$[Threads_created2 - Threads_created1]
	Table_open_cache_hits=$[Table_open_cache_hits2 - Table_open_cache_hits1]
	Table_open_cache_misses=$[Table_open_cache_misses2 - Table_open_cache_misses1]
	Table_open_cache_overflows=$[Table_open_cache_overflows2 - Table_open_cache_overflows1]
	Innodb_buffer_pool_reads=$[Innodb_buffer_pool_reads2 - Innodb_buffer_pool_reads1]
	Innodb_buffer_pool_read_requests=$[Innodb_buffer_pool_read_requests2 - Innodb_buffer_pool_read_requests1]
	Innodb_buffer_pool_write_requests=$[Innodb_buffer_pool_write_requests2 - Innodb_buffer_pool_write_requests1]
        ACTION=`echo "select 1;"|${DBAPWD} -h${INSADDRSS} -N`
	
	#echo $Innodb_os_log_pending_fsyncs
		
	#状态值数据入库	
	ALLDATATODBSQL="use monitor;insert into monitor.status_action(instanceid,currtime,action) values(${INSTANCEID},'${CURRDATE}',${ACTION});insert into monitor.status_dml(instanceid,currtime,com_select,com_update,com_insert,com_delete) values(${INSTANCEID},'${CURRDATE}',${Com_select},${Com_update},${Com_insert},${Com_delete});insert into monitor.status_innodb_buffer(instanceid,currtime,innodb_buffer_pool_pages_data,innodb_buffer_pool_pages_misc,innodb_buffer_pool_wait_free,innodb_buffer_pool_pages_dirty,innodb_buffer_pool_pages_flushed,innodb_buffer_pool_reads,innodb_buffer_pool_read_requests,innodb_buffer_pool_write_requests) values(${INSTANCEID},'${CURRDATE}',${Innodb_buffer_pool_pages_data},${Innodb_buffer_pool_pages_misc},${Innodb_buffer_pool_wait_free},${Innodb_buffer_pool_pages_dirty},${Innodb_buffer_pool_pages_flushed},${Innodb_buffer_pool_reads},${Innodb_buffer_pool_read_requests},${Innodb_buffer_pool_write_requests});insert into monitor.status_innodb_log(instanceid,currtime,innodb_log_waits,innodb_log_write_requests,innodb_log_writes,innodb_os_log_fsyncs,innodb_os_log_pending_fsyncs,innodb_os_log_pending_writes,innodb_os_log_written) values(${INSTANCEID},'${CURRDATE}',${Innodb_log_waits},${Innodb_log_write_requests},${Innodb_log_writes},${Innodb_os_log_fsyncs},${Innodb_os_log_pending_fsyncs},${Innodb_os_log_pending_writes},${Innodb_os_log_written});insert into monitor.status_innodb_page(instanceid,currtime,innodb_page_size,innodb_pages_created,innodb_pages_read,innodb_pages_written) values(${INSTANCEID},'${CURRDATE}',${Innodb_page_size},${Innodb_pages_created},${Innodb_pages_read},${Innodb_pages_written});insert into monitor.status_innodb_row(instanceid,currtime,innodb_rows_deleted,innodb_rows_inserted,innodb_rows_read,innodb_rows_updated) values(${INSTANCEID},'${CURRDATE}',${Innodb_rows_deleted},${Innodb_rows_inserted},${Innodb_rows_read},${Innodb_rows_updated});insert into monitor.status_lock(instanceid,currtime,innodb_row_lock_current_waits,innodb_row_lock_time,innodb_row_lock_time_avg,innodb_row_lock_time_max,innodb_row_lock_waits,table_locks_waited,table_locks_immediate) values(${INSTANCEID},'${CURRDATE}',${Innodb_row_lock_current_waits},${Innodb_row_lock_time},${Innodb_row_lock_time_avg},${Innodb_row_lock_time_max},${Innodb_row_lock_waits},${Table_locks_waited},${Table_locks_immediate});insert into monitor.status_opentables(instanceid,currtime,open_files,open_table_definitions,open_tables,table_open_cache_hits,table_open_cache_misses,table_open_cache_overflows) values(${INSTANCEID},'${CURRDATE}',${Open_files},${Open_table_definitions},${Open_tables},${Table_open_cache_hits},${Table_open_cache_misses},${Table_open_cache_overflows});insert into monitor.status_slowlog(instanceid,currtime,slow_queries,slow_launch_threads) values(${INSTANCEID},'${CURRDATE}',${Slow_queries},${Slow_launch_threads});insert into monitor.status_thread(instanceid,currtime,threads_running,threads_created,threads_connected,threads_cached) values(${INSTANCEID},'${CURRDATE}',${Threads_running},${Threads_created},${Threads_connected},${Threads_cached});insert into monitor.status_throughput(instanceid,currtime,tps,qps,bytes_received,bytes_send) values(${INSTANCEID},'${CURRDATE}',${TPS},${QPS},${Bytes_received},${Bytes_send});"

	${ADMINPWD} -e "${ALLDATATODBSQL}"
}
