%% coding: latin-1

-module(util_db_mysql_sup).

-include("common.hrl").
-include("app.hrl").

-export([
    start_db_mysql_sup/1
]).

%% 启动监控树
start_db_mysql_sup(Sup) ->

    %% 游戏数据库管监控树
    ok = util_game:start_child(Sup, {serv_db_mysql_sup, {serv_db_mysql_sup, start_link, []},
        permanent, infinity, supervisor, []}),

    %% 游戏数据库管理进程
    ok = util_game:start_child(Sup, {serv_db_mysql_mgr, {serv_db_mysql_mgr, start_link, []},
        permanent, 30000, worker, [serv_db_mysql_mgr]}),

    ok.


