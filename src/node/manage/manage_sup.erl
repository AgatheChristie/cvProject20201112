%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.07.19
%%% 游戏监督树
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(manage_sup).

-include("common.hrl").
-include("app.hrl").
-include("node.hrl").

-behaviour(supervisor).

-export([
	init/1,
	start_link/0
]).

%% 启动监督树
start_link() ->
	{ok, Sup} = supervisor:start_link({local, ?MODULE}, ?MODULE, []),


	%% mnesia数据库管理进程
	ok = util_game:start_child(Sup, {serv_mnesia_mgr, {serv_mnesia_mgr, start_link, [?MANAGE_TYPE, ?MANAGE_APP]},
		permanent, 30000, worker, [serv_mnesia_mgr]}),

	%% ets管理
%%	ok = util_game:start_child(Sup, {serv_ets_mgr, {serv_ets_mgr, start_link, [?MANAGE_TYPE]},
%%		permanent, 30000, worker, [serv_ets_mgr]}),


	ok = util_manage_sup:start_manage_sup(Sup),

	?ERROR("Game Server Sup = ~w", [Sup]),
	{ok, Sup}.

%% sup 初始化
init([]) ->
	{ok, {{one_for_one, 10, 10}, []}}.


