%% coding: latin-1
%%%-------------------------------------------------------------------
%%% @copyright (C) 2019, <COMPANY>
%%% @author
%%% @doc
%%%         boss玩家mnesia表操作接口
%%% @end
%%%
%%%-------------------------------------------------------------------
-module(util_m_server_boss_player).

-include("common.hrl").
-include("db_mnesia.hrl").
-include("server_boss.hrl").

-compile(export_all).

%% ====================================================================
%% Api functions
%% ====================================================================
%% 增加全服boss玩家信息
%%add_server_boss_player(MBossPlayer) ->
%%    mnesia:dirty_write(?DB_SERVER_BOSS_PLAYER_M, MBossPlayer).
%%
%%%% 根据玩家id获取全服boss玩家信息
%%get_server_boss_player_by_id(RoleId) ->
%%    mnesia:dirty_read(?DB_SERVER_BOSS_PLAYER_M, RoleId).
%%
%%%% 更新全服boss玩家信息
%%update_server_boss_player(MBossPlayer) ->
%%    mnesia:dirty_write(?DB_SERVER_BOSS_PLAYER_M, MBossPlayer).
%%
%%%% 删除全服boss玩家信息
%%delete_server_boss_player(RoleId) ->
%%    mnesia:dirty_delete(?DB_SERVER_BOSS_PLAYER_M, RoleId).
%%
%%%% 清空全服boss玩家信息
%%clear_all_server_boss_player() ->
%%    mnesia:clear_table(?DB_SERVER_BOSS_PLAYER_M).
%%
%%%% 获取所有全服boss玩家信息
%%get_all_server_boss_player() ->
%%    MatchPre = #server_boss_player_m{_ = '_'},
%%    mnesia:dirty_match_object(?DB_SERVER_BOSS_PLAYER_M, MatchPre).
%%
%%%% 获取所有场景内的全服boss玩家信息
%%get_all_in_server_boss_player() ->
%%    MatchPre = #server_boss_player_m{player_status = ?IS_IN_SERVER_BOSS, _ = '_'},
%%    mnesia:dirty_match_object(?DB_SERVER_BOSS_PLAYER_M, MatchPre).