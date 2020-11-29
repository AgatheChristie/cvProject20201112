#! /bin/bash
#import file
. ./cvCVI.sh




# 获取ip
# 获取第一行网卡对应ip
get_ip() {
    IP=`LANG=en_US; ifconfig | grep 'inet addr:' | head -n 1 | cut -d: -f 2 | awk '{print $1}'`
    echo ${IP}

#    GAME_IP=$(game_conf_value game_ip)
#    GAME_IP=${GAME_IP#\"}
#    GAME_IP=${GAME_IP%\"}
#    echo ${GAME_IP}
}



a=10
a=20


echo "-----------------1111111---------------------"
get_ip
warn "获取内网ip失败!"
echo "-----------------22222222---------------------"
# 参数义
[ -z "$HOST" ] && HOST=ddd

echo ${HOST} ${a}
