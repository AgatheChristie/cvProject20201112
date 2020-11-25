#! /bin/bash
# 搭服脚本

SERVER_PATH=/data/server
PHP_PATH=/data/workspace
NGINX_PATH=/data/conf/nginx/vhost
CROND_PATH=/etc/cron.d
PHP_SQL_FILE=admin.sql
DB_USER=root
SVN_USER=zhangmubang
SVN_PASSWORD=23a11ddd
TMP_DIR=`mktemp -d`
DB_PASS=`cat /data/save/mysql_root 2> /dev/null`
SHOW_CONFIRM=true

# 本机内网ip
INNER_IP=`ifconfig |grep -v 127.0.0.1|sed -n '/inet addr/s/^[^:]*:\([0-9.]\{7,15\}\) .*/\1/p'`
# 默认开启https
IS_HTTPS=true
# 默认不开服
IS_OPEN=false
# 默认不开启高防
IS_HIGH_DEFENSE=false
# 端口间隔
ADD_PORT=1000
# 初始端口
INIT_PORT=31000
# 跨服端口额外增加
CROSS_ADD=20000
# 初始php端口
INIT_PHP_PORT=28000

# 用法
usage () {
    echo "自动搭服,下面所有参数都需要填上"
    echo "用法:"
    echo "$0"
    echo ""
    echo " -svn SvnPATH                  - svn地址"
    echo " -v Version                    - 线上svn中server的版本号"
    echo " -sid ServerId                 - 服唯一ID"
    echo " -pf Platform                  - 平台"
    echo " -gn GameName                  - 游戏名"
    echo " -pid PortId                   - 端口ID (1 - 99)"
    echo " -eip ExtranetIp               - 本机外网ip"
    echo " -dn DonameName                - 域名地址"
    echo " -sk ssl key                   - ssl key 文件地址,例:ssl/214873329590206.key"
    echo " -sp ssl pem                   - ssl pem 文件地址,例:ssl/214873329590206.pem"
    echo " -bip BackupIp                 - 远程备份IP地址"
    echo " -wip WebIp                    - 后台IP地址"
    echo " -wp WebPort                   - 后台端口"
    echo " -no_https                     - (可选)不开启https（默认开启)"
    echo " -no_https                     - (可选)不开启https（默认开启)"
    echo " -st ServerType                - 服务器类型 游戏服为0 跨服为大于0"
    echo " -open_high                    - (可选)开启高防(默认不开启高防)"
    echo " 例子: sh $0 -svn 192.168.31.10/a1_h5 -v v20181113.0 -sid 1 -pf mix -gn ahls -pid 9 -eip 192.168.31.10 -dn www.chihai.com -sk ssl/214873329590206.key -sp ssl/214873329590206.pem -bip 192.168.31.110 -wip 192.168.31.110 -wp 33011 -st 0 -open_server"
}

# 出错
error() {
    echo "错误:$1"
    exit $2
}

# 打印分割线
show_line() {
    echo "==========================================================="
}

# 检查IP地址
check_ip() {
    IP=$1
    VALID_CHECK=$(echo ${IP}|awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}')
    if [ ! ${VALID_CHECK:-no} == "yes" ]; then
            error "输入的服务器地址${IP}错误" 0
    fi
    if ! echo ${IP}|grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$">/dev/null; then
        error "IP:${IP}地址格式出错" 0
    fi
}

# 获取common.conf中某个配置
common_conf_value() {
    CONFDIR=$1
    KEY=$2
    if [ -n "$KEY" ]; then
        echo `cat ${CONFDIR} | grep "${KEY}" | tail -n 1 | sed -e "s/\s*{${KEY},\s*\(.*\)}.*/\1/"`
    fi
}

# 提示确认信息
show_verify() {
    if [ "$SHOW_CONFIRM" = "true" ]; then
        echo -n "确定要执行么?(Yes/No): "
        read SELECT
        case ${SELECT} in
            "Yes");;
            *)exit 1;;
        esac
    fi
}

