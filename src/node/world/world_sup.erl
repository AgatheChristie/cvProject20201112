%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.07.19
%%% 世界管理监督树
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(world_sup).

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

    %% 游戏数据库管监控树
    ok = util_game:start_child(Sup, {serv_db_mysql_sup, {serv_db_mysql_sup, start_link, []},
        permanent, infinity, supervisor, []}),

    %% 游戏数据库管理进程
    ok = util_game:start_child(Sup, {serv_db_mysql_mgr, {serv_db_mysql_mgr, start_link, []},
        permanent, 30000, worker, [serv_db_mysql_mgr]}),

    %% mnesia数据库管理进程
    ok = util_game:start_child(Sup, {serv_mnesia_mgr, {serv_mnesia_mgr, start_link, [?WORLD_TYPE, ?WORLD_APP]},
        permanent, 30000, worker, [serv_mnesia_mgr]}),

    %% ets管理
    ok = util_game:start_child(Sup, {serv_ets_mgr, {serv_ets_mgr, start_link, [?WORLD_TYPE]},
       permanent, 30000, worker, [serv_ets_mgr]}),

    ok = util_world_sup:start_world_sup(Sup),

    ?INFO("world server Sup = ~w", [Sup]),
    {ok, Sup}.

%% sup 初始化
init([]) ->
    {ok, {{one_for_one, 10, 10}, []}}.

%% ====================================================================
%% Include functions
%% ====================================================================

