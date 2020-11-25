%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.06.14
%%% mnesia缓存管理模块接口
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(db_mnesia_util).

-include("common.hrl").
-include("app.hrl").

-export([
    stop_server/1
    , only_stop_server/1
    , do_stop_server/0
]).

%% 同步停止,立刻停止
stop_server(true) ->
    db_mnesia:stop(),
    {ok, ?STATUS_SUCCESS};
%% 异步通知 倒计时1分钟后停止服务器
stop_server(false) ->
    timer:apply_after(60 * 1000, ?MODULE, stop_server, [true]),
    {ok, ?STATUS_SUCCESS}.

%% 单独停止,立刻停止
only_stop_server(true) ->
    db_mnesia:only_stop(),
    {ok, ?STATUS_SUCCESS};
%% 异步通知 倒计时1分钟后停止服务器
only_stop_server(false) ->
    timer:apply_after(60 * 1000, ?MODULE, stop_server, [true]),
    {ok, ?STATUS_SUCCESS}.

%% 停止游戏
do_stop_server() ->
    %% 被动结束进程,simple_one_for_one启动的进程并不能完成执行terminate
    %% 系统停止时(init:stop/c:q/erlang:halt),会依次停止所有的进程
    %% 如果一个进程是监控树,则该监控树会先依次停止所有的子进程,然后结束自己
    %% 对于子进程也是同样的处理方法。
    init:stop().