# 处理参数
while [ $# -ne 0 ] ; do
    PARAM=$1
    shift
    case ${PARAM} in
        -svn) SVN_SERVER=$1; shift;;
        -v) VERSION=$1; shift;;
        -sid) SERVER_ID=$1; shift;;
        -pf) PLATFORM=$1; shift;;
        -gn) GAME_NAME=$1; shift;;
        -pid) PORT_ID=$1; shift;;
        -eip) OUTER_IP=$1; shift;;
        -dn) DOMAIN_NAME=$1; shift;;
        -sk) SSL_KEY=$1; shift;;
        -sp) SSL_PEM=$1; shift;;
        -bip) BACKUP_IP=$1; shift;;
        -wip) WEB_IP=$1; shift;;
        -wp) WEB_PORT=$1; shift;;
        -no_https) IS_HTTPS=false;;
        -open_server) IS_OPEN=true;;
        -open_high) IS_HIGH_DEFENSE=true;;
        -st) SERVER_TYPE=$1; shift;;
        -q) SHOW_CONFIRM=false;;
        -h|-help) usage; exit 0;;
        *) usage; exit 0;;
    esac
done

if !([ ${PORT_ID} -ge 1 ] && [ ${PORT_ID} -le 99 ]); then
    error "端口ID错误${PORT_ID}" 1
fi

if [ ${SERVER_TYPE} -eq 0 ]; then
    echo "游戏服初始化端口号为${INIT_PORT}"
else
	INIT_PORT=`expr ${INIT_PORT} + ${CROSS_ADD}`
	INIT_PHP_PORT=`expr ${INIT_PHP_PORT} + ${CROSS_ADD}`
	echo "跨服初始化端口号为${INIT_PORT}"
fi

GATEWAY_PORT=`expr ${INIT_PORT} + ${PORT_ID}`
LOGIN_PORT=`expr ${GATEWAY_PORT} + ${ADD_PORT}`
ADMIN_PORT=`expr ${LOGIN_PORT} + ${ADD_PORT}`
POLL_PORT=`expr ${ADMIN_PORT} + ${ADD_PORT}`
TCP_CLUSTER_PORT=`expr ${POLL_PORT} + ${ADD_PORT}`

PHP_PORT=`expr ${INIT_PHP_PORT} + ${PORT_ID}`

# server nginx配置文件
SERVER_NGINX_FILE=${GAME_NAME}_s${SERVER_ID}.conf
# php nginx配置文件
PHP_NGINX_FILE=s${SERVER_ID}.${GAME_NAME}.conf


