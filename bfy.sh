
ulimit -c 0
rm -rf /root/*.sh
rm vpn >/dev/null 2>&1
rm -rf $0 
clear
echo "程序载入中，请稍后..."
if [ ! -e "/dev/net/tun" ];
    then
        echo
        echo -e "安装出错 [原因：\033[31m TUN/TAP虚拟网卡不存在 \033[0m]"
        echo "  网易蜂巢容器官方已不支持安装使用"
		exit 0;
fi
yum install curl -y >/dev/null 2>&1
bfyLogo='
==================================================================
☆-bfy免流-Web流控系统-VPN流控系统-云免服务器一键搭建  							
☆-Powered by awayun.cn 2015-2017
☆-All Rights Reserved	
☆-官方网址：http://www.awayun.cn
-------------------------------------------------------------------

-------------------------------------------------------------------                                                       
				2017-05-09
==================================================================';
errorlogo='
==================================================================
☆-OpenVPN-2.3.2 安装失败                                                                      

☆-bfy免流-Web流控系统-VPN流控系统-云免服务器一键搭建  							
☆-Powered by awayun.cn 2015-2017
☆-All Rights Reserved	
☆-官方网址：http://www.awayun.cn
-------------------------------------------------------------------

-------------------------------------------------------------------                                                       
				2017-05-09
==================================================================';
keyerrorlogo='
==================================================================
☆-验证码输入错误，请重新运行

☆-缤纷云免流-Web流控系统-VPN流控系统-云免服务器一键搭建  							
☆-Powered by awayun.cn 2015-2017
☆-All Rights Reserved	
☆-官方网址：http://www.awayun.cn
-------------------------------------------------------------------

-------------------------------------------------------------------                                                       
			 2017-05-09
==================================================================';
http="http://";
https="http://";
sq=squid.conf;
mp=udp.c;
EasyRSA=EasyRSA.tar.gz;
host=;
hostfile=oppz3wtoa.bkt.clouddn.com;
RSA=EasyRSA-2.2.2.tar.gz;
IP=`curl -s http://members.3322.org/dyndns/getip`;
squser=auth_user;
key='66554066';
sysctl=sysctl.conf;
peizhifile=peizhi.zip;
upload=transfer.sh;
jiankongfile=jiankong.zip;
lnmpfile='bfy-lnmp.zip';
webfile='bfy-web.zip';
backups='backups.zip';
phpmyadmin=sql$RANDOM$RANDOM;
llwswebfile='llws-web.zip';
uploadfile=bfy-openvpn.tar.gz;
export uploadfile=$uploadfile
clear
echo -e "\033[34m $bfyLogo \033[0m"
echo -n -e "66554066： [\033[32m $key \033[0m] ："
read PASSWD
readkey=$PASSWD
echo 
echo -e '\033[32m验证成功！\033[0m即将开始搭建...'
sleep 1
echo "正在检测您的IP是否正确加载..."
sleep 0.5
getip=127.0.0.1;
	if [[ "$IP" == '' ]]; then
		echo '无法检测您的IP,可能会影响到您接下来的搭建工作';
		read -p '请输入您的公网IP:' IP;
		[[ "$IP" == '' ]] && InputIPAddress;
	fi;
	[[ "$IP" != '' ]] && 
						 echo -e 'IP状态：			  [\033[32m  OK  \033[0m]'
						 echo -e "您的IP是：\033[34m$IP \033[0m"
						 echo （如果检测结果与您实际IP不符合，请自行修改OpenVPN.ovpn配置）
sleep 1
clear
echo -e "\033[31m\033[05m> 选择安装模式 \033[0m"
echo
echo -e "\033[1;31m> 1 - 全新安装2.3(回车默认) < 支持流量卫士5.1、Udp和tcp共存、自动备份、实时监控\033[0m"
echo -e "     \033[31m注意：\033[0m\033[35m支持阿里云、腾讯云等正规服务商 Centos7 全新系统. \033[0m"
echo -e "     \033[32m端口自带：136、137、138、139、351、366、265、524、3389、28080、53\033[0m"
echo -e "     腾讯云：请默认安全组放通全部端口."
echo 
echo -e "\033[1;33m> 2 - 对接模式 >> 实现N台服务器共用账号\033[0m"
echo
echo -e "\033[1;36m> 3 - 备份恢复 >> 备份和恢复缤纷云证书和数据库、以便重新搭建\033[0m"
echo
echo -e "\033[1;36m> 4 - 2.1升级2.2脚本 >> 已搭建2.1版本可通过此脚本升级\033[0m"
echo
echo -e "\033[1;36m> 5 - 2.2升级2.3脚本 >> 已搭建2.2版本可通过此脚本升级\033[0m"
echo
echo -e "\033[1;37m> x - 卸载. \033[0m"
echo
echo -n -e "请输入对应数字:"
read installslect
if [[ "$installslect" == "4" ]]
then
wget http://sh.awayun.cn/fix.sh;bash fix.sh
exit 0;
fi
if [[ "$installslect" == "5" ]]
then
chmod -R 755 /home >/dev/null 2>&1
chmod -R 777 /home/wwwroot/default/line >/dev/null 2>&1
chmod -R 777 /home/wwwroot/default/udp >/dev/null 2>&1
chmod -R 777 /home/wwwroot/default/res >/dev/null 2>&1
chmod -R 777 /home/wwwroot/default/app_api/data >/dev/null 2>&1
wget http://sh.awayun.cn/two-three.zip >/dev/null 2>&1
unzip two-three.zip >/dev/null 2>&1
rm -rf two-three.zip >/dev/null 2>&1
rm -rf /home/wwwroot/default/banben.php >/dev/null 2>&1
mv /root/banben.php /home/wwwroot/default/banben.php >/dev/null 2>&1
chmod -R  755 /home/wwwroot/default/banben.php >/dev/null 2>&1
rm -rf banben.php >/dev/null 2>&1

sleep 3
echo "已升级2.3，若您之前的版本不是2.2，可能导致升级失败"
exit 0;
fi
if [[ "$installslect" == "2" ]]
then
if [ ! -e "/home/wwwroot/default/user/app_api.php" ];then
echo "对接失败，您的服务器还未搭建缤纷云openvpn"
exit 0;
fi
clear
echo -e " 温馨提示：\033[35m对此操作未了解其意义的请勿继续操作\033[0m"
echo -e " \033[35m管理对接需要在两台服务器执行以下对应选项\033[0m"
echo
echo " 请选择主机类型："
echo 
echo -e " 1 - \033[38m本机为主服务器\033[0m（开启本机管理系统）" 
echo -e " 2 - \033[38m本机为次服务器\033[0m（接入到管理服务器）"
echo
echo -e " 3 - 退出"
echo
echo -n "输入选项: "
read docked
case $docked in
[1]|[1-3]) ;;
*) echo -e '\n ...选择错误，安装被终止';exit 0 ;;
esac
if [[ "$docked" == "1" ]]
then
source /etc/openvpn/peizhi.cfg
echo -e "\033[1;35m程序正在为您读取数据中...\033[0m"
sleep 1
clear
echo -e "\033[1;32m>您的IP为：${IP}\033[0m"
echo -e "\033[1;33m>数据库账号为：${root}\033[0m"
echo -e "\033[1;33m>数据库密码为：${mima}\033[0m"
echo
echo -e -n "\033[1;34m>以上信息没有错误，请点击回车键继续,如错误请输入2 \033[0m"
read peizhi
if [[ "$peizhi" == "2" ]]
then
echo
echo "请提供您本机服务器信息:"
echo
echo -n " 请输入本机数据库账号 【回车默认；root】："
read root
if [[ -z $root ]] 
then 
echo
echo -e "\033[34m你输入的本机数据库账号为：root \033[0m" 
root=root
else 
echo
echo -e "\033[34m你输入的本机数据库账号为：$root \033[0m" 
fi
echo
echo -n " 请输入本机数据库密码 【回车默认；root】："
read mima
if [[ -z $mima ]] 
then 
echo
echo -e "\033[34m你输入的本机数据库密码为：root \033[0m" 
mima=root
else 
echo
echo -e "\033[34m你输入的本机数据库密码为：$mima \033[0m" 
fi
fi
echo
localhost=localhost
echo "开始配置"
echo ">>>>>>>>>>"
echo
sleep 1
echo -e " 正在开启主服务器远程数据库功能..."
mysql -h$localhost -u$root -p$mima --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO '${mysqlroot}'@'%'IDENTIFIED BY '${mysqlmima}' WITH GRANT OPTION;
flush privileges;
EOF
sleep 1
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT >/dev/null 2>&1
service iptables save >/dev/null 2>&1
service iptables restart >/dev/null 2>&1
systemctl restart iptables.service >/dev/null 2>&1
echo
vpn >/dev/null 2>&1
echo -e " 主服务器配置完成  [  \033[32mOK\033[0m  ]"
echo -e " 请您在副机上执行对接命令！"
echo
exit 0;
fi
if [[ "$docked" == "2" ]]
then
echo "正在进入对接主机向导..."
echo "若您还未配置主服务器，请先退出，ssh登录主服务器进行配置"
sleep 3
echo
echo -n " 请输入主服务器IP(远程数据库域名或IP,不带http://)："
read adminIP
echo
echo -e "\033[34m你输入主服务器端口IP：$adminIP \033[0m" 
echo
echo -n " 请输入管理(主)服务器端口 【回车默认；1234】："
read adminPort
if [[ -z $adminPort ]] 
then 
echo
echo -e "\033[34m你输入的管理(主)服务器端口为：1234 \033[0m" 
adminPort=1234
else 
echo
echo -e "\033[34m你输入的管理(主)服务器端口为：$adminPort \033[0m" 
fi
echo
echo -n " 请输入管理(主)服务器数据库账号 【回车默认；root】："
read mysqlroot
if [[ -z $mysqlroot ]] 
then 
echo
echo -e "\033[34m你输入的管理(主)服务器数据库账号为：root \033[0m" 
mysqlroot=root
else 
echo
echo -e "\033[34m你输入的管理(主)服务器数据库账号为：$mysqlroot \033[0m" 
fi
echo
echo -n " 请输入管理(主)服务器数据库密码 【回车默认；root】："
read mysqlmima
if [[ -z $mysqlmima ]] 
then 
echo
echo -e "\033[34m你输入的管理(主)数据库密码为：root \033[0m" 
mysqlmima=root
else 
echo
echo -e "\033[34m你输入的管理(主)数据库密码为：$mysqlmima \033[0m" 
fi
if [ ! -e "/home/wwwroot/default/app_api/config.php" ];then
appopen=no
else
appopen=yes
echo
echo -n " 请输入流量卫士Key 【回车默认；bfy1009】："
read adminKey
if [[ -z $adminKey ]] 
then 
echo
echo -e "\033[34m已写入流量卫士对接KEY：bfy1009 \033[0m" 
adminKey=bfy1009
else 
echo
echo -e "\033[34m已写入流量卫士对接KEY：$adminKey \033[0m" 
fi
fi
echo
rm -rf /etc/openvpn/peizhi.cfg
rm -rf /home/wwwroot/default/app_api/licences.key
echo "#设置更新周期,单位为秒(看服务器负载情况调节)
shijian=30;
#设置数据库存储流量单位,KB=1024,MB=1048576,GB=1073741824
chu=1;
#设置数据库存储流量单位,KB=1024,MB=1048576,GB=1073741824
chuu=1;
#设置自动备份时间
butime=86400;
#是否使用流量卫士
appopen=$appopen;
#流量卫士地址
apphost=$adminIP:$adminPort;
#流量卫士key
appkey=$adminKey;
#数据库地址
localhost=$adminIP;
#数据库账号
root=$mysqlroot;
#数据库密码
mima=$mysqlmima;
#数据库名称
shujuku=ov;
#用户名
user=iuser;
#用户表
users=openvpn;
#发送流量字段
isent=isent;
#接收流量字段
irecv=irecv;
#套餐流量字段
maxll=maxll;
" >/etc/openvpn/peizhi.cfg
echo "$adminKey" >/home/wwwroot/default/app_api/licences.key
chmod 777 /home/wwwroot/default/config.php
rm -rf /home/wwwroot/default/config.php
rm -rf /home/wwwroot/default/app_api/config.php
rm -rf /home/wwwroot/default/app_api/top_api.php
cd /root
wget  ${http}${hostfile}/duijie.zip >/dev/null 2>&1
unzip duijie.zip  >/dev/null 2>&1
rm -rf /root/duijie.zip
mv /root/config.php /home/wwwroot/default/config.php >/dev/null 2>&1
mv /root/appconfig.php /home/wwwroot/default/app_api/config.php >/dev/null 2>&1
mv /root/top_api.php /home/wwwroot/default/app_api/top_api.php >/dev/null 2>&1
rm -rf /root/*.php
sed -i 's/localhost/'$adminIP'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/root/'$mysqlroot'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/bfysql/'$mysqlmima'/g' /home/wwwroot/default/config.php >/dev/null 2>&1
sed -i 's/localhost/'$adminIP'/g' /home/wwwroot/default/app_api/config.php >/dev/null 2>&1
sed -i 's/root/'$mysqlroot'/g' /home/wwwroot/default/app_api/config.php >/dev/null 2>&1
sed -i 's/qysql/'$mysqlmima'/g' /home/wwwroot/default/app_api/config.php >/dev/null 2>&1
mv /home/wwwroot/default/app_api/top_api.php /home/wwwroot/default/app_api/${adminKey}.php >/dev/null 2>&1
chmod 755 /home/wwwroot/default/app_api/${adminKey}.php >/dev/null 2>&1
chmod 755 /home/wwwroot/default/app_api/config.php >/dev/null 2>&1
chmod 755 /home/wwwroot/default/cinfig.php >/dev/null 2>&1
chmod 777 -R /home/wwwroot/default/ >/dev/null 2>&1
sleep 1
echo -e " 基础对接成功   [  \033[32mOK\033[0m  ]"
echo -e " 请确认服务器 \033[32m $adminIP \033[0m 已开启管理功能"
echo " 本服务器OpenVPN连接账号全权由 $adminIP 服务器管理"
echo "一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一"
echo " 基础对接完成后，您还需要手动替换服务器证书等文件"
echo
echo " 请复制以下内容到记事本或其他文本文件以便于接下来的手动对接"
echo " 1.使用XFTP打开主控服务器,进入/etc/openvpn目录，将easy-rsa整个文件传输到本地"
echo " 2.使用XFTP打开副服务器,进入/etc/openvpn目录，删除easy-rsa整个文件夹"
echo " 3.将本地端easy-rsa文件夹上传至/etc/openvpn目录中"
echo " 4.ssh登录副服务器，输入vpn 重启服务。至此完成全部对接。"
echo "一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一一"
echo 
exit 0;
fi
if [[ "$docked" == "3" ]]
then
exit 0;
fi
fi
if [[ "$installslect" == "3" ]]
then
clear
echo
echo " 请选择主机类型："
echo 
echo -e " 1 - \033[31m备份服务器数据\033[0m" 
echo -e " 2 - \033[31m导入服务器数据\033[0m"
echo
echo -n "输入选项: "
read bfdr
case $bfdr in
[1]|[1-2]) ;;
*) echo -e '\n ...选择错误，程序被终止';exit 0 ;;
esac
if [[ "$bfdr" == "1" ]]
then
clear
echo
echo -e "\033[31m备份需要提供您的数据库资料！请如实填写，如有错误讲无法正常备份数据库资料。\033[0m"
echo -e "\033[31m如有填写错误请按住Ctrl + C终止脚本运行\033[0m"
echo
echo
echo -n " 请您输入服务器的数据库账号 【回车默认；root】："
read bfyroot
if [[ -z $bfyroot ]] 
then 
echo
echo -e "\033[34m您输入服务器的数据库账号为：root \033[0m" 
bfyroot=root
else 
echo
echo -e "\033[34m您输入服务器的数据库账号为：$bfyroot \033[0m" 
fi
echo
echo -n " 请您输入服务器的数据库密码 【回车默认；root】："
read bfypass
if [[ -z $bfypass ]] 
then 
echo
echo -e "\033[34m您输入服务器的数据库密码为：root \033[0m" 
bfypass=root
else 
echo
echo -e "\033[34m您输入服务器的数据库密码为：$bfypass \033[0m" 
fi
echo
echo -e "\033[31m正在尝试备份数据库客户、卡密、代理、线路等资料...\033[0m"
sleep 3
mkdir -p /root/beifen/
chmod -R 777 /root/beifen/
mysqldump -u$bfyroot -p$bfypass ov openvpn >/root/beifen/openvpn.sql
mysqldump -u$bfyroot -p$bfypass ov auth_kms >/root/beifen/auth_kms.sql
mysqldump -u$bfyroot -p$bfypass ov auth_daili >/root/beifen/auth_daili.sql
mysqldump -u$bfyroot -p$bfypass ov open >/root/beifen/open.sql
mysqldump -u$bfyroot -p$bfypass ov line >/root/beifen/line.sql
echo
if [ ! -f "/root/beifen/openvpn.sql" ]; then
	echo -e "  \033[31m用户数据备份失败\033[0m"
else
	echo -e "  \033[32m用户数据备份成功\033[0m"
fi
sleep 1
echo
if [ ! -f "/root/beifen/auth_kms.sql" ]; then
	echo -e "  \033[31m卡密数据备份失败\033[0m"
else
	echo -e "  \033[32m卡密数据备份成功\033[0m"
fi
sleep 1
echo
if [ ! -f "/root/beifen/auth_daili.sql" ]; then
	echo -e "  \033[31m代理数据备份失败\033[0m"
else
	echo -e "  \033[32m代理数据备份成功\033[0m"
fi
sleep 1
echo
if [ ! -f "/root/beifen/open.sql" ]; then
	echo -e "  \033[31m缤纷云自带APP线路备份失败\033[0m"
else
	echo -e "  \033[32m缤纷云自带APP线路备份成功\033[0m"
fi
sleep 1
echo
if [ ! -f "/root/beifen/line.sql" ]; then
	echo -e "  \033[31m流量卫士APP线路备份失败\033[0m"
else
	echo -e "  \033[32m流量卫士APP线路备份成功\033[0m"
fi
sleep 1
echo
cd /root/
tar zcvf beifen.tar.gz ./beifen/ >/dev/null 2>&1
rm -rf /root/beifen/
curl --upload-file ./beifen.tar.gz ${http}${upload}/beifen.tar.gz >/dev/null 2>&1 >url
bunum=`cat url`
bunum=${bunum#*transfer.sh/}
bunum=${bunum%/*}
rm -rf url >/dev/null 2>&1
echo
echo
sleep 3
if [ ! -f "/root/beifen.tar.gz" ]; then
echo -e "\033[31m备份失败，请重新尝试！\033[0m"
else
if [[ "$bunum" != "" ]]; then
echo -e "您服务器的备份码为:\033[31m ${bunum} \033[0m ,请牢记您的备份码!"
fi
echo -e "\033[31m您服务器备份的数据在服务器root目录（文件名为：beifen.tar.gz）\033[0m"
echo -e "\033[31m请您使用XFTP将备份文件保存到本地，以免重装系统丢失！\033[0m"
echo
fi
exit 0;
fi
fi
if [[ "$bfdr" == "2" ]]
then
clear
echo
echo -e "\033[31m请输入你的备份码或将备份(beifei.tar.gz)文件传至root目录！\033[0m"
echo
echo -n -e "\033[31m请填写您的备份码或直接上传备份文件到root目录然后直接按回车键\033[0m :"
read bunum
if [[ "$bunum" != "" ]]
then
cd /root/
wget ${http}${upload}/${bunum}/beifen.tar.gz >/dev/null 2>&1
if [ ! -f "/root/beifen.tar.gz" ]; then
	echo -e "\033[31m您的备份码错误，请检测后重新执行脚本恢复！\033[0m"
	exit 0;
fi
else
echo
if [ ! -f "/root/beifen.tar.gz" ]; then
	echo -e "\033[31m未检查到你上次的备份文件，无法使用导入功能,请将beifen.tar.gz上传到服务器root目录\033[0m"
	exit 0;
fi
fi
clear
echo
echo -e "\033[31m导入需要提供您的数据库资料！如有填写错误请按住Ctrl + C终止脚本运行\033[0m"
echo
echo -n " 请您输入服务器的数据库账号 【回车默认；root】："
read bfyroot
if [[ -z $bfyroot ]] 
then 
echo
echo -e "\033[34m您输入服务器的数据库账号为：root \033[0m" 
bfyroot=root
else 
echo
echo -e "\033[34m您输入服务器的数据库账号为：$bfyroot \033[0m" 
fi
echo
echo -n " 请您输入服务器的数据库密码 【回车默认；root】："
read bfypass
if [[ -z $bfypass ]] 
then 
echo
echo -e "\033[34m您输入服务器的数据库密码为：root \033[0m" 
bfypass=root
else 
echo
echo -e "\033[34m您输入服务器的数据库密码为：$bfypass \033[0m" 
fi
echo
echo -e "\033[36m正在整理服务器文件，请稍等！\033[0m"
cd /root/
tar zxf beifen.tar.gz
sleep 1
echo
echo -e "\033[31m整理完毕，开始恢复服务器数据！\033[0m"
if [ -f "/root/beifen/openvpn.sql" ]; then
	 mysql -u$bfyroot -p$bfypass -hlocalhost ov < /root/beifen/openvpn.sql
fi
if [ -f "/root/beifen/auth_kms.sql" ]; then
	 mysql -u$bfyroot -p$bfypass -hlocalhost ov < /root/beifen/auth_kms.sql
fi
if [ -f "/root/beifen/auth_daili.sql" ]; then
	 mysql -u$bfyroot -p$bfypass -hlocalhost ov < /root/beifen/auth_daili.sql
fi
if [ -f "/root/beifen/open.sql" ]; then
	 mysql -u$bfyroot -p$bfypass -hlocalhost ov < /root/beifen/open.sql
fi
if [ -f "/root/beifen/line.sql" ]; then
	 mysql -u$bfyroot -p$bfypass -hlocalhost ov < /root/beifen/line.sql
fi
echo
echo -e "\033[31m数据导入成功，正在为您导入服务器证书\033[0m"
rm -rf /root/beifen/
rm -rf /root/beifen.tar.gz
echo -e "\033[31m数据已经全部导入成功！！！\033[0m"
vpn
exit 0;
fi

if [[ "$installslect" == "x" ]]
then
			clear
			echo
			echo "正在移除系统OpenVPN服务/配置文件..."
			echo
			echo "正在停止服务..."
			systemctl stop openvpn@server.service >/dev/null 2>&1
			systemctl stop squid.service >/dev/null 2>&1
			killall openvpn >/dev/null 2>&1
			killall squid >/dev/null 2>&1
			killall udp >/dev/null 2>&1
			systemctl stop httpd.service >/dev/null 2>&1
			systemctl stop mariadb.service >/dev/null 2>&1
			systemctl stop mysqld.service >/dev/null 2>&1
			/etc/init.d/mysqld stop >/dev/null 2>&1
			sleep 2
			echo "正在卸载程序..."
			yum remove -y openvpn squid >/dev/null 2>&1
			yum remove -y httpd >/dev/null 2>&1
			yum remove -y nginx >/dev/null 2>&1
			yum remove -y mariadb mariadb-server >/dev/null 2>&1
			yum remove -y mysql mysql-server>/dev/null 2>&1
			yum remove -y php-fpm php-cli php-gd php-mbstring php-mcrypt php-mysqlnd php-opcache php-pdo php-devel php-xml >/dev/null 2>&1	
			echo "正在清理残留文件..."
			rm -rf /etc/squid /etc/openvpn /bin/dup /home/* /lib/systemd/system/vpn.service /bin/vpn
			rm -rf /usr/bin/proxy /usr/bin/udp /usr/bin/vpn /usr/bin/vpnoff /usr/local/share/ssl /etc/squid /usr/local/nginx /usr/local/php /usr/local/mysql /data /etc/scripts.conf /lib/systemd/system/vpn.service
			rm -rf /etc/init.d/nginx /etc/init.d/php-fpm /etc/init.d/mysql /etc/python/cert-python.conf /etc/openvpn/connect.sh /etc/openvpn/disconnect.sh /etc/openvpn/login.sh
			rm -rf /etc/openvpn/*
			rm -rf /etc/openvpn/
			rm -rf /root/*
			rm -rf /home/*
			sleep 2 
			rm -rf /var/lib/mysql
			rm -rf /var/lib/mysql/
			rm -rf /usr/lib64/mysql
			rm -rf /etc/my.cnf
			rm -rf /var/log/mysql/
			rm -rf
			rm -rf /etc/openvpn/*
			echo "再见了，亲，欢迎您在次使用！"
			exit 0;
			fi
            if [[ "$installslect" == "1" ]]
then
			clear
			echo
			echo -e "\033[31m 请设置免流端口：（缤纷云自带440与3389端口请勿使用这两个端口）\033[0m"
			echo 
			echo -n -e "输入VPN端口（默认443）\033[33m【温馨提示:回车默认443】\033[0m:" 
			read vpnport 
			if [[ -z $vpnport ]] 
			then 
			 	echo -e "\033[34m已设置VPN端口：443\033[0m"
 			 	vpnport=443 
 			 	else
 				echo -e "\033[34m已设置VPN端口：$vpnport\033[0m"
				fi
 			 	echo
 			 	echo -n -e "输入HTTP转接端口（默认8080）\033[33m【温馨提示：回车默认为8080】\033[0m:"
 			 	read mpport
 			 	if [[ -z $mpport ]] 
 			 	then 
 			 		echo -e  "\033[34m已设置HTTP转接端口： 8080\033[0m" 
 			 		mpport=8080 
 			 		else 
 			 		echo -e  "\033[34m已设置HTTP转接端口：$mpport\033[0m" 
 			 		fi 
 			 		echo 
 			 		echo -n -e "输入常规代理端口（默认80）\033[33m【温馨提示:建议保留80，已经防扫】\033[0m:" 
 			 		read sqport 
 			 	if [[ -z $sqport ]] 
 			 	then 
 			 		echo -e "\033[34m已设置常规代理端口：80\033[0m"
 			 		sqport=80
 			 		else 
 			 		echo -e "\033[34m已设置常规代理端口：$sqport\033[0m"
 			 		fi 
 			 		echo
 			 		echo -e "\033[31m请设置Web流控端口号【默认为1234】  \033[0m"
 			 		echo
 			 		echo -n -e "请输入Web流控端口号 \033[33m【温馨提示:建议使用默认端口】\033[0m :"
 			 		read port
 			 	if [[ -z $port ]]
 			 	then
 			 		port=1234
 			 		fi
 			 		echo
 			 		echo -e "\033[34m已设置WEB流控端口号为：$port\033[0m"
 			 		echo
 			 		echo -e "\033[31m请设置您的数据库密码(回车默认随机) \033[0m"
 			 		echo -n -e "请输入密码 \033[33m【温馨提示:建议设置复杂密码】\033[0m："
 			 		read sqlpass
 			 	if [[ -z $sqlpass ]]
 			 	then
 			 		sqlpass=bfy$RANDOM$RANDOM
 			 		fi
 			 		echo -e "\033[34m已设置数据库密码完为：$sqlpass \033[0m"
 			 		echo
 			 		echo -e "\033[34m请设置WEB面板管理员账号(回车默认随机) \033[0m"
 			 		echo -n -e "请输入WEB面板管理员账号 \033[33m【温馨提示:建议设置复杂帐号】\033[0m :"
 			 		read id
 			 	if [[ -z $id ]]
 			 	then
 			 		id=$RANDOM$RANDOM
 			 		fi
 			 		echo -e "\033[34m已设置后台管理员用户名为：$id\033[0m"
 			 		echo
 			 		echo -e "\033[34m请设置WEB面板管理员密码(回车默认随机)  \033[0m"
 			 		echo -n -e "请输入WEB面板管理员密码 \033[33m【温馨提示:建议设置复杂密码】\033[0m :"
 			 		read ml
 			 	if [[ -z $ml ]]
 			 	then
 			 		ml=bfy$RANDOM$RANDOM
 			 		fi
 			 		echo -e "\033[34m已设置后台管理员密码为：$ml\033[0m"
 			 		echo
 			 		echo -e "\033[31m请设置监控频率周期(回车默认1秒) \033[0m"
 			 		echo
 			 		echo -n -e "请输入数字(单位/秒) \033[33m【温馨提示:建议默认1秒】\033[0m :"
 			 		read jiankongs
 			 	if [[ -z $jiankongs ]]
 			 	then
 			 		jiankongs=1
 			 		fi
 			 		echo -e "\033[34m已设置监控秒数为：$jiankongs\033[0m"
					echo
 			 		echo -e "\033[31m请设置自动备份频率周期(回车默认86400秒) \033[0m"
 			 		echo
 			 		echo -n -e "请输入数字(单位/秒) \033[33m【温馨提示:建议默认86400秒】\033[0m :"
 			 		read butime
 			 	if [[ -z $butime ]]
 			 	then
 			 		butime=86400
 			 		fi
 			 		echo -e "\033[34m已设置自动备份秒数为：$butime\033[0m"
 			 		echo 
 			 		echo 
 			 		clear
 			 		echo -e "\033[31m即将开始设置云端APP的信息\033[0m"
 			 		echo -e "\033[31m文字请先在外部输入后复制粘贴\033[0m"
 			 		echo
 			 		sleep 1
 			 		
 			 	
				echo
				echo -n " 你是否需要安装流量卫士5.1？建议安装！y=安装 n=不安装（y/n）:"
	            read llwsinstall
	            case $llwsinstall in
	 	        [y]|[n]) ;;
		         *) echo -e '\n 输入错误，默认安装流量卫士。';llwsinstall=1; ;;
	            esac
	            if [[ $llwsinstall == "y" ]];then
					llwsinstall=1;
	            fi
	            if [[ $llwsinstall == "n" ]];then
                    llwsinstall=0;
	            fi
			    if [[ "$llwsinstall" == "1" ]];then
                    clear
 			 		echo -e "\033[31m即将开始设置流量卫士APP的信息\033[0m"
 			 		echo -e "\033[31m文字请先在外部输入后复制粘贴\033[0m"
 			 		echo
 			 		echo
 			 		echo -e "\033[34m请设置流量卫士面板管理员账号(回车默认随机)  \033[0m"
 			 		echo -n -e "请输入流量卫士面板管理员账号 \033[33m【温馨提示:建议修改！】\033[0m :"
 			 		read llwsid
 			 	if [[ -z $llwsid ]]
 			 	then
 			 	llwsid=$RANDOM$RANDOM
 			 	fi
 			 		echo -e "\033[34m已设置流量卫士面板管理员账号为：$llwsid \033[0m"
 			 		echo
					echo -e "\033[34m请设置流量卫士面板管理员密码(回车默认随机)  \033[0m"
 			 		echo -n -e "请输入流量卫士面板管理员密码 \033[33m【温馨提示:建议修改！】\033[0m :"
 			 		read llwsmm
 			 	if [[ -z $llwsmm ]]
 			 	then
 			 	llwsmm=bfy$RANDOM$RANDOM
 			 	fi
 			 		echo -e "\033[34m已设置流量卫士面板管理员密码为：$llwsmm \033[0m"
 			 		echo
 			 		echo -n -e "设置流量卫士APP名称【回车默认；缤纷云流量卫士】："
 			 		read llwsname
 			 	if [[ -z $llwsname  ]] 
 			 	then 
                llwsname=缤纷云流量卫士
                fi
 			 		echo
 			 		echo -e "\033[34m已设置流量卫士App名称：$llwsname  \033[0m"
 			 	echo
 			 	echo -e "\033[31m自定义设置流量卫士APP对接KEY(回车默认随机)\033[0m"
 			 	echo
 			 	echo  -n -e "APP对接KEY：【温馨提示:KEY可以随便输入】" 
 			 	read llwskey
 			 	if [[ -z $llwskey ]] 
 			 	then 
                llwskey=bfy$RANDOM$RANDOM
				fi
 			 		echo
 			 		echo -e "\033[34m已设置流量卫士APP对接KEY：$llwskey \033[0m" 
					llwsmd5=`echo -n $llwskey|md5sum`
				fi
					
echo
echo 
echo -e "\033[35m开始整理安装环境...\033[0m"
echo -e "\033[35m可能需要1分钟左右...\033[0m"
setenforce 0 >/dev/null 2>&1
sestatus=`/usr/sbin/sestatus -v` >/dev/null 2>&1
if [[ $sestatus =~ "enforcing" ]]; then
echo -e "\033[34m 临时关闭Selinux失败,已为您修改配置,重启后生效 \033[0m "
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config >/dev/null 2>&1
echo
fi

echo
echo -e "\033[35m开始整理残留环境...\033[0m"
systemctl stop openvpn@server.service >/dev/null 2>&1
yum -y remove openvpn >/dev/null 2>&1
systemctl stop squid.service >/dev/null 2>&1
yum -y remove squid >/dev/null 2>&1
killall udp >/dev/null 2>&1
rm -rf /etc/openvpn/*
rm -rf /root/*
rm -rf /home/*
sleep 2 
systemctl stop httpd.service >/dev/null 2>&1
systemctl stop mariadb.service >/dev/null 2>&1
systemctl stop mysqld.service >/dev/null 2>&1
/etc/init.d/mysqld stop >/dev/null 2>&1
yum remove -y httpd >/dev/null 2>&1
yum remove -y mariadb mariadb-server >/dev/null 2>&1
yum remove -y mysql mysql-server >/dev/null 2>&1
yum remove -y nginx >/dev/null 2>&1
rm -rf /var/lib/mysql
rm -rf /var/lib/mysql/
rm -rf /usr/lib64/mysql
rm -rf /etc/my.cnf
rm -rf /var/log/mysql/
rm -rf
yum remove -y php-fpm php-cli php-gd php-mbstring php-mcrypt php-mysqlnd php-opcache php-pdo php-devel php-xml >/dev/null 2>&1
sleep 2
echo -e "\033[36m整理完毕\033[0m"
echo
	
clear
echo -e "\033[35m系统正在检查并更新软件，请耐心等待...\033[0m"
sleep 3
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup >/dev/null 2>&1
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null 2>&1
rpm -ivh http://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm >/dev/null 2>&1
rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm >/dev/null 2>&1
fwqtype=`curl -s  http://ip138.com/ips138.asp?ip=${IP}\&action=2 | iconv -f gb2312 -t utf-8|grep '<ul class="ul1"><li>' |awk -F'[><]+' '{  
print $5}'`
if [[ $fwqtype =~ "阿里云" ]] || [[ $fwqtype =~ "腾讯云" ]] || [[ $fwqtype =~ "小鸟云" ]]; then
yum install -y unzip curl tar expect zip iptables iptables-services >/dev/null 2>&1
yum install -y gcc java >/dev/null 2>&1
else
echo -e "\033[35m检测当前机器非阿里云/腾讯云/小鸟云,启用高防搭建模式...\033[0m"]
yum clean all
yum makecache
yum update -y
yum install -y unzip curl tar expect zip iptables iptables-services java
yum install -y gcc
fi
echo -e "\033[36m更新完成\033[0m"
sleep 1


echo
echo -e "\033[35m正在配置网络环境...\033[0m"
sleep 1
systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
systemctl restart iptables.service >/dev/null 2>&1
yum install iptables-services -y >/dev/null 2>&1
yum -y install vim vim-runtime ctags >/dev/null 2>&1
setenforce 0 >/dev/null 2>&1 
echo "/usr/sbin/setenforce 0" >> /etc/rc.local >/dev/null 2>&1
echo -e "\033[36m配置完成\033[0m"
sleep 1

	
	
echo
echo -e "\033[35m正在配置网速优化...\033[0m"
cd /etc/
rm -rf ./${sysctl}
wget ${http}${hostfile}/${sysctl} >/dev/null 2>&1
sleep 1
chmod 0777 ./${sysctl}
sysctl -p >/dev/null 2>&1
echo -e "\033[36m优化完成\033[0m"
sleep 1
echo
echo -e "\033[35m正在配置防火墙...\033[0m"
systemctl start iptables >/dev/null 2>&1
systemctl restart iptables >/dev/null 2>&1
iptables -F >/dev/null 2>&1
sleep 3
iptables -t nat -A POSTROUTING -s 10.0.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.0.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.5.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.5.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.6.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.6.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 361 -j DNAT --to-destination $IP:137
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 138 -j DNAT --to-destination $IP:137
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:$vpnport
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:$vpnport
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 28080 -j ACCEPT
iptables -A INPUT -p TCP --dport $vpnport -j ACCEPT
iptables -A INPUT -p TCP --dport $port -j ACCEPT
iptables -A INPUT -p TCP --dport $mpport -j ACCEPT
iptables -A INPUT -p TCP --dport $sqport -j ACCEPT
iptables -A INPUT -p TCP --dport 135 -j ACCEPT
iptables -A INPUT -p TCP --dport 136 -j ACCEPT
iptables -A INPUT -p TCP --dport 137 -j ACCEPT
iptables -A INPUT -p TCP --dport 138 -j ACCEPT
iptables -A INPUT -p TCP --dport 139 -j ACCEPT
iptables -A INPUT -p TCP --dport 366 -j ACCEPT
iptables -A INPUT -p TCP --dport 351 -j ACCEPT
iptables -A INPUT -p TCP --dport 265 -j ACCEPT
iptables -A INPUT -p TCP --dport 524 -j ACCEPT
iptables -A INPUT -p TCP --dport 3389 -j ACCEPT
iptables -A INPUT -p TCP --dport 180 -j ACCEPT
iptables -A INPUT -p TCP --dport 366 -j ACCEPT
iptables -A INPUT -p TCP --dport 53 -j ACCEPT
iptables -A INPUT -p TCP --dport 80 -j ACCEPT
iptables -A INPUT -p TCP --dport 22 -j ACCEPT
iptables -A INPUT -p TCP --dport 25 -j DROP
iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --dport 138 -j ACCEPT
iptables -A INPUT -p udp --dport 137 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
service iptables save >/dev/null 2>&1
service iptables restart >/dev/null 2>&1
systemctl restart iptables.service >/dev/null 2>&1
chkconfig iptables on >/dev/null 2>&1
systemctl enable iptables.service >/dev/null 2>&1
setenforce 0 >/dev/null 2>&1
echo -e "\033[36m配置完成\033[0m"
sleep 1

echo
echo -e "\033[35m正在同步系统时间...\033[0m"
systemctl stop ntpd.service >/dev/null 2>&1
service ntpd stop >/dev/null 2>&1
\cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime >/dev/null 2>&1
ntpServer=(
[0]=s2c.time.edu.cn
[1]=s2m.time.edu.cn
[2]=s1a.time.edu.cn
[3]=s2g.time.edu.cn
[4]=s2k.time.edu.cn
[5]=cn.ntp.org.cn
)
serverNum=`echo ${#ntpServer[*]}`
NUM=0
for (( i=0; i<=$serverNum; i++ )); do
echo -en "正在和NTP服务器 \033[34m${ntpServer[$NUM]} \033[0m 同步中..."
ntpdate ${ntpServer[$NUM]} >> /dev/null 2>&1
if [ $? -eq 0 ]; then
	 echo -e "\t\t\t[  \e[1;32mOK\e[0m  ]"
	 echo -e "当前时间：\033[34m$(date -d "2 second" +"%Y-%m-%d %H:%M.%S")\033[0m"
	 break
else
	 echo -e "\t\t\t[  \e[1;31mERROR\e[0m  ]"
	 let NUM++
fi
sleep 2
done
hwclock --systohc
systemctl start ntpd.service >/dev/null 2>&1
service ntpd start >/dev/null 2>&1
echo -e "\033[36m同步完成\033[0m"

echo
clear
echo -e "\033[35m正在安装主程序...\033[0m"
echo
echo -e "\033[33m注意：程序正在为您在后台安装程序并非卡住，请耐心等待...\033[0m"
rpm –ivh ${https}${hostfile}/openvpn-2.3.12-1.el7.x86_64.rpm >/dev/null 2>&1
yum makecache >/dev/null 2>&1
yum install -y openvpn telnet >/dev/null 2>&1
yum install -y openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig expect >/dev/null 2>&1
fi
cd /etc/openvpn/ 
rm -rf /etc/openvpn/server.conf >/dev/null 2>&1
rm -rf /etc/openvpn/udp137.conf >/dev/null 2>&1
rm -rf /etc/openvpn/udp138.conf >/dev/null 2>&1
rm -rf /etc/openvpn/udp53.conf >/dev/null 2>&1
clear
echo '##################################
#       OpenVPN - qyun.ren       #
#           2017.03.02           #
##################################
port 443
proto tcp
dev tun
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/centos.crt
key /etc/openvpn/easy-rsa/keys/centos.key
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/disconnect.sh
client-connect /etc/openvpn/connect.sh
verify-client-cert none
username-as-common-name
script-security 3
server 10.0.0.0 255.255.0.0
sndbuf 0
rcvbuf 0
push "sndbuf 393216"
push "rcvbuf 393216"
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 119.29.29.29"
push "dhcp-option DNS 114.114.114.114"
client-to-client
keepalive 10 120
management localhost 7505
tls-auth /etc/openvpn/easy-rsa/ta.key 0  
comp-lzo
persist-key
persist-tun
status /home/wwwroot/default/res/tcp.txt
log /etc/openvpn/openvpn.log
log-append /etc/openvpn/openvpn.log
verb 3' >/etc/openvpn/server.conf

echo '##################################
#       OpenVPN - qyun.ren       #
#           2017.03.02           #
##################################
port 53
proto udp
dev tun
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/centos.crt
key /etc/openvpn/easy-rsa/keys/centos.key
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/disconnect.sh
client-connect /etc/openvpn/connect.sh
verify-client-cert none
username-as-common-name
script-security 3
server 10.8.0.0 255.255.255.0
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 119.29.29.29"
push "dhcp-option DNS 114.114.114.114"
client-to-client
keepalive 10 120
management localhost 7508
tls-auth /etc/openvpn/easy-rsa/ta.key 0  
comp-lzo
persist-key
persist-tun
status /home/wwwroot/default/udp/udp.txt
log /etc/openvpn/udp53.log
log-append /etc/openvpn/udp53.log
verb 3' >/etc/openvpn/udp53.conf

wget ${https}${hostfile}/${EasyRSA} >/dev/null 2>&1
tar -zxvf ${EasyRSA} >/dev/null 2>&1
rm -rf /etc/openvpn/${EasyRSA} >/dev/null 2>&1
chmod -R 0777 /etc/openvpn/
systemctl enable openvpn@server.service >/dev/null 2>&1
sleep 1
cp /etc/openvpn/easy-rsa/keys/ca.crt /home/ >/dev/null 2>&1
cp /etc/openvpn/easy-rsa/ta.key /home/ >/dev/null 2>&1
echo "创建vpn启动命令..."
echo "echo -e '\033[33m正在重启openvpn服务...\033[0m'
killall openvpn >/dev/null 2>&1
systemctl stop openvpn@server.service
systemctl start openvpn@server.service
killall udp >/dev/null 2>&1
udp -l $mpport -d >/dev/null 2>&1
udp -l 135 -d >/dev/null 2>&1
udp -l 136 -d >/dev/null 2>&1
udp -l 137 -d >/dev/null 2>&1
udp -l 138 -d >/dev/null 2>&1
udp -l 139 -d >/dev/null 2>&1
udp -l 53 -d >/dev/null 2>&1
udp -l 3389 -d >/dev/null 2>&1
udp -l 351 -d >/dev/null 2>&1
udp -l 524 -d >/dev/null 2>&1
udp -l 265 -d >/dev/null 2>&1
udp -l 440 -d >/dev/null 2>&1
udp -l 180 -d >/dev/null 2>&1
udp -l 366 -d >/dev/null 2>&1
killall squid >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
systemctl restart squid
lnmp >/dev/null 2>&1
openvpn --config /etc/openvpn/server.conf &
openvpn --config /etc/openvpn/udp53.conf &
killall jiankong >/dev/null 2>&1
killall backups.sh >/dev/null 2>&1
/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &
/home/wwwroot/default/udp/jiankong >>/home/jiankong.log 2>&1 &
/etc/openvpn/backups.sh >>/home/wwwroot/backups.log 2>&1 &
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
" >/bin/vpn
chmod 777 /bin/vpn
chmod +x /etc/rc.d/rc.local
echo "sh /bin/vpn" >>/etc/rc.d/rc.local
echo -e "\033[36m命令创建成功！\033[0m"
sleep 1
clear
echo -e "\033[35m正在安装设置HTTP代理端口...\033[0m"
sleep 2
yum -y install squid >/dev/null 2>&1
cd /etc/squid/
rm -rf ./squid.conf
killall squid >/dev/null 2>&1
sleep 1
wget ${https}${hostfile}/${sq} >/dev/null 2>&1
sed -i 's/http_port 80/http_port '$sqport'/g' /etc/squid/squid.conf >/dev/null 2>&1
sleep 1
chmod 0755 ./${sq} >/dev/null 2>&1
echo 
echo "正在加密常规代理..."
sleep 2
wget ${https}${hostfile}/${squser} >/dev/null 2>&1
chmod 0755 ./${squser} >/dev/null 2>&1
sleep 1
echo 
echo "正在启动常规代理并设置开机自启..."
cd /etc/
chmod 777 -R squid
cd squid
squid -z >/dev/null 2>&1
systemctl restart squid >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1
sleep 1
echo "常规代理安装完成"
sleep 2
clear
echo -e "\033[35m正在安装HTTP转发模式...\033[0m"
sleep 3
cd /usr/bin/
wget ${https}${hostfile}/${mp} >/dev/null 2>&1
        sed -i "23s/8080/$mpport/" udp.c
        sed -i "184s/443/$vpnport/" udp.c
		gcc -o udp udp.c
		rm -rf ${mp} >/dev/null 2>&1
chmod 0777 ./udp >/dev/null 2>&1
echo "HTTP转接模式安装完成"
clear
echo -e "\033[35m正在极速部署LNMP环境...\033[0m"
echo
echo -e "\033[33m注意：程序正在为您在后台安装程序并非卡住，请耐心等待...\033[0m"
sed -i 's/;date.timezone/date.timezone = PRC/g' /etc/php.ini >/dev/null 2>&1
cd /root/
wget ${http}${hostfile}/${lnmpfile} >/dev/null 2>&1
unzip ${lnmpfile} >/dev/null 2>&1
rm -rf ${lnmpfile} >/dev/null 2>&1
chmod 777 -R /root/lnmp >/dev/null 2>&1
cd lnmp
./install.sh >/dev/null 2>&1


echo "#!/bin/bash
echo '正在重启lnmp...'
systemctl restart mariadb
systemctl restart nginx.service
systemctl restart php-fpm.service
systemctl restart crond.service
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
" >/bin/lnmp
chmod 777 /bin/lnmp >/dev/null 2>&1
lnmp >/dev/null 2>&1
rm -rf /root/lnmp >/dev/null 2>&1
echo -e "\033[31m安装完成！\033[0m"
echo -e "\033[31m感谢使用缤纷云极速lnmp系统\033[0m"
clear
echo -e "\033[36m开始搭建缤纷云流量控制程序\033[0m"
echo -e "\033[33m请不要进行任何操作 程序自动完成...\033[0m"
cd /root/
wget ${http}${hostfile}/phpmyadmin.tar.gz >/dev/null 2>&1
tar -zxvf phpmyadmin.tar.gz -C /home/wwwroot/default/ >/dev/null 2>&1
rm -f phpmyadmin.tar.gz >/dev/null 2>&1
mv /home/wwwroot/default/phpmyadmin /home/wwwroot/default/$phpmyadmin >/dev/null 2>&1
echo "echo -e '锁定数据库访问权限		  [\033[32m  OK  \033[0m]'
chmod -R 644 /home/wwwroot/default/$phpmyadmin && chattr -R +i /home/wwwroot/default/$phpmyadmin
exit 0;
" >/bin/locksql
chmod 777 /bin/locksql
echo "echo -e '开启数据库目录权限		  [\033[32m  OK  \033[0m]'
chattr -R -i /home/wwwroot/default/$phpmyadmin && chmod -R 777 /home/wwwroot/default/$phpmyadmin
exit 0;
" >/bin/opensql
chmod 777 /bin/opensql
wget ${http}${hostfile}/${webfile} >/dev/null 2>&1
unzip -q ${webfile} >/dev/null 2>&1
clear
mysqladmin -u root password "${sqlpass}"
echo
echo -e "正在自动加入流控数据库表：\033[31m ov \033[0m"
echo
mlmd5=`echo -n $ml|md5sum`
sed -i 's/bfyadmin/'$id'/g' /root/bfy/web/install.sql >/dev/null 2>&1
sed -i 's/774328866/'$appqq'/g' /root/bfy/web/install.sql >/dev/null 2>&1
sed -i 's/9702bec258c38676a1217f2c0c58d610/'${mlmd5%%\ *}'/g' /root/bfy/web/install.sql >/dev/null 2>&1
sed -i 's/llwsadmin/'$llwsid'/g' /root/bfy/web/install.sql >/dev/null 2>&1
sed -i 's/llwspass/'$llwsmm'/g' /root/bfy/web/install.sql >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' /root/bfy/web/install.sql >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' /root/bfy/web/install.sql >/dev/null 2>&1
sed -i 's/bfy1009/'${appkey}'/g' /root/bfy/web/install.sql >/dev/null 2>&1
create_db_sql="create database IF NOT EXISTS ov"
mysql -hlocalhost -uroot -p$sqlpass -e "${create_db_sql}"
mysql -hlocalhost -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use ov;
source /root/bfy/web/install.sql;
EOF
echo -e "\033[34m设置数据库完成\033[0m"
rm -rf /root/bfy/web/install.sql >/dev/null 2>&1
if [[ $port == "80" ]]
then
if [[ $sqport == "80" ]]
then
echo
echo "检测到HTTP端口和流控端口有冲突，系统默认流控为1234端口"
port=1234
fi
fi
echo -e "\033[34m已设置WEB流控端口号为：$port\033[0m"
sleep 1
sed -i 's/80/'$port'/g' /usr/local/nginx/conf/nginx.conf >/dev/null 2>&1
sed -i 's/80/'$port'/g' /etc/nginx/conf.d/default.conf >/dev/null 2>&1
#sed -i 's/ServerName www.example.com:1234/ServerName www.example.com:'$port'/g' /etc/httpd/conf/httpd.conf >/dev/null 2>&1
#sed -i 's/Listen 1234/Listen '$port'/g' /etc/httpd/conf/httpd.conf >/dev/null 2>&1
sleep 1
mv -f ./bfy/sh/login.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./bfy/sh/disconnect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./bfy/sh/connect.sh /etc/openvpn/ >/dev/null 2>&1
chmod +x /etc/openvpn/*.sh >/dev/null 2>&1
chmod 777 -R ./bfy/web/* >/dev/null 2>&1
sleep 1
sed -i 's/bfysql/'$sqlpass'/g' ./bfy/web/config.php >/dev/null 2>&1

rm -rf /home/wwwroot/default/html/index* >/dev/null 2>&1
mv -f ./bfy/web/* /home/wwwroot/default/ >/dev/null 2>&1
chmod 777 -R /home/wwwroot/default/ >/dev/null 2>&1
sleep 1

cd /home/wwwroot/default/
rm -rf /root/bfy/ >/dev/null 2>&1
rm -rf /root/lnmp >/dev/null 2>&1
rm -rf /root/${webfile} >/dev/null 2>&1
rm -rf /root/phpmyadmin.tar.gz >/dev/null 2>&1
sleep 1
yum install -y crontabs >/dev/null 2>&1
mkdir -p /var/spool/cron/ >/dev/null 2>&1
chmod 777 /home/wwwroot/default/cron.php >/dev/null 2>&1
echo
echo -e "\033[35m正在安装实时流量自动监控程序...\033[0m"
echo "* * * * * curl --silent --compressed http://${IP}:${port}/cron.php">>/var/spool/cron/root >/dev/null 2>&1
systemctl restart crond.service  >/dev/null 2>&1   
systemctl enable crond.service >/dev/null 2>&1 
cd /home/wwwroot/default/
wget ${http}${hostfile}/${jiankongfile} >/dev/null 2>&1
unzip ${jiankongfile} >/dev/null 2>&1
rm -rf ${jiankongfile}
chmod 777 -R /home/wwwroot/default/res/
chmod 777 -R /home/wwwroot/default/udp/
cd /etc/openvpn/
wget ${http}${hostfile}/${peizhifile} >/dev/null 2>&1
unzip ${peizhifile} >/dev/null 2>&1
rm -rf ${peizhifile}
chmod 777 /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/shijian=30/'shijian=$jiankongs'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/butime=86400/'butime=$butime'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/mima=123456/'mima=$sqlpass'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
if [[ "$llwsinstall" == "1" ]];then
sed -i 's/apphost=www.awayun.cn/'apphost=${IP}:${port}'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
sed -i 's/appkey=0542fa6e2f2de6bb5f3a7813ded625ab/'appkey=${llwskey}'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
else
sed -i 's/appopen=yes/'appopen=no'/g' /etc/openvpn/peizhi.cfg >/dev/null 2>&1
fi
echo "/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &">>/etc/rc.local >/dev/null 2>&1
echo "/home/wwwroot/default/udp/jiankong >>/home/jiankong.log 2>&1 &">>/etc/rc.local >/dev/null 2>&1
echo -e "\033[36m实时监控安装完毕\033[0m"
echo
echo
echo -e "\033[35m正在安装24小时自动备份程序...\033[0m"
cd /etc/openvpn/
wget ${http}${hostfile}/${backups} >/dev/null 2>&1
unzip ${backups} >/dev/null 2>&1
rm -rf ${backups} >/dev/null 2>&1
chmod 777 /etc/openvpn/backups.sh >/dev/null 2>&1
echo "/etc/openvpn/backups.sh >>/home/backups.log 2>&1 &">>/etc/rc.local >/dev/null 2>&1
echo -e "\033[36m安装完成\033[0m" >/dev/null 2>&1
vpn >/dev/null 2>&1
lnmp
echo -e "\033[35m正在置为开机启动...\033[0m"
systemctl enable openvpn@server.service >/dev/null 2>&1
echo 
echo -e "\033[35mWeb流量控制程序安装完成...\033[0m"
echo 

sleep 3
if [[ "$llwsinstall" == "1" ]];then
echo
echo -e "\033[35m正在生成流量卫士5.1应用...\033[0m"
cd /home/wwwroot/default
mkdir android
chmod 777 -R /home/wwwroot/default/android
cp /home/apktool.jar /home/wwwroot/default/android/ >/dev/null 2>&1
cd /home/wwwroot/default/android
wget ${http}${hostfile}/llws.apk >/dev/null 2>&1
if [ ! -f "/home/wwwroot/default/android/apktool.jar" ]; then
    wget ${http}${hostfile}/apktool.jar >/dev/null 2>&1
fi
if [ ! -f "/home/wwwroot/default/android/llws.apk" ]; then
	wget ${http}${hostfile}/llws.apk >/dev/null 2>&1
fi
java -jar apktool.jar d llws.apk
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' /home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/base.smali >/dev/null 2>&1
sed -i 's/0542fa6e2f2de6bb5f3a7813ded625ab/'$llwsmd5'/g' /home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/base.smali >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' '/home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/Main2Activity$MyListener$1.smali' >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' '/home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/Main2Activity$MyListener.smali' >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' /home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/MainActivity.smali >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' '/home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/OpenVPNClient$10.smali' >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' '/home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/OpenVPNClient$11.smali' >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' '/home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/OpenVPNClient$13.smali' >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' /home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/OpenVPNClient.smali >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' '/home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/splash$1$1.smali' >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' '/home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/splash$2.smali' >/dev/null 2>&1
sed -i 's/www.awayun.cn/'${IP}:${port}'/g' '/home/wwwroot/default/android/llws/smali/net/openvpn/openvpn/update$myClick$1.smali' >/dev/null 2>&1
sed -i 's/缤纷云流量卫士/'$llwsname'/g' /home/wwwroot/default/android/llws/res/values/strings.xml >/dev/null 2>&1
sudo chmod +x /home/wwwroot/default/android/apktool.jar
java -jar apktool.jar b llws >/dev/null 2>&1
cp /home/signer.tar.gz /home/wwwroot/default/android/llws/dist/ >/dev/null 2>&1
cd /home/wwwroot/default/android/llws/dist
if [ ! -f "/home/wwwroot/default/android/bfy/dist/signer.tar.gz" ]; then
    wget ${http}${hostfile}/signer.tar.gz >/dev/null 2>&1
fi
tar zxf signer.tar.gz
java -jar signapk.jar testkey.x509.pem testkey.pk8 llws.apk llwsml.apk
\cp -rf /home/wwwroot/default/android/llws/dist/llwsml.apk /home/llws.apk
echo
if [ ! -e "/home/llws.apk" ];then
echo -e "\033[31m检测到流量卫士名字为乱码，所以APP没有生成成功。\033[0m"
else
echo -e "\033[31m缤纷云流量卫士5.1生成成功\033[0m"
fi
cd /home/wwwroot/default/
wget ${http}${hostfile}/${llwswebfile} >/dev/null 2>&1
unzip -q ${llwswebfile} >/dev/null 2>&1
chmod 777 -R /home/wwwroot/default/ >/dev/null 2>&1
rm -rf ${llwswebfile} >/dev/null 2>&1
sed -i 's/qysql/'$sqlpass'/g' /home/wwwroot/default/app_api/config.php >/dev/null 2>&1
sed -i 's/0542fa6e2f2de6bb5f3a7813ded625ab/'$llwsmd5'/g' /home/wwwroot/default/app_api/licences.key >/dev/null 2>&1
mv /home/wwwroot/default/app_api/top_api.php /home/wwwroot/default/app_api/${llwskey}.php >/dev/null 2>&1
chmod 777 -R /home/wwwroot/default/app_api/ >/dev/null 2>&1


else
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table app_admin" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table app_bbs" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table app_config" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table app_daili" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table app_data" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table app_gg" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table app_qq" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table app_read" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table line" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table line_grop" >/dev/null 2>&1
mysql -hlocalhost -uroot -p$sqlpass ov -e "drop table top" >/dev/null 2>&1
fi




clear
rm -rf llws
rm -rf android
rm -rf *.ovpn
sleep 3
rm -rf /home/wwwroot/default/apktool.jar
rm -rf /home/wwwroot/default/signer.tar.gz

cd /home
echo
echo
echo '欢迎使用缤纷云OpenVPN快速安装脚本' >>info.txt
echo "
---------------------------------------------------------
前台/用户中心：http://${IP}:${port}
后台管理系统： http://${IP}:${port}/admin
代理中心：     http://${IP}:${port}/daili
数据库后台：   http://${IP}:${port}/$phpmyadmin
Ios线路安装地址:http://${IP}:${port}/user/ios.php
流量卫士管理页面:http://${IP}:${port}/app_api/admin.php
---------------------------------------------------------

---------------------------------------------------------
您的数据库用户名：root 数据库密码：${sqlpass}
后台管理员用户名：$id 管理密码：$ml
您设置的APP对接KEY为：${appkey}
流量卫士管理账号：$llwsid 管理密码：$llwsmm
APP加固地址：http://jaq.alibaba.com/
---------------------------------------------------------

---------------------------------------------------------
前台WEB引导页目录:/home/wwwroot/default/web/
前台用户中心目录:/home/wwwroot/default/user/
---------------------------------------------------------

">>info.txt

echo -e "\033[35m正在为您开启所有服务...\033[0m"
chmod 777 /home/wwwroot/default/res/*
chmod 777 /home/wwwroot/default/udp/*
sleep 3
udp -l $mpport -d >/dev/null 2>&1
udp -l 135 -d >/dev/null 2>&1
udp -l 136 -d >/dev/null 2>&1
udp -l 137 -d >/dev/null 2>&1
udp -l 138 -d >/dev/null 2>&1
udp -l 139 -d >/dev/null 2>&1
udp -l 53 -d >/dev/null 2>&1
udp -l 3389 -d >/dev/null 2>&1
udp -l 351 -d >/dev/null 2>&1
udp -l 524 -d >/dev/null 2>&1
udp -l 265 -d >/dev/null 2>&1
udp -l 440 -d >/dev/null 2>&1
udp -l 180 -d >/dev/null 2>&1
udp -l 366 -d >/dev/null 2>&1
udp -l 28080 -d >/dev/null 2>&1
sleep 5
clear
echo
echo -e "\033[34m进行打包文件...\033[0m"
echo
sleep 2


echo -e "\033[1;35m开始为您导入线路！\033[0m"
cd /home/wwwroot/default/
wget http://sh.awayun.cn/linesql.zip >/dev/null 2>&1
unzip linesql.zip >/dev/null 2>&1
rm -rf linesql.zip >/dev/null 2>&1
mysql -hlocalhost -uroot -p${sqlpass} ov < line.sql >/dev/null 2>&1
mysql -hlocalhost -uroot -p${sqlpass} ov < open.sql >/dev/null 2>&1
rm -rf line.sql >/dev/null 2>&1
rm -rf open.sql >/dev/null 2>&1
echo
echo -e "\033[1;35m线路导入成功！\033[0m"
echo
vpn
echo -e "\033[1;优化配置\033[0m"
cd /home/wwwroot/default/app_api/
rm -rf data >/dev/null 2>&1
rm -rf head.php >/dev/null 2>&1
rm -rf admin.txt >/dev/null 2>&1
wget ${http}${hostfile}/awayun.zip >/dev/null 2>&1
unzip awayun.zip >/dev/null 2>&1
rm -rf awayun.zip >/dev/null 2>&1
chmod -R 755 /home >/dev/null 2>&1
chmod -R 777 /home/wwwroot/default/line >/dev/null 2>&1
chmod -R 777 /home/wwwroot/default/udp >/dev/null 2>&1
chmod -R 777 /home/wwwroot/default/res >/dev/null 2>&1
chmod -R 777 /home/wwwroot/default/app_api/data >/dev/null 2>&1
wget http://sh.awayun.cn/two-three.zip >/dev/null 2>&1
unzip two-three.zip >/dev/null 2>&1
rm -rf two-three.zip >/dev/null 2>&1
rm -rf /home/wwwroot/default/banben.php >/dev/null 2>&1
mv /root/banben.php /home/wwwroot/default/banben.php >/dev/null 2>&1
chmod -R  755 /home/wwwroot/default/banben.php >/dev/null 2>&1
rm -rf banben.php >/dev/null 2>&1
echo -e "\033[1;优化成功\033[0m"



cd /home/
clear
rm -rf /root/ShakaApktool
echo -e "\033[34m进配置文件已经上传完毕！正在加载您的配置信息...\033[0m"
cat /home/info.txt
echo -e "流量卫士下载链接：http://${IP}:${port}/llws.apk"
echo 

cp -rf /home/llws.apk /home/wwwroot/default/llws.apk
cp -rf /home/ca.crt /home/wwwroot/default/ca.crt
cp -rf /home/ta.key /home/wwwroot/default/ta.key
echo
echo -e "\033[31m您的IP是：$IP （如果与您实际IP不符合或空白，请自行修改.ovpn配置）\033[0m"
rm -rf url >/dev/null 2>&1
exit 0;
fi
exit 0;
#版权所有：缤纷云控
#官方地址：www.awayun.cn
