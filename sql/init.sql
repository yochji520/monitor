USE `monitor`;
set names utf8mb4;

CREATE TABLE `capturetrxwait` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例ID',
  `capturetime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '每次采集的时间',
  `trx_start` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '事务开始时间',
  `lock_table` varchar(50) NOT NULL DEFAULT '' COMMENT '锁住的表',
  `lock_mode` varchar(10) NOT NULL DEFAULT '' COMMENT '锁的类型',
  `lock_index` varchar(60) NOT NULL DEFAULT '' COMMENT '索引',
  `trx_id` int(11) NOT NULL DEFAULT '0' COMMENT '当前阻塞trx_id',
  `trx_state` varchar(20) NOT NULL DEFAULT '' COMMENT '事务的状态',
  `wait_start` datetime DEFAULT NULL COMMENT '事务开始等待时间',
  `trx_query` varchar(4000) DEFAULT NULL COMMENT 'SQL',
  `thread_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '线程id',
  `killsql` varchar(50) NOT NULL DEFAULT '' COMMENT 'kill thread id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='获取事务阻塞的信息';


CREATE TABLE `cronexeclog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `scriptname` varchar(60) NOT NULL DEFAULT '' COMMENT '脚本命令，绝对路径',
  `exectime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '执行时间点',
  `endtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '执行结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='脚本执行日志';


CREATE TABLE `dbinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) NOT NULL DEFAULT '0' COMMENT '实例ID',
  `dbname` varchar(50) NOT NULL DEFAULT '' COMMENT '库名',
  `dbid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '库id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='库名信息';


CREATE TABLE `dbinstance` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例ID',
  `instancename` varchar(100) NOT NULL DEFAULT '' COMMENT 'rds实例名',
  `createtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '创建时间',
  `dbrules` int(11) NOT NULL DEFAULT '0' COMMENT '数据库角色，0，主库，1从库',
  `pojoname` varchar(30) NOT NULL DEFAULT '' COMMENT '项目名',
  `pojoid` int(11) NOT NULL DEFAULT '0' COMMENT '项目id',
  `insadress` varchar(100) NOT NULL DEFAULT '' COMMENT '外网地址',
  `insport` smallint(5) NOT NULL DEFAULT '0' COMMENT '实例端口',
  PRIMARY KEY (`id`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='实例信息';


CREATE TABLE `dbmetric` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例ID',
  `maxconn` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大连接数',
  `opentables` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '打开的表数量',
  `opentablecache` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '表缓存阈值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指标阈值配置';


CREATE TABLE `opentablelog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '当前时间',
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例ID',
  `logfile` varchar(50) NOT NULL DEFAULT '' COMMENT '日志记录表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='打开表异常日志记录';


CREATE TABLE `printprocesslog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '当前时间',
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例ID',
  `logfile` varchar(50) NOT NULL DEFAULT '' COMMENT '日志记录表',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='连接数异常日志记录';


CREATE TABLE `scriptinfo` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(11) NOT NULL DEFAULT '0' COMMENT '实例ID',
  `scriptdir` varchar(60) NOT NULL DEFAULT '' COMMENT '脚本目录',
  `scriptname` varchar(50) NOT NULL DEFAULT '' COMMENT '脚本名字',
  `scriptid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '脚本id',
  `scripttype` tinyint(4) NOT NULL DEFAULT '0' COMMENT '脚本类型',
  `exectime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12',
  `logdir` varchar(50) NOT NULL DEFAULT '' COMMENT '脚本目录',
  `logfile` varchar(50) NOT NULL DEFAULT '' COMMENT '脚本目录',
  `describes` varchar(100) NOT NULL DEFAULT '' COMMENT '脚本功能描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='脚本信息';


CREATE TABLE `slowagginfo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dbnameid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '库名id',
  `dbname` varchar(30) NOT NULL DEFAULT '' COMMENT '数据库名',
  `dbuser` varchar(30) NOT NULL DEFAULT '' COMMENT '连接数据库的用户',
  `seqnumid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '同类SQL的序列号',
  `sqltext` text NOT NULL COMMENT '处理过后的SQL文本',
  `sqlstatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '确认SQL:0：不知道，1：知道',
  `hashvalue` varchar(100) NOT NULL DEFAULT '' COMMENT '一致性hash',
  `lasttime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `idx_lasttime` (`lasttime`),
  KEY `idx_dbnameid` (`dbnameid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='慢SQL日志';


CREATE TABLE `slowlogdetail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seqnumid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '同类SQL的序列号',
  `ipaddr` varchar(30) NOT NULL DEFAULT '' COMMENT '连接db的客户端IP',
  `querytime` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '查询时间',
  `locktime` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'lock时间',
  `parserowcount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '搜索的行数',
  `returnrowcount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '返回的行数',
  `execstarttime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '开始时间',
  `sqltext` text NOT NULL COMMENT '原始SQL文本',
  PRIMARY KEY (`id`),
  KEY `idx_seqnumid` (`seqnumid`),
  KEY `idx_execstarttime` (`execstarttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='慢日志详细信息';


CREATE TABLE `status_action` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `action` tinyint(4) NOT NULL DEFAULT '0' COMMENT '存活状态',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='存活状态监控';


CREATE TABLE `status_dml` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `com_select` bigint(20) unsigned NOT NULL DEFAULT '0',
  `com_update` bigint(20) unsigned NOT NULL DEFAULT '0',
  `com_insert` bigint(20) unsigned NOT NULL DEFAULT '0',
  `com_delete` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='DML状态监控';



CREATE TABLE `status_innodb_buffer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `innodb_buffer_pool_pages_data` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_buffer_pool_pages_misc` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_buffer_pool_wait_free` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_buffer_pool_pages_dirty` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_buffer_pool_pages_flushed` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_buffer_pool_reads` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_buffer_pool_read_requests` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_buffer_pool_write_requests` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='innodb_buffer状态监控';

CREATE TABLE `status_innodb_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `innodb_log_waits` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_log_write_requests` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_log_writes` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_os_log_fsyncs` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_os_log_pending_fsyncs` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_os_log_pending_writes` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_os_log_written` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='innodb_log状态监控';


CREATE TABLE `status_innodb_page` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `innodb_page_size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_pages_created` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_pages_read` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_pages_written` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='innodb_page状态监控';


CREATE TABLE `status_innodb_row` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `innodb_rows_deleted` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_rows_inserted` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_rows_read` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_rows_updated` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='innodb_row状态监控';

CREATE TABLE `status_lock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `innodb_row_lock_current_waits` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_row_lock_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_row_lock_time_avg` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_row_lock_time_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  `innodb_row_lock_waits` bigint(20) unsigned NOT NULL DEFAULT '0',
  `table_locks_waited` bigint(20) unsigned NOT NULL DEFAULT '0',
  `table_locks_immediate` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='lock锁状态监控';

CREATE TABLE `status_opentables` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `open_files` bigint(20) unsigned NOT NULL DEFAULT '0',
  `open_table_definitions` bigint(20) unsigned NOT NULL DEFAULT '0',
  `open_tables` bigint(20) unsigned NOT NULL DEFAULT '0',
  `table_open_cache_hits` bigint(20) unsigned NOT NULL DEFAULT '0',
  `table_open_cache_misses` bigint(20) unsigned NOT NULL DEFAULT '0',
  `table_open_cache_overflows` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='opentables吞吐量状态监控';


CREATE TABLE `status_slowlog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `slow_queries` bigint(20) unsigned NOT NULL DEFAULT '0',
  `slow_launch_threads` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='slowlog状态监控';

CREATE TABLE `status_thread` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `threads_running` bigint(20) unsigned NOT NULL DEFAULT '0',
  `threads_created` bigint(20) unsigned NOT NULL DEFAULT '0',
  `threads_connected` bigint(20) unsigned NOT NULL DEFAULT '0',
  `threads_cached` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='thread状态监控';

CREATE TABLE `status_throughput` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实例id',
  `currtime` datetime NOT NULL DEFAULT '2012-12-12 12:12:12' COMMENT '采集时间',
  `tps` bigint(20) unsigned NOT NULL DEFAULT '0',
  `qps` bigint(20) unsigned NOT NULL DEFAULT '0',
  `bytes_received` bigint(20) unsigned NOT NULL DEFAULT '0',
  `bytes_send` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ci` (`currtime`,`instanceid`),
  KEY `idx_instanceid` (`instanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='throughput吞吐量状态监控';

CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `email` varchar(60) NOT NULL DEFAULT '' COMMENT '用户邮箱',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';