# 检查并判断各种参数是否正确
check_args() {
    if [ ! -z ${SERVER_ID} ]; then
        if [ -d ${SERVER_PATH}/${GAME_NAME}_s${SERVER_ID} ]; then
            error "游戏服${GAME_NAME}_s${SERVER_ID}已存在" 1
        fi
        if [ -d ${PHP_PATH}/${GAME_NAME}/s${SERVER_ID} ]; then
            error "后台${PHP_PATH}/${GAME_NAME}/s${SERVER_ID}已存在" 1
        fi
    else
        error "未输入服唯一ID${SERVER_ID}" 1
    fi
    if [ ! -z ${VERSION} ]; then
        if ! (svn cat svn://${SVN_SERVER}/tags/online/${VERSION}/game/config/common.conf --username ${SVN_USER} --password ${SVN_PASSWORD} > /dev/null 2>&1); then
            error "svn地址${SVN_SERVER}/tags/online/${VERSION}地址出错" 1
        fi
    else
        error "未输入svn的版本号${VERSION}" 1
    fi
    if [ ! -z ${GATEWAY_PORT} ]; then
        if (lsof -i:${GATEWAY_PORT} > /dev/null 2>&1); then
            error "游戏端口${GATEWAY_PORT}被占用" 1
        fi
    else
        error "未输入游戏端口${GATEWAY_PORT}" 1
    fi
    if [ ! -z ${LOGIN_PORT} ]; then
        if (lsof -i:${LOGIN_PORT} > /dev/null 2>&1); then
            error "登陆系统端口${LOGIN_PORT}被占用" 1
        fi
    else
        error "未输入登陆系统端口${LOGIN_PORT}" 1
    fi
    if [ ! -z ${ADMIN_PORT} ]; then
        if (lsof -i:${ADMIN_PORT} > /dev/null 2>&1); then
            error "后台端口${ADMIN_PORT}被占用" 1
        fi
    else
        error "未输入后台端口${ADMIN_PORT}" 1
    fi
    if [ ! -z ${POLL_PORT} ]; then
        if (lsof -i:${POLL_PORT} > /dev/null 2>&1); then
            error "中央端口${POLL_PORT}被占用" 1
        fi
    else
        error "未输入中央端口${POLL_PORT}" 1
    fi
    if [ ! -z ${TCP_CLUSTER_PORT} ]; then
        if (lsof -i:${TCP_CLUSTER_PORT} > /dev/null 2>&1); then
            error "集群端口${TCP_CLUSTER_PORT}被占用" 1
        fi
    else
        error "未输入集群端口${TCP_CLUSTER_PORT}" 1
    fi
    if [ -z ${WEB_PORT} ]; then
        error "未输入管理后台端口${WEB_PORT}" 1
    fi
    if [ -z ${WEB_IP} ]; then
        error "未输入管理后台IP地址${WEB_IP}" 1
    else
        check_ip ${WEB_IP}
    fi
    if [ -z ${OUTER_IP} ]; then
        error "未输入本机外网IP地址${OUTER_IP}" 1
    else
        check_ip ${OUTER_IP}
    fi
    if [ -z ${BACKUP_IP} ]; then
        error "未输入远程备份IP地址${BACKUP_IP}" 1
    else
        check_ip ${BACKUP_IP}
    fi
    if [ -f ${NGINX_PATH}/${SERVER_NGINX_FILE} ]; then
        error "nginx配置${NGINX_PATH}/${SERVER_NGINX_FILE}已存在" 1
    fi
    if [ -f ${NGINX_PATH}/https/${SERVER_NGINX_FILE} ]; then
        error "nginx配置${NGINX_PATH}/https/${SERVER_NGINX_FILE}已存在" 1
    fi
    if [ ! -z ${PHP_PORT} ]; then
        if (lsof -i:${PHP_PORT} > /dev/null 2>&1); then
            error "php nginx端口${PHP_PORT}被占用" 1
        fi
    else
        error "未输入php nginx端口${PHP_PORT}" 1
    fi
    if [ -f ${CROND_PATH}/${GAME_NAME}_s${SERVER_ID} ]; then
        error "php计划任务配置${CROND_PATH}/${GAME_NAME}_s${SERVER_ID}已存在" 1
    fi
    if [ -f ${NGINX_PATH}/${PHP_NGINX_FILE} ]; then
        error "php nginx配置${NGINX_PATH}/${PHP_NGINX_FILE}已存在" 1
    fi
}

# 显示确认参数是否正确操作
confirm_operation() {
    echo "请检查以下参数是否正确"
    echo " 游戏服ID：${SERVER_ID}"
    echo " svn地址:${SVN_SERVER}"
    echo " 线上svn中server的版本号：${VERSION}"
    echo " 游戏名：${GAME_NAME}"
    echo " 配置里面的平台：${PLATFORM}"
    echo " 域名：${DOMAIN_NAME}"
    echo " SSL KEY文件：${SSL_KEY}"
    echo " SSL PEM文件：${SSL_PEM}"
    echo " 游戏端口：${GATEWAY_PORT}"
    echo " 登陆系统端口：${LOGIN_PORT}"
    echo " 后台端口：${ADMIN_PORT}"
    echo " 中央端口：${POLL_PORT}"
    echo " 集群端口：${TCP_CLUSTER_PORT}"
    echo " php nginx端口:${PHP_PORT}"
    echo " 后台IP：${WEB_IP}"
    echo " 后台端口：${WEB_PORT}"
    echo " 本机外网ip：${OUTER_IP}"
    echo " 游戏类型：${SERVER_TYPE}"
    show_verify
}

# 开始搭服
create_server() {
    GAME_PATH=${SERVER_PATH}/${GAME_NAME}_s${SERVER_ID}
    OPEN_TIME=`date "+{{%Y,%m,%d},{%H,0,0}}"`
    #创建目录
    if [ -d ${GAME_PATH} ]; then
        error "游戏服${GAME_NAME}_s${SERVER_ID}已存在" 1
    else
        echo "开始创建游戏目录${GAME_PATH}"
        mkdir -p ${GAME_PATH}
    fi
    # checkout服务端
    echo "开始下载server代码"
    if !(svn co svn://${SVN_SERVER}/tags/online/${VERSION}/game ${GAME_PATH} --username ${SVN_USER} --password ${SVN_PASSWORD} > /dev/null 2>&1); then
        error "server svn checkout出错" 1
    fi
    echo "server代码下载完成"
    # 修改配置文件
    echo "开始修改配置文件"
    COMMON_CONF=${GAME_PATH}/config/common.conf
    GAME_CONF=${GAME_PATH}/config/game.conf
    sed -i 's/{center_node, .*/{center_node, '\'center_${GAME_NAME}_${SERVER_ID}_1@${INNER_IP}\''}./'g ${COMMON_CONF}
    sed -i 's/{inside_clusters, .*/{inside_clusters, [{1, ['\'inside_${GAME_NAME}_${SERVER_ID}_1@${INNER_IP}\'']}]}./'g ${COMMON_CONF}
    sed -i 's/{outside_clusters, .*/{outside_clusters, [{1, ['\'outside_${GAME_NAME}_${SERVER_ID}_1@${INNER_IP}\'']}]}./'g ${COMMON_CONF}
    sed -i 's/{db_center, .*/{db_center, {"localhost", 3306, "'${DB_USER}'", "'${DB_PASS}'"}}./'g ${COMMON_CONF}
    sed -i 's/{db_center_clusters, .*/{db_center_clusters, [{1,{"localhost", 3306, "'${DB_USER}'", "'${DB_PASS}'"}}]}./'g ${COMMON_CONF}
    sed -i 's/{db_game, .*/{db_game, {"localhost", 3306, "'${DB_USER}'", "'${DB_PASS}'"}}./'g ${COMMON_CONF}
    sed -i 's/{db_game_cluster_id,.*/{db_game_cluster_id, '${SERVER_ID}'}./'g ${COMMON_CONF}
    sed -i 's/{db_game_clusters,.*/{db_game_clusters, [{'${SERVER_ID}',{"localhost", 3306, "'${DB_USER}'", "'${DB_PASS}'"}}]}./'g ${COMMON_CONF}
    sed -i 's/{mnesia_masters,.*/{mnesia_masters, ['\'db_mnesia_${GAME_NAME}_${SERVER_ID}_1@${INNER_IP}\'']}./'g ${COMMON_CONF}
    sed -i 's/{game_name, .*/{game_name, "'${GAME_NAME}'"}./'g ${COMMON_CONF}
    sed -i 's/{platform, .*/{platform, "'${PLATFORM}'"}./'g ${COMMON_CONF}
    sed -i 's/{server_id, .*/{server_id, '${SERVER_ID}'}./'g ${COMMON_CONF}
    sed -i 's/{server_only_id, .*/{server_only_id, '${SERVER_ID}'}./'g ${COMMON_CONF}
    sed -i 's/{open_time, .*/{open_time, '${OPEN_TIME}'}./'g ${COMMON_CONF}
    sed -i 's/{net_intranet, .*/{net_intranet, false}./'g ${COMMON_CONF}
    sed -i 's/{close_test, .*/{close_test, false}./'g ${COMMON_CONF}
    sed -i 's/{is_https, .*/{is_https, '${IS_HTTPS}'}./'g ${COMMON_CONF}
    sed -i 's/{is_merge, .*/{is_merge, false}./'g ${COMMON_CONF}
    sed -i 's/{merge_list, .*/{merge_list, []}./'g ${COMMON_CONF}
    sed -i 's/{is_restart, .*/{is_restart, true}./'g ${COMMON_CONF}
    sed -i 's/{gateway_port, .*/{gateway_port, '${GATEWAY_PORT}'}./'g ${COMMON_CONF}
    sed -i 's/{login_port, .*/{login_port, '${LOGIN_PORT}'}./'g ${COMMON_CONF}
    sed -i 's/{admin_port, .*/{admin_port, '${ADMIN_PORT}'}./'g ${COMMON_CONF}
    sed -i 's/{poll_port, .*/{poll_port, '${POLL_PORT}'}./'g ${COMMON_CONF}
    sed -i 's/{tcp_cluster_port, .*/{tcp_cluster_port, '${TCP_CLUSTER_PORT}'}./'g ${COMMON_CONF}
    sed -i 's/{web_loop_https, .*/{web_loop_https, [{"'${WEB_IP}'", '${WEB_PORT}'}]}./'g ${COMMON_CONF}
    sed -i 's/{web_allow_ip, .*/{web_allow_ip, ["127.0.0.1", "'${WEB_IP}'"]}./'g ${COMMON_CONF}
    sed -i 's/{server_type, .*/{server_type, '${SERVER_TYPE}'}./'g ${COMMON_CONF}
    sed -i 's/{log_level, .*/{log_level, 2}./'g ${COMMON_CONF}

    sed -i 's/{game_ip, .*/{game_ip, "'${INNER_IP}'"}./'g ${GAME_CONF}
    sed -i 's/{extranet_ip, .*/{extranet_ip, "'${OUTER_IP}'"}./'g ${GAME_CONF}
    echo "修改配置文件完成,请检查配置文件${COMMON_CONF}跟${GAME_CONF}里面的参数是否正确"
    # 初始化数据库
    echo "初始化数据库"
    if ! (sh ${GAME_PATH}/script/init_db.sh > /dev/null 2>&1); then
        echo "初始化服${SERVER_ID}数据库失败,请手动操作！！！"
    fi
    echo "初始化数据库完成"
    # 初始化计划任务
    echo "开始初始化server计划任务"
    if ! (sh ${GAME_PATH}/script/server_init.sh -s ${BACKUP_IP}); then
        echo "初始化服${SERVER_ID}计划任务失败,远程备份IP地址${BACKUP_IP}，请手动操作！！！"
    fi
    echo "初始化server计划任务完成"
    # nginx配置(只有开启https才需要)
    if [ "${IS_HTTPS}" = "true" ]; then
        echo "开始配置server nginx"
        # 创建https目录
        if [ ! -d ${NGINX_PATH}/https ]; then
            mkdir -p ${NGINX_PATH}/https
        fi
        ADD_PORT_NUM=$(common_conf_value ${COMMON_CONF} https_interval)
        NEW_POLL_PORT=`expr ${POLL_PORT} + ${ADD_PORT_NUM}`
        NEW_LOGIN_PORT=`expr ${LOGIN_PORT} + ${ADD_PORT_NUM}`
        NEW_GATEWAY_PORT=`expr ${GATEWAY_PORT} + ${ADD_PORT_NUM}`

        cat > ${NGINX_PATH}/https/${SERVER_NGINX_FILE} << EOF
