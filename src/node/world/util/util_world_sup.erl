%% coding: latin-1
%%%----------------------------------------------------------------------
%%% taiqi
%%% @date 2016-07-29
%%% world节点启动进程顺序
%%%
%%%----------------------------------------------------------------------
-module(util_world_sup).

-include("common.hrl").
-include("app.hrl").
-include("node.hrl").

-export([
    start_world_sup/1
]).

%% 启动监控树
start_world_sup(Sup) ->

    %% 世界聊天管理进程
    ok = util_game:start_child(Sup, {serv_world_chat_mgr, {serv_world_chat_mgr, start_link, []},
        permanent, 30000, worker, [serv_world_chat_mgr]}),

    ok.