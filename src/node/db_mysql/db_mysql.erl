%% coding: latin-1

-module(db_mysql).
-behaviour(application).

-include("common.hrl").
-include("app.hrl").


-export([
    start/0
    , start/2
    , only_stop/0
    , stop/0
    , stop/1
]).

%% 外部调用,启动节点
start() ->
    try
        ok = util_app:start_apps(?DB_MYSQL_START_APPS)
    catch
        Type:Error ->
            ?ERROR("qidong mysql node error:~w:~p", [Type, Error]),
            init:stop(?STATUS_ERROR)
    end.

%% application调用的启动游戏
start(_Type, _StartArgs) ->

    ok = util_app:start_self_apps(),

    {ok, Sup} = db_mysql_sup:start_link(),

    ?ERROR("qidong mysql:~p succ", [node()]),
    {ok, Sup}.

%% 单独停止游戏
only_stop() ->
    db_mysql_util:do_stop_server(),
    ok.

%% 停止游戏
stop() ->
    db_mysql_util:do_stop_server(),

    ok.

%% 停止游戏
stop(_State) ->
    ok.


