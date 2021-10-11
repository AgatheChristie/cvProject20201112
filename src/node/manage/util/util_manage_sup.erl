%% coding: latin-1
%%%----------------------------------------------------------------------
%%% zhanglong
%%% @date 2016-07-29
%%% fight节点启动进程顺序
%%%
%%%----------------------------------------------------------------------
-module(util_manage_sup).

-include("common.hrl").
-include("app.hrl").

-export([
    start_manage_sup/1
]).

%% 启动监控树
start_manage_sup(Sup) ->


    %% mysql数据库
%%    ok = util_db_mysql_sup:start_db_mysql_sup(Sup),

    %% mnesia数据库
	ok = util_db_mnesia_sup:start_db_mnesia_sup(Sup),


    ok.