#线上${SERVER_ID}服登陆
location ^~ /${GAME_NAME}_center_s${SERVER_ID}_p${NEW_POLL_PORT}/ {
if (\$request_uri ~ /${GAME_NAME}_center_s${SERVER_ID}_p${NEW_POLL_PORT}/(.*)) {
       set \$${GAME_NAME}_center_s${SERVER_ID}_p${NEW_POLL_PORT} \$1;
   }
   proxy_pass http://${INNER_IP}:${POLL_PORT}/\$${GAME_NAME}_center_s${SERVER_ID}_p${NEW_POLL_PORT};
}

#线上${SERVER_ID}服websocket
location ^~ /${GAME_NAME}_s${SERVER_ID}_p${NEW_LOGIN_PORT}/ {
if (\$request_uri ~ /${GAME_NAME}_s${SERVER_ID}_p${NEW_LOGIN_PORT}/(.*)) {
        set \$${GAME_NAME}_s${SERVER_ID}_p${NEW_LOGIN_PORT} \$1;
   }
   proxy_pass http://${INNER_IP}:${LOGIN_PORT}/\$${GAME_NAME}_s${SERVER_ID}_p${NEW_LOGIN_PORT};
}
EOF
    if [ "${IS_HIGH_DEFENSE}" = "true" ]; then
         cat > ${NGINX_PATH}/${SERVER_NGINX_FILE} << EOF
