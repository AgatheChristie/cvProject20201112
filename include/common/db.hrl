%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date: 2016-07-22
%%% 数据库相关定义文件
%%%
%%%----------------------------------------------------------------------
-ifndef(DB_HRL).
-define(DB_HRL, true).

%% 给字段添加
-define(FIELD_ALL, ["*"]).
-define(FIELD_QUOTE(F), [$`, F, $`]).

%% mysql执行超时
-define(MYSQL_TIMEOUT, 10000).

%% 数据库类型
-define(MYSQL_TEYP_GAME, 1).                                            %% 游戏数据库
-define(MYSQL_TEYP_CENTER, 2).                                          %% 中央数据库

%% 数据库分表数量
-define(TAB_SPLIT_NUM, 1).                                              %% 数据库分表数量

%% db_mysql进程
-record(db_mysql_state, {
    pool_id = 0                                                         %% 池id
}).

-endif. % DB_HRL
