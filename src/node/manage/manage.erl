%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.06.14
%%% 游戏启动模块
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(manage).
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
		ok = util_app:start_apps(?MANAGE_START_APPS)
	catch
		Type:Error ->
			?ERROR("Start the game node error:~w:~p", [Type, Error]),
			init:stop(?STATUS_ERROR)
	end.

%% application调用的启动游戏
start(_Type, _StartArgs) ->
%%	net_adm:ping('cvnice@192.168.20.89'),

	%% 启动自带的apps
	ok = util_app:start_self_apps(),
	%% 启动game_sup
	{ok, Sup} = manage_sup:start_link(),


	?ERROR("Start the game node ~p success", [node()]),
	{ok, Sup}.

%% 单独停止游戏
only_stop() ->
	manage_util:do_stop_server(),
	ok.

%% 停止游戏
stop() ->
	manage_util:do_stop_server(),

	ok.

%% 停止游戏
stop(_State) ->
	ok.
