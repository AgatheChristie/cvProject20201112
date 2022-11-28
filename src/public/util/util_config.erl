%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 游戏内配置接口
%%%
%%%----------------------------------------------------------------------
-module(util_config).

-include("common.hrl").
-include("config.hrl").

-compile(export_all).

%% 游戏数据库连接池的连接数
db_game_pool_connect() ->
    2.

%% 游戏数据库连接池数量
db_game_pool() ->
    1.

%% 是否启动多节点
many_node() ->
    false.

%% 是否开启消息中转器
is_mid_msg() ->
    false.