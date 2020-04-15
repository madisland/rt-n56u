#!/bin/sh

change_dns() {
if [ "$(nvram get adg_redirect)" = 1 ]; then
sed -i '/no-resolv/d' /etc/storage/dnsmasq/dnsmasq.conf
sed -i '/server=127.0.0.1/d' /etc/storage/dnsmasq/dnsmasq.conf
cat >> /etc/storage/dnsmasq/dnsmasq.conf << EOF
no-resolv
server=127.0.0.1#3553
dns-forward-max=1000
EOF
/sbin/restart_dhcpd
logger -t "AdGuardHome" "添加DNS转发到3553端口"
fi
}

del_dns() {
sed -i '/no-resolv/d' /etc/storage/dnsmasq/dnsmasq.conf
sed -i '/server=127.0.0.1#3553/d' /etc/storage/dnsmasq/dnsmasq.conf
sed -i '/dns-forward-max=1000/d' /etc/storage/dnsmasq/dnsmasq.conf
/sbin/restart_dhcpd
}

getconfig(){
adg_file="/etc/storage/adg.sh"
if [ ! -f "$adg_file" ] || [ ! -s "$adg_file" ] ; then
	cat > "$adg_file" <<-\EEE
bind_host: 0.0.0.0
bind_port: 3000
auth_name: admin
auth_pass: admin
language: zh-cn
rlimit_nofile: 0
dns:
  bind_host: 0.0.0.0
  port: 3553
  protection_enabled: true
  filtering_enabled: true
  blocking_mode: nxdomain
  blocked_response_ttl: 10
  querylog_enabled: true
  ratelimit: 20
  ratelimit_whitelist: []
  refuse_any: true
  bootstrap_dns:
  - 119.29.29.29
  - 223.5.5.5
  all_servers: true
  allowed_clients: []
  disallowed_clients: []
  blocked_hosts: []
  parental_sensitivity: 0
  parental_enabled: false
  safesearch_enabled: false
  safebrowsing_enabled: false
  resolveraddress: ""
  upstream_dns:
  - 119.29.29.29
  - 223.5.5.5
tls:
  enabled: false
  server_name: ""
  force_https: false
  port_https: 443
  port_dns_over_tls: 853
  certificate_chain: ""
  private_key: ""
filters:
- enabled: true
  url: https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
  name: AdGuard Simplified Domain Names filter
  id: 1
- enabled: true
  url: https://adaway.org/hosts.txt
  name: AdAway
  id: 2
- enabled: true
  url: https://hosts-file.net/ad_servers.txt
  name: hpHosts - Ad and Tracking servers only
  id: 3
- enabled: true
  url: https://www.malwaredomainlist.com/hostslist/hosts.txt
  name: MalwareDomainList.com Hosts List
  id: 4
- enabled: true
  url: https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt
  name: Anti-AD
  id: 1586053714
- enabled: true
  url: https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt
  name: yHosts
  id: 1586053715
- enabled: true
  url: https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV-AGH.txt
  name: Perflyst and Dandelion Sprout's Smart-TV Blocklist for AdGuard Home
  id: 1586053716
user_rules: []
dhcp:
  enabled: false
  interface_name: ""
  gateway_ip: ""
  subnet_mask: ""
  range_start: ""
  range_end: ""
  lease_duration: 86400
  icmp_timeout_msec: 1000
clients: []
log_file: ""
verbose: false
schema_version: 3

EEE
	chmod 755 "$adg_file"
fi
}

dl_adg(){
	logger -t "AdGuardHome" "自动下载AdGuardHome程序"
	mkdir -p /tmp/AdGuardHome
###从Code.aliyun下载
	wget --no-check-certificate -O /tmp/AdGuardHome/AdGuardHome https://code.aliyun.com/madisland/mipsel_file/raw/dcdd47c7669ecfdc1c9431155922fca4dcfc83b5/AdGuardHome
	if [ ! -f "/tmp/AdGuardHome/AdGuardHome" ];then
		logger -t "AdGuardHome" "AdGuardHome下载失败，尝试从Github官方下载最新版程序!"
###从Github下载最新版本
		tag="$( wget -T 5 -t 3 --user-agent "$user_agent" --max-redirect=0  https://github.com/AdguardTeam/AdGuardHome/releases/latest  2>&1 | grep releases/tag | awk -F '/' '{print $NF}' | awk -F ' ' '{print $1}' )"
		[ -z "$tag" ] && tag="$( wget -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=-  https://github.com/AdguardTeam/AdGuardHome/releases/latest  2>&1 | grep '<a href="/AdguardTeam/AdGuardHome/tree/'  |head -n1 | awk -F '/' '{print $NF}' | awk -F '"' '{print $1}' )"
		wget --no-check-certificate -O /tmp/AdGuardHome.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/download/$tag/AdGuardHome_linux_mipsle.tar.gz
		if [ ! -f "/tmp/AdGuardHome.tar.gz" ]; then
			logger -t "AdGuardHome" "AdGuardHome下载失败，请检查网络,程序将退出。"
			nvram set adg_enable=0
	       		exit 0
		else
			logger -t "AdGuardHome" "AdGuardHome下载成功。"
			tar -xzvf /tmp/AdGuardHome.tar.gz -C /tmp
			rm -f /tmp/AdGuardHome.tar.gz /tmp/AdGuardHome/LICENSE.txt /tmp/AdGuardHome/README.md
			chmod 777 /tmp/AdGuardHome/AdGuardHome
		fi
	else
		logger -t "AdGuardHome" "AdGuardHome下载成功。"
		chmod 777 /tmp/AdGuardHome/AdGuardHome
	fi
}

start_adg(){
	if [ ! -f "/tmp/AdGuardHome/AdGuardHome" ]; then
	del_dns
	dl_adg
	fi
	getconfig
	change_dns
	logger -t "AdGuardHome" "运行AdGuardHome"
	eval "/tmp/AdGuardHome/AdGuardHome -c $adg_file -w /tmp/AdGuardHome" &

}
stop_adg(){
killall -9 AdGuardHome
del_dns
}


case $1 in
start)
	stop_adg
	start_adg
	;;
stop)
	stop_adg
	;;
*)
	echo "check"
	;;
esac
