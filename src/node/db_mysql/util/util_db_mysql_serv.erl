%% coding: latin-1
%%%----------------------------------------------------------------------
%%% taiqi
%%% @date 2016-07-29
%%% 数据库接口
%%%
%%%----------------------------------------------------------------------
-module(util_db_mysql_serv).

-include("common.hrl").
-include("app.hrl").
-include("db.hrl").

-compile(export_all).

%% 获取db_mysql服务名称
db_mysql_serv_name(PoolId) ->
    util:prefix_n("db_mysql", [PoolId]).

%% 启动db_mysql进程
start_db_mysql(PoolId) ->
    {ok, DbMysqlPid} = supervisor:start_child(serv_db_mysql_sup, [PoolId]),
    {ok, DbMysqlPid}.

%% 设置数据库池
set_pool_id(PoolId) ->
    erlang:put(?MYSQL_POOL_ID, PoolId).

%% 获取数据库池
get_pool_id() ->
    case erlang:get(?MYSQL_POOL_ID) of
        undefined ->
            ?DB_GAME_POOL;
        PoolId ->
            PoolId
    end.

%% 检查处理公共同步
check_deal_common_sync(State, M, F, A) ->
    ResMsg = erlang:apply(M, F, A),
    {ok, State, ResMsg}.

%% 处理公共同步
deal_common_sync(State, M, F, A) ->
    case catch check_deal_common_sync(State, M, F, A) of
        {ok, State, ResMsg} ->
            {ok, State, ResMsg};
        {error, Code} ->
            {ok, State, {error, Code}};
        _E ->
            ?ERROR("处理公共同步出错:~w", [_E]),
            ?ERROR("处理公共同步失败:erlang:apply(~w,~w,~w)", [M, F, A]),
            {ok, State, {error, ?E_DB}}
    end.

%% 检查处理同步写入
check_deal_write_sync(State, M, F, A) ->
    ResMsg = erlang:apply(M, F, A),
    {ok, State, ResMsg}.

%% 处理同步写入
deal_write_sync(State, M, F, A) ->
    case catch check_deal_write_sync(State, M, F, A) of
        {ok, State, ResMsg} ->
            {ok, State, ResMsg};
        {error, Code} ->
            {ok, State, {error, Code}};
        _E ->
            ?ERROR("处理同步写入出错:~w", [_E]),
            ?ERROR("处理同步写入失败:erlang:apply(~w,~w,~w)", [M, F, A]),
            {ok, State, {error, ?E_DB}}
    end.

%% 检查处理同步查询
check_deal_select_sync(State, M, F, A) ->
    ResMsg = erlang:apply(M, F, A),
    {ok, State, ResMsg}.

%% 处理同步查询
deal_select_sync(State, M, F, A) ->
    case catch check_deal_select_sync(State, M, F, A) of
        {ok, State, ResMsg} ->
            {ok, State, ResMsg};
        {error, Code} ->
            {ok, State, {error, Code}};
        _E ->
            ?ERROR("处理同步查询出错:~w", [_E]),
            ?ERROR("处理同步查询方法失败:erlang:apply(~w,~w,~w)", [M, F, A]),
            {ok, State, {error, ?E_DB}}
    end.

%% 检查处理同步删除
check_deal_delete_sync(State, M, F, A) ->
    ResMsg = erlang:apply(M, F, A),
    {ok, State, ResMsg}.

%% 处理同步删除
deal_delete_sync(State, M, F, A) ->
    case catch check_deal_delete_sync(State, M, F, A) of
        {ok, State, ResMsg} ->
            {ok, State, ResMsg};
        {error, Code} ->
            {ok, State, {error, Code}};
        _E ->
            ?ERROR("处理同步删除出错:~w", [_E]),
            ?ERROR("处理同步删除失败:erlang:apply(~w,~w,~w)", [M, F, A]),
            {ok, State, {error, ?E_DB}}
    end.