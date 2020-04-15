#!/bin/sh
frpc_enable=`nvram get frpc_enable`
frps_enable=`nvram get frps_enable`
http_username=`nvram get http_username`

check_frp () 
{
	check_net
	result_net=$?
	if [ "$result_net" = "1" ] ;then
		if [ -z "`pidof frpc`" ] && [ "$frpc_enable" = "1" ];then
			frp_start
		fi
		if [ -z "`pidof frps`" ] && [ "$frps_enable" = "1" ];then
			frp_start
		fi
	fi
}

check_net() 
{
	/bin/ping -c 3 223.5.5.5 -w 5 >/dev/null 2>&1
	if [ "$?" == "0" ]; then
		return 1
	else
		return 2
		logger -t "frp" "检测到互联网未能成功访问,稍后再尝试启动frp"
	fi
}

dl_frp ()
{
	mkdir -p /tmp/frp
        logger -t "frp" "自动下载最新版frp程序"
###从Code.aliyun下载
	wget --no-check-certificate -O /tmp/frp/frpc https://code.aliyun.com/madisland/mipsel_file/raw/dcdd47c7669ecfdc1c9431155922fca4dcfc83b5/frpc && wget --no-check-certificate -O /tmp/frp/frps https://code.aliyun.com/madisland/mipsel_file/raw/dcdd47c7669ecfdc1c9431155922fca4dcfc83b5/frps
	if [ ! -f "/tmp/frp/frpc" ] || [ ! -f "/tmp/frp/frps" ] ; then
	logger -t "frp" "frp下载失败，尝试从Github下载最新版程序!"
####从GitHub下载
	tag1="$( wget -T 5 -t 3 --user-agent "$user_agent" --max-redirect=0  https://github.com/fatedier/frp/releases/latest  2>&1 | grep releases/tag | awk -F '/' '{print $NF}' | awk -F ' ' '{print $1}' )"
	[ -z "$tag1" ] && tag1="$( wget -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=-  https://github.com/fatedier/frp/releases/latest  2>&1 | grep '<a href="/fatedier/frp/tree/'  |head -n1 | awk -F '/' '{print $NF}' | awk -F '"' '{print $1}' )"
	tag2="$( wget -T 5 -t 3 --user-agent "$user_agent" --max-redirect=0  https://github.com/fatedier/frp/releases/latest  2>&1 | grep releases/tag | awk -F '/v' '{print $NF}' | awk -F ' ' '{print $1}' )"
	[ -z "$tag2" ] && tag2="$( wget -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=-  https://github.com/fatedier/frp/releases/latest  2>&1 | grep '<a href="/fatedier/frp/tree/'  |head -n1 | awk -F '/v' '{print $NF}' | awk -F '"' '{print $1}' )"
	wget --no-check-certificate -O /tmp/frp.tar.gz https://github.com/fatedier/frp/releases/download/$tag1/frp_"$tag2"_linux_mipsle.tar.gz
	        if [ ! -f "/tmp/frp.tar.gz" ]; then
                logger -t "frp" "frp下载失败，请检查网络是否能够连接github!程序将退出。"
                nvram set frpc_enable=0
                nvram set frps_enable=0
                exit 0
                else
                        logger -t "frp" "frp下载成功。"
			tar -xzvf /tmp/frp.tar.gz -C /tmp
                        mv -f /tmp/frp_"$tag2"_linux_mipsle/frps /tmp/frp/
			mv -f /tmp/frpp_"$tag2"_linux_mipsle/frpc /tmp/frp/
                        rm -rf /tmp/frp.tar.gz /tmp/frp_"$tag2"_linux_mipsle
                        chmod 777 /tmp/frp/frpc
                        chmod 777 /tmp/frp/frps
                fi
	else 
		logger -t "frp" "frp下载成功。"
		chmod 777 /tmp/frp/frpc
		chmod 777 /tmp/frp/frps
	fi
}
frp_start () 
{
	if [ ! -f "/tmp/frp/frps" ] || [ ! -f "/tmp/frp/frpc" ]; then
	dl_frp
	fi
	/etc/storage/frp_script.sh
	sed -i '/frp/d' /etc/storage/cron/crontabs/$http_username
	cat >> /etc/storage/cron/crontabs/$http_username << EOF
*/1 * * * * /bin/sh /usr/bin/frp.sh C >/dev/null 2>&1
EOF
	[ ! -z "`pidof frpc`" ] && logger -t "frp" "frpc启动成功"
	[ ! -z "`pidof frps`" ] && logger -t "frp" "frps启动成功"
}

frp_close () 
{
	if [ "$frpc_enable" = "0" ]; then
		if [ ! -z "`pidof frpc`" ]; then
		killall -9 frpc frp_script.sh
		[ -z "`pidof frpc`" ] && logger -t "frp" "已停止 frpc"
	    fi
	fi
	if [ "$frps_enable" = "0" ]; then
		if [ ! -z "`pidof frps`" ]; then
		killall -9 frps frp_script.sh
		[ -z "`pidof frps`" ] && logger -t "frp" "已停止 frps"
	    fi
	fi
	if [ "$frpc_enable" = "0" ] && [ "$frps_enable" = "0" ]; then
	sed -i '/frp/d' /etc/storage/cron/crontabs/$http_username
    fi
}


case $1 in
start)
	frp_start
	;;
stop)
	frp_close
	;;
C)
	check_frp
	;;
esac
