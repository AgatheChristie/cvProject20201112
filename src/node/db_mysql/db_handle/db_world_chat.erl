%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2021.07.18
%%% 世界聊天信息
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(db_world_chat).

-include("common.hrl").
-include("db.hrl").
-include("tab.hrl").


-export([
    list/0
    , add/1
    , delete/1
    , select/1
    , update/1
    , replace/1
]).

%% 列表
list() ->
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = world_chat:first_tab(),
    case world_chat:select(PoolId, Tab) of
        {ok, WorldChats} ->
            {ok, WorldChats};
        Reason ->
            Reason
    end.

%% 增加一条记录
add(WorldChat) ->
    #world_chat{id = Id} = WorldChat,
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = world_chat:assign_tab(Id, ?TAB_SPLIT_NUM),
    case world_chat:insert(PoolId, Tab, WorldChat) of
        ok ->
            ok;
        Reason ->
            Reason
    end.

%% 删除
delete(Id) ->
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = world_chat:assign_tab(Id, ?TAB_SPLIT_NUM),
    case world_chat:delete(PoolId, Tab, Id) of
        ok ->
            ok;
        Reason ->
            Reason
    end.

%% 更新
update(WorldChat) ->
    #world_chat{id = Id} = WorldChat,
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = world_chat:assign_tab(Id, ?TAB_SPLIT_NUM),
    case world_chat:update(PoolId, Tab, WorldChat) of
        ok ->
            ok;
        Reason ->
            Reason
    end.

%% 替换
replace(WorldChat) ->
    #world_chat{id = Id} = WorldChat,
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = world_chat:assign_tab(Id, ?TAB_SPLIT_NUM),
    case world_chat:replace(PoolId, Tab, WorldChat) of
        ok ->
            ok;
        Reason ->
            Reason
    end.

%% 查询
select(Id) ->
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = world_chat:first_tab(),
    case world_chat:select(PoolId, Tab, world_chat:fields(), util_db:where(Id), true, util_db:other()) of
        {ok, WorldChats} ->
            {ok, WorldChats};
        Reason ->
            Reason
    end.