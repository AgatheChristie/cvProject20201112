%% coding: latin-1

-module(util_db_game).

-include("common.hrl").

-export([
    init_db_mysql/0
    , start_mysql/5
    , start_mysql2/5
    , add_mysql_connect/8
    , log/4
]).

%% 初始化
init_db_mysql() ->
    DDD = application:loaded_applications(),
    ?ERROR("ddw Sup:~p end", [DDD]),
    [ServerIp, Port, User, Pass, _DB, _Encode, PoolCount] = config:get_mysql_config(?CVSERVER),
    util_db_game:start_mysql(PoolCount, ServerIp, Port, User, Pass).


%% 用来启动mysql的start_mysql
start_mysql(0, _ServerIp, _Port, _User, _Pass) ->
    next;
start_mysql(PoolId, ServerIp, Port, User, Pass) ->
    %% 启动插件的mysql进程
    {ok, _Pid} = util_db_game:start_mysql2(PoolId, ServerIp, Port, User, Pass),

    NewPoolId = PoolId - 1,
    start_mysql(NewPoolId, ServerIp, Port, User, Pass).

start_mysql2(PoolId, ServerIp, Port, User, Pass) ->
    [_ServerIp, _Port, _User, _Pass, GameDbName, Encode, _PoolCount] = config:get_mysql_config(?CVSERVER),
    ?ERROR("~p:~p:~p:~p: ~p:~p: ", [GameDbName, PoolId, ServerIp, Port, User, Pass]),
    case mysql:start_link(PoolId, ServerIp, Port, User, Pass, GameDbName, fun log/4, Encode) of
        {ok, Pid} ->
            ConnectCount = 1,
            add_mysql_connect(ConnectCount, PoolId, ServerIp, Port, User, Pass, GameDbName, true),
            ?ERROR("Ip:~p,port:~w mysql powol:~w succeful", [ServerIp, Port, PoolId]),
            {ok, Pid};
        {error, {already_started, Pid}} ->
            ?ERROR("Ip:~p,port:~w mysql pool:~w yijinqidong", [ServerIp, Port, PoolId]),
            {ok, Pid};
        {error, _Reason} ->
            ?ERROR("Ip:~p,port:~w mysql pool:~w fail :~p", [ServerIp, Port, PoolId, _Reason]),
            {error, _Reason}
    end.

%% 增加mysql连接
add_mysql_connect(0, _PoolId, _ServerIp, _Port, _User, _Pass, _GameDbName, _IsLink) ->
    next;
add_mysql_connect(ConnectCount, PoolId, ServerIp, Port, User, Pass, GameDbName, IsLink) ->
    mysql:connect(PoolId, ServerIp, Port, User, Pass, GameDbName, true, IsLink),
    NewConnectCount = ConnectCount - 1,
    add_mysql_connect(NewConnectCount, PoolId, ServerIp, Port, User, Pass, GameDbName, IsLink).

%% 定义mysql使用的log fun
log(_Module, _Line, debug, _FormatFun) ->
    next;
log(Module, Line, _Level, FormatFun) ->
    {Format, Arguments} = FormatFun(),
    ?ERROR("~w:~w: " ++ Format ++ "~n", [Module, Line] ++ Arguments),
    ok.