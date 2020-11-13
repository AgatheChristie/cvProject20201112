%% coding: latin-1

-ifndef(COMMON_HRL).
-define(COMMON_HRL, true).


-include_lib("stdlib/include/ms_transform.hrl").

%% 代码路径
-define(CODE_PATH, "ebin").
%% 定义cv打印
-define(CVI(F), io:format("##[~w~w:~w] " ++ F ++ "~n", [self(), ?MODULE, ?LINE])).
-define(CVI(F, A), io:format("##[~w~w:~w] " ++ F ++ "~n", [self(), ?MODULE, ?LINE | A])).
%% 定义boolean
-define(TRUE, true).
-define(FALSE, false).

%% 定义record默认值
-define(NONE, none).

-define(MODULE_LINE, {?MODULE, ?LINE}).

%% 错误码
-define(C2SERR(R), throw({error, R})).
-define(IS_C2SERR(R), {error, R}).

%% 封装处理handle_cast
-define(HANDLE_CAST(Req, State),
    try
        do_cast(Req, State)
    catch
        Class:Error ->

            {noreply, State}
    end).

%% 封装处理handle_call
-define(HANDLE_CALL(Req, State), ?HANDLE_CALL(Req, From, State)).
-define(HANDLE_CALL(Req, From, State),
    try
        do_call(Req, From, State)
    catch
        _Class:_Error ->

            {noreply, State}
    end).
%% 封装处理handle_info
-define(HANDLE_INFO(Req, State),
    try
        do_info(Req, State)
    catch
        _Class:_Error ->

            {noreply, State}
    end).

%% 封装处理try ... catch
-define(TRY_CATCH(Fun),
    try
        (Fun)
    catch
        _Class:_Error ->

            ok
    end).

%% 封装处理玩家函数
%%-define(ROLE_FUN_CATCH(Fun, Role), util_game:handle_role_return(catch Fun, Role)).

%% 配置
%%-define(CONFIG(K), util_config:get(K)).
%%-define(CONFIG(K, D), util_config:get(K, D)).

%% 日志等级 critical | error | warn | info | debug | verbose
-define(LOG_LEVEL_CRITICAL, 1).
-define(LOG_LEVEL_ERROR, 2).
-define(LOG_LEVEL_WARN, 3).
-define(LOG_LEVEL_INFO, 4).
-define(LOG_LEVEL_DEBUG, 5).
-define(LOG_LEVEL_VERBOSE, 6).

%% 回调信息进程字典宏
-define(S2S_CONVERT_TIMER, s2s_convert_timer).
-define(S2S_CONVERT_FUN, s2s_convert_fun).

%% 重登陆
-define(RELOGIN_KEY, relogin_key).

%% 数据库进程池id
-define(MYSQL_POOL_ID, mysql_pool_id).

%% 服务器版本标志
-define(DEBUG_VERSION, 1).
-define(NORMAL_VERSION, 2).

%% 同步调用函数超时
-define(CALL_TIMEOUT, 10000).
%% 异步回调函数超时
-define(CAST_TIMEOUT, 10000).

%% 百分比值
-define(ONE_HUNDRED, 100).
%% 万分比值
-define(TEN_THOUSAND, 10000).

%% 随机数一半
-define(PROB_HALF, 5000).
%% 随机数最大值
-define(PROB_FULL, 10000).
%% hash值的最大范围
-define(ASSHIG_MAX_HASH, 1000000).

%% 节点是否联通
-define(NODE_NOT_PONG, 0).                                                %% 没有连通
-define(NODE_IS_PONG, 1).                                                 %% 已经连通

%% http的标识
-define(HTTP_FLAG, 0).
-define(HTTPS_FLAG, 1).

%% 是否请求了信息
-define(NOT_REQ, 0).                                                      %% 未请求
-define(IS_REQ, 1).                                                       %% 已经请求

%% 服务器类型
-define(GAME_SERVER, 0).                                                  %% 游戏服
-define(CROSS_SERVER, 1).                                                 %% 跨服

%% 一分钟
-define(ONE_MIN, 60).
%% 五分钟
-define(FIVE_MIN, 300).
%% 1小时
-define(ONE_HOUR, 3600).
%% 1天
-define(ONE_DAY, 86400).
%% 1周
-define(WEEK_DAY, 604800).

%% 每日特殊时间
-define(SPECIAL_HOUR, 18000).

-endif.

