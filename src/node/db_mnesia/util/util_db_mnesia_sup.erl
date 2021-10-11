%% coding: latin-1
%%%----------------------------------------------------------------------
%%% zhanglong
%%% @date 2016-07-29
%%% db_mnesia节点启动进程顺序
%%%
%%%----------------------------------------------------------------------
-module(util_db_mnesia_sup).

-include("common.hrl").
-include("app.hrl").

-export([
    start_db_mnesia_sup/1
]).

%% 启动监控树
start_db_mnesia_sup(_Sup) ->

    %% master服节点
%%    ok = util_game:start_child(Sup, {serv_master_node, {serv_master_node, start_link, []},
%%        permanent, 30000, worker, [serv_master_node]}),

    ok.