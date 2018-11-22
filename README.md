#此文本讲述监控脚本的编写规范以及实现的功能
#最近更新时间：2018-10-09


整体脚本目录规划，说明

===================================================================================================
monitor_scripts--|conf --配置文件
		 |pybin --python脚本,新规划目录
		 |scripts --脚本目录
		 |logs --日志目录,按host划分子目录
			|--hosts
				 |--*.log
		 |tmp --临时目录	 
目录脚本编写规范

===================================================================================================
一）命名规范

脚本命名：

1) 常规shell脚本使用统一后缀：“.sh” ,例如：a.sh
2) 脚本必须使用小写,同时需要见名知意，名字太长以'_'下划线分隔，比如：check_db_alived.sh
3) 不要出现特殊字符和数字

变量命名：

1）变量命名要统一，使用全部大写字母或者全部驼峰写法，做到见名知意
2）避免特殊字符或数字
3）变量值使用""引起来 比如:USER="root"

函数命名

1）函数命名使用单词首字母大写，也可以使用驼峰语法，比如：function ShowDbConnInfo(){xxx}
2）名字尽量不使用缩写
3）名字可以两个或三个单词组成，但是通常不应多余三个
4）函数定义时在函数前必须加上 function 保留字

二，代码风格

脚本框架

1) 脚本开头行解释器声明为 #!/bin/bash
2) 脚本第二行空写空注释 ps:
	 #!/bin/bash 
	 #
4) 脚本第三行开始写脚本注释内容:文件、文件名、功能描述、作者、最后修改日期（xxxx-xx-xx）、版本号
5) 脚本注释和脚本内容之间以空格分开
6) 脚本注释写好之后，加上[set -e]:脚本如果执行出错，停止执行脚本
7) 主脚本只实现程序主干，功能实现尽量封装在子函数中。
8) 对于能独立执行的脚本要有usage和version函数，可以输出用法和版本信息。

 
注释规范

1）文件模块注释: 说明用途，版本输入输出文件，依赖工具及其版本信息，前后流程脚本（可选），格式统一。
2）重要函数注释：说明函数用途，参数，返回值，作者，版本。
3）养成写注释习惯：注释要详细，包含变量定义，函数定义，返回值定义，每步操作目的


代码风格

1) 变量的引用，变量使用大括号括起来，方式如：${GameZone}  
2) 单引号和双引号混合使用的场景,单引号再外，双引号再内 比如：echo 'Welcome to "my school"'
3) 条件测试的时候，尽量使用[[]] 比如：if [[ ! -f xxx.file ]]
4) 可以使用&& ||来替代简单的if-then-else-fi语句
5) 流程控制写法标准，将do，then和条件行写在一行，
   比如： for I in {1..10};do
	  	xxxxxx
	  done
6) shell必须以tab长度为缩进标准 
7) 配置文件及函数脚本等的引用 如:source conf/httpd.conf

8) 变量合并,如果某些变量需要组合起来才有意义时，例如文件路径等，请将组合起来的值赋予一个变量，这样以后修改起来方便
   log_dir=/monitor/log
   log_name=mom.log
   ——————-错误写法——————-
   if [[ ! -f ${log_dir}/mam/${log_name} ]]
   then
   touch ${log_dir}/mam/${log_name}
   fi
   ———————————————-

   ——————-推荐写法——————-
   log_file=${log_dir}/${log_name}
   if [[ ! -f ${log_file} ]]
   then
   touch ${log_file}
   fi
  ———————————————-
		
9) 如果脚本在执行的时候需要大段输出提示信息，可是使用以下方式：
   cat << EOF
   This scripts used for XXX
   Usage:$0 [option]
   Pls be careful.
   Enjoy Yourself.
   EOF
   如果只是单行提示信息，可是使用echo的方式，可以添加颜色：
   echo “Welcome to use my script”

11) 如果需要在脚本里生成配置文件的模板，也可以使用here document的方式，示例如下：
     cat>>/etc/config.conf<<EOF
     log file = /usr/local/logs/rsyncd.log
     transfer logging = yes
     log format = %t %a %m %f %b
     syslog facility = local3
     timeout = 300
     EOF

12) 算数运算使用(())或者是中括号，但是记得括号里面的变量不要再加$
    ((12+i))
    而非((12+$i))

13) 尽量给每条语句或者代码段的执行给一个执行结果状态，如果某条命令执行失败，则exit N.
    尽可能使用$?来检查前面一条命令的执行状态。
   
14) 如果命令过长，可以分成多行来写，比如：
    ./configure \
    –prefix=/usr \
    –sbin-path=/usr/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    –error-log-path=/var/log/nginx/error.log \
    –http-log-path=/var/log/nginx/access.log \
    –pid-path=/var/run/nginx/nginx.pid \
    –lock-path=/var/lock/nginx.lock \
===================================================================================================

脚本说明:
1)captureinfo.sh:
功能：抓取数据库的线程信息，事务信息，锁信息，InnoDB引擎状态
描述：通过读取配置文件（dbs.conf）的信息采取以上信息,抓取信息如下:
	SELECT NOW() as EXECDATE,a.* FROM information_schema.INNODB_TRX a;
	SELECT NOW() as EXECDATE,a.* FROM information_schema.INNODB_LOCKS a;
	SELECT NOW() as EXECDATE,a.* FROM information_schema.INNODB_LOCK_WAITS a;
	SELECT NOW() as EXECDATE,a.* FROM information_schema.PROCESSLIST a;
	select now() as EXECDATE;SHOW OPEN TABLES WHERE in_use > 0 OR name_locked > 0;
	SHOW ENGINE INNODB STATUS\G
	select concat('KILL  ', a.trx_mysql_thread_id ,';') AS kill_blocking_id from (information_schema.innodb_trx a join information_schema.innodb_lock_waits b join information_sche
ma.innodb_locks c  on a.trx_id=b.blocking_trx_id and b.Blocking_trx_id=c.lock_trx_id) join information_schema.innodb_trx d on d.trx_id=b.requesting_trx_id;
何如使用：
	bash +x captureinfo.sh --help 查看帮组信息如下:
	Usage:  {MCHESS|SCHESS|MATCH|AGENT|HELP}  [ script exec options ] ps:[capturesnapshoot.sh MCHESS]
	Help: captureinfo.sh [OPTIONS]
	ps : bash +x captureinfo.sh MCHESS
	  --help  print help info.
	  MCHESS  capture MCHESS DATABASE INFO .
	  SCHESS  capture SCHESS DATABASE INFO .
	  MATCH   capture MATCH  DATABASE INFO .
	  AGENT   capture AGENT  DATABASE INFO .
	脚本获取闯入的第一个参数：./captureinfo.sh MCHESS ，抓取”MCHESS“库的信息。

1)main.sh
功能:脚本入口
使用描述，需要传递参数(执行时间频率) ps bash +x main.sh 10
	main.sh 10-->10秒执行一次。SLEEPTIME=$1


2)sendmail.sh
功能:发送邮件
使用描述：导入配置文件 source ../conf/dbs.conf
          调用需传递两个参数: sendmail $1 $2
                $1-->conenttext:  邮件文本内容
                $2-->title:  邮件主题

3)dbs.conf
功能:配置文件
描述:数据库连接信息



	
			
			

	






