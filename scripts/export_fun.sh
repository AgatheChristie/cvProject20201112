#! /bin/bash

ROOT=`cd $(dirname $0)/..; pwd`
SRC_DRI=${ROOT}/src
GAME_LOG=${ROOT}/log
EXPORT_LOG=${GAME_LOG}/export_log.log
ALL_FILE=false

# 用法
usage () {
    echo "erlang文件导出函数"
    echo "用法:"
    echo "-a 所有的文件都导出"
    echo "-f 指定的文件导出"
    echo "例如: sh ${0} -f 'util_test util_cheat'"
}

# 处理单个文件
deal_erl_file() {
    DEAL_FILE=$1
    sed -i 's/%%-compile(export_all)./-compile(export_all)./' ${DEAL_FILE}
    EXPORT_NUM=`cat ${DEAL_FILE} |grep "^-export"|wc -l`
    ## echo "文件${DEAL_FILE}导出值:${EXPORT_NUM}"
    ## 没有导出函数的文件
    if [ ${EXPORT_NUM} -le 0 ];then
       sed -i 's/-compile(export_all)./%%-compile(export_all)./' ${DEAL_FILE}
       if [ -d "${EXPORT_LOG}" ]; then
          rm -rf ${EXPORT_LOG}
       fi
       sh ${ROOT}/cl -l ${DEAL_FILE} >> ${EXPORT_LOG}
       FUN_ARRAY=(`cat ${EXPORT_LOG}|sed 's/ is unused//'|grep ": function "|awk -F ": function " '{print $2}'`)
       FUN_LEN=${#FUN_ARRAY[*]}

       EXPORT_STR=
       if [ ${FUN_LEN} -gt 0 ];then
          if [ ${FUN_LEN} -le 1 ];then
             EXPORT_STR="-export([\n    ${FUN_ARRAY[*]}"
             echo ""
          else
             INDEX=1
             EXPORT_STR="-export(["
             for EXPORT_FUN in ${FUN_ARRAY[@]}; do
                 if [ ${INDEX} -le 1 ];then
                    EXPORT_STR="${EXPORT_STR}\n    ${EXPORT_FUN}"
                 else
                    EXPORT_STR="${EXPORT_STR}\n    , ${EXPORT_FUN}"
                 fi
                 let INDEX++
             done
          fi
          EXPORT_STR="${EXPORT_STR}\n])."
          sed -i "s#%%-compile(export_all).#${EXPORT_STR}#" ${DEAL_FILE}
       fi
       rm -rf ${EXPORT_LOG}
       echo "处理文件${DEAL_FILE}成功"
    fi
}

# 处理参数
if [ "$#" -eq 0 ]; then
    usage
    exit 0
fi

# 解析参数
while [ $# -ne 0 ] ; do
    PARAM=$1
    shift
    case $PARAM in
        -a) ALL_FILE=true; shift;;
        -f) ASSIGN_FILES=$1; shift ;;
        --help|-h) usage; exit 0;;
        *) usage; exit 0;;
    esac
done

# 显示确认信息
if [ "${ALL_FILE}" = false ]; then
   if [ "${ASSIGN_FILES}" == '' ]; then
      usage
      exit 0
   fi
   ERL_ARRAY=()
   A_INDEX=0
   for ASSIGN_FILE in ${ASSIGN_FILES}; do
       ERL_ARRAY[A_INDEX]=`find ${SRC_DRI} -name "${ASSIGN_FILE}.erl"`
       let A_INDEX++
   done
else
    ERL_ARRAY=(`find ${SRC_DRI} -name "*.erl"`)
fi

mkdir -p ${GAME_LOG}
for ERL_FILE in ${ERL_ARRAY[@]}; do
    deal_erl_file ${ERL_FILE}
done