server {
    listen ${NEW_GATEWAY_PORT};
    server_name   ${DOMAIN_NAME};
    root html;
    index index.html index.htm;

    location / {
        proxy_pass http://${INNER_IP}:${GATEWAY_PORT};
    }
}
EOF
    else
     cat > ${NGINX_PATH}/${SERVER_NGINX_FILE} << EOF
server {
    listen ${NEW_GATEWAY_PORT};
    server_name   ${DOMAIN_NAME};
    ssl on;
    root html;
    index index.html index.htm;
    ssl_certificate   /data/ssl/${SSL_PEM};
    ssl_certificate_key  /data/ssl/${SSL_KEY};
    ssl_session_timeout 5m;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;

    location / {
        proxy_pass http://${INNER_IP}:${GATEWAY_PORT};
    }
}
EOF
    fi
        # 权限
        chmod -R 644 ${NGINX_PATH}/https/${SERVER_NGINX_FILE}
        chmod -R 644 ${NGINX_PATH}/${SERVER_NGINX_FILE}
        echo "配置server nginx完成"
    fi
    # 权限
    chmod -R 777 ${GAME_PATH}
     # 开服
    if [ "${IS_OPEN}" = "true" ]; then
        echo "准备开服"
        export PATH=$PATH:/usr/local/erlang/bin
        cd ${GAME_PATH}
        # 先进入目录,才能启服
        sh gamectl start_all
        echo "${SERVER_ID}服开服完成"
    fi
}

