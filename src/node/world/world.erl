%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.06.14
%%% 世界服启动模块
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(world).
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
        ok = util_app:start_apps(?WORLD_START_APPS)
    catch
        Type:Error ->
            ?ERROR("start world manage node err:~w:~p", [Type, Error]),
            init:stop(?STATUS_ERROR)
    end.

%% application调用的启动游戏
start(_Type, _StartArgs) ->
    %% 启动自带的apps
    ok = util_app:start_self_apps(),
    %% 启动world_sup
    {ok, Sup} = world_sup:start_link(),
    ?INFO("start world manage node suff:~p good", [node()]),
    {ok, Sup}.

%% 单独停止游戏
only_stop() ->
    world_util:do_stop_server(),
    ok.

%% 停止游戏
stop() ->
    world_util:do_stop_server(),
    ok.

%% 停止游戏
stop(_State) ->
    ok.
