%% coding: latin-1

-module(util_db_game).

-include("common.hrl").

-compile(export_all).

%% 初始化
init_db_mysql() ->
    GameConnectCount = util_config:db_game_pool_connect(),
    [ServerIp, Port, User, Pass, _DB, _Encode, GamePoolCount] = config:get_mysql_config(?GET_MYSQL_APP),
    GamePoolIds = calc_game_pool_ids(GamePoolCount),
    util_db_game:start_mysql(GamePoolIds, ServerIp, Port, User, Pass,GameConnectCount).

%% 计算game的poll列表
calc_game_pool_ids(PoolCount) ->
    MinId = 1,
    case PoolCount > 0 of
        true ->
            lists:seq(MinId, PoolCount);
        false ->
            [MinId]
    end.

%% 用来启动mysql的start_mysql
start_mysql([], _ServerIp, _Port, _User, _Pass, _ConnectCount) ->
    next;
start_mysql([PoolId|TPoolIds], ServerIp, Port, User, Pass, ConnectCount) ->
    %% 启动插件的mysql进程
    {ok, _Pid} = util_db_game:start_mysql2(PoolId, ServerIp, Port, User, Pass, ConnectCount),
    %% 启动辅助的mysql进程
    {ok, _DbMysqlPid} = util_db_mysql_serv:start_db_mysql(PoolId),
    start_mysql(TPoolIds, ServerIp, Port, User, Pass, ConnectCount).

start_mysql2(PoolId, ServerIp, Port, User, Pass, ConnectCount) ->
    [_ServerIp, _Port, _User, _Pass, GameDbName, Encode, _PoolCount] = config:get_mysql_config(?GET_MYSQL_APP),
    case mysql:start_link(PoolId, ServerIp, Port, User, Pass, GameDbName, fun log/4, Encode) of
        {ok, Pid} ->
            add_mysql_connect(ConnectCount, PoolId, ServerIp, Port, User, Pass, GameDbName, true),
            ?ERROR("Ip:~p,port:~w mysql powol:~w succeful", [ServerIp, Port, PoolId]),
            {ok, Pid};
        {error, {already_started, Pid}} ->
            ?ERROR("Ip:~p,port:~w mysql pool:~w already_started", [ServerIp, Port, PoolId]),
            {ok, Pid};
        {error, _Reason} ->
            ?ERROR("Ip:~p,port:~w mysql pool:~w error :~p", [ServerIp, Port, PoolId, _Reason]),
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

%% 获取连接池id
assign_pool_id(HashId) ->
    Hash = erlang:phash2(HashId, ?ASSHIG_MAX_HASH),
    calc_pool_id(Hash).

%% 最大连接池id
max_pool_id() ->
    util_config:db_game_pool().

%% 计算使用连接池,池大于1的时候,最大的池-1,最大的池用于其他使用
calc_pool_id(Id) ->
    PoolId = util_db_game:max_pool_id(),
    case PoolId > 1 of
        true ->
            PoolId2 = PoolId - 1,
            RemId = Id rem PoolId2,
            case RemId > 0 of
                true ->
                    RemId;
                false ->
                    PoolId2
            end;
        false ->
            PoolId
    end.
