%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2012.09.19
%%% 
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(db_game_win).

-include("common.hrl").
-include("db.hrl").
-include("tab.hrl").

-compile(export_all).

%% 列表
list() ->
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = game_win_info:first_tab(),
    case game_win_info:select(PoolId, Tab) of
        {ok, GameWinInfos} ->
            {ok, GameWinInfos};
        Reason ->
            Reason
    end.

%% 增加一条记录
add(GameWinInfo) ->
    #game_win_info{id = Id} = GameWinInfo,
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = game_win_info:assign_tab(Id, ?TAB_SPLIT_NUM),
    case game_win_info:insert(PoolId, Tab, GameWinInfo) of
        ok ->
            ok;
        Reason ->
            Reason
    end.

delete(Id) ->
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = game_win_info:assign_tab(Id, ?TAB_SPLIT_NUM),
    case game_win_info:delete(PoolId, Tab, Id) of
        ok ->
            ok;
        Reason ->
            Reason
    end.

update(GameWinInfo) ->
    #game_win_info{id = Id} = GameWinInfo,
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = game_win_info:assign_tab(Id, ?TAB_SPLIT_NUM),
    case game_win_info:update(PoolId, Tab, GameWinInfo) of
        ok ->
            ok;
        Reason ->
            Reason
    end.

%% 替换
replace(GameWinInfo) ->
    #game_win_info{id = Id} = GameWinInfo,
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = game_win_info:assign_tab(Id, ?TAB_SPLIT_NUM),
    case game_win_info:replace(PoolId, Tab, GameWinInfo) of
        ok ->
            ok;
        Reason ->
            Reason
    end.

%% 查询
select(Id) ->
    PoolId = util_db_mysql_serv:get_pool_id(),
    Tab = game_win_info:first_tab(),
    case game_win_info:select(PoolId, Tab, game_win_info:fields(), util_db:where(Id), true, util_db:other()) of
        {ok, GameWinInfos} ->
            {ok, GameWinInfos};
        Reason ->
            Reason
    end.

%% 查询最大id
select_max_id() ->
    PoolId = util_db_mysql_serv:get_pool_id(),
    Other = util_db:other(),
    Tab = game_win_info:first_tab(),
    case game_win_info:select(PoolId, Tab, ["max(id)"], "", "", false, Other) of
        {ok, [[undefined]]} ->
            {ok, 0};
        {ok, [[MaxId]]} ->
            {ok, MaxId};
        {ok, []} ->
            {ok, 0};
        Reason ->
            Reason
    end.