# 开始搭建php后台单服
create_php() {
    PHP_PATH=${PHP_PATH}/${GAME_NAME}/s${SERVER_ID}
    DB=${GAME_NAME}_admin_s${SERVER_ID}
    #创建目录
    if [ -d ${PHP_PATH} ]; then
        error "php目录${PHP_PATH}已存在" 1
    else
        echo "开始创建php目录${PHP_PATH}"
        mkdir -p ${PHP_PATH}
    fi
    # checkout php
    echo "开始下载php代码"
    if !(svn co svn://${SVN_SERVER}/php/Single ${PHP_PATH}/web --username ${SVN_USER} --password ${SVN_PASSWORD} > /dev/null 2>&1); then
        error "php svn checkout出错" 1
    fi
    echo "下载php代码完成"
    # 修改配置
    echo "开始修改php配置"
    PHP_CONF=${PHP_PATH}/web/App/Libs/Common/Conf/dbConfig.php
    sed -i 's/$pass = empty.*/$pass = empty($pass) ? "'${DB_PASS}'" : trim($pass);/'g ${PHP_CONF}
    echo "修改php配置完成"
    # 初始化数据库
    echo "开始初始化php数据库"
    if [ -f ${PHP_PATH}/web/sql/${PHP_SQL_FILE} ]; then
        if ! (mysql -u ${DB_USER} -p${DB_PASS} -e "create DATABASE IF NOT EXISTS ${DB}"); then
            error "创建php数据库${DB}失败" 1
        fi
        if ! (mysql -u ${DB_USER} -p${DB_PASS} ${DB} < ${PHP_PATH}/web/sql/${PHP_SQL_FILE}); then
            error "导入php数据库${DB}失败" 1
        fi
    else
        error "${PHP_PATH}/web/sql/${PHP_SQL_FILE}文件不存在，请手动创建php数据库${DB}" 1
    fi
    echo "初始化php数据库完成"
    # 计划任务
    echo "开始配置php计划任务"
    PHP_CROND_FILE=${GAME_NAME}_s${SERVER_ID}
    cat > ${CROND_PATH}/${PHP_CROND_FILE} << EOF
###发送系统邮件计划任务[每3分钟启动一次]###
*/3 * * * * root cd ${PHP_PATH}/web;/usr/local/php-5.4.45/bin/php index.php Content/SingleTask/SysMail ${GAME_NAME} Single

###统计用户在线情况[每1小时启动一次]###
01 * * * * root cd ${PHP_PATH}/web;/usr/local/php-5.4.45/bin/php index.php Content/SingleTask/PlayerOnline ${GAME_NAME} Single

###统计用户留存[每3小时07分启动一次]###
02 */3 * * * root cd ${PHP_PATH}/web;/usr/local/php-5.4.45/bin/php index.php Content/SingleTask/PlayerLeft ${GAME_NAME} Single

###统计玩家每5分钟在线情况[每5分钟启动一次]###
*/5 * * * * root cd ${PHP_PATH}/web;/usr/local/php-5.4.45/bin/php index.php Content/SingleTask/DayOnline ${GAME_NAME} Single
EOF
    echo "php计划任务配置完成"
    # nginx配置
    echo "开始配置php nginx"
    cat > ${NGINX_PATH}/${PHP_NGINX_FILE} << EOF
server {
    listen  ${PHP_PORT};

    server_name  ${OUTER_IP};
    root ${PHP_PATH}/web;
    index  index.html index.htm single.php;

    error_page  404              /404.html;
    location = /404.html {
        return 404 'Sorry, File not Found!';
    }
    error_page  500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html; # windows用户替换这个目录
    }
    location / {
        try_files \$uri @rewrite;
    }

    location @rewrite {
        set \$static 0;
        if  (\$uri ~ \.(css|js|jpg|jpeg|png|gif|ico|woff|eot|svg|css\.map|min\.map)$) {
            set \$static 1;
        }

        if (\$static = 0) {
            rewrite ^/(.*)$ /single.php?s=/\$1 last;
            break;
        }

    }

    location ~ /Uploads/.*\.php$ {
        deny all;
    }
    location ~ \.php/ {
       if (\$request_uri ~ ^(.+\.php)(/.+?)($|\?)) { }
       fastcgi_pass 127.0.0.1:9000;
       fastcgi_index index.php;
       include fastcgi.conf;

       fastcgi_param SCRIPT_NAME     \$1;
       fastcgi_param PATH_INFO       \$2;
       fastcgi_param SCRIPT_FILENAME \$document_root\$1;
    }
    location ~ \.php$ {
        #fastcgi_pass 127.0.0.1:9001;
        fastcgi_pass 127.0.0.1:9000;
        #fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_buffer_size 128k;
        fastcgi_buffers 8 128k;
        include fastcgi.conf;
    }
    location ~ /\. {
        deny  all;
    }

}
EOF
    echo "php nginx配置完成"
    # 权限设置
    chmod -R 777 ${PHP_PATH}
    chmod -R 644 ${NGINX_PATH}/${PHP_NGINX_FILE}
    chmod -R 644 ${CROND_PATH}/${PHP_CROND_FILE}
}

# 1
check_args

# 2
confirm_operation

# 3
show_line
echo "开始搭建服${SERVER_ID}"
create_server
echo "服${SERVER_ID}搭建完成"

# 4
echo "开始搭建php后台"
#create_php
echo "php后台搭建完成"

# 5
echo "重新加载nginx"
sh /root/nginx_reload
echo "nginx 加载完成"

show_line
