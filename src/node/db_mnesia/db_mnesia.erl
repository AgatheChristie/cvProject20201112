%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.06.14
%%% 日志服启动模块
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(db_mnesia).
-behaviour(application).

-include("common.hrl").
-include("app.hrl").
-include("node.hrl").

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
        ok = util_app:start_apps(?DB_MNESIA_START_APPS)
    catch
        Type:Error ->
            ?ERROR("qidong mnesia cache node error:~w:~p", [Type, Error]),
            init:stop(?STATUS_ERROR)
    end.

%% application调用的启动游戏
start(_Type, _StartArgs) ->
    %% 编译配置文件

    %% 启动自带的apps
    ok = util_app:start_self_apps(),
    %% 启动db_mnesia_sup
    {ok, Sup} = db_mnesia_sup:start_link(),
    %% 重载开服时间


    ?ERROR("qidong mnesia cache node ~p succeful", [node()]),
    {ok, Sup}.

%% 单独停止游戏
only_stop() ->
    db_mnesia_util:do_stop_server(),
    ok.

%% 停止游戏
stop() ->
    db_mnesia_util:do_stop_server(),

    ok.

%% 停止游戏
stop(_State) ->
    ok.
