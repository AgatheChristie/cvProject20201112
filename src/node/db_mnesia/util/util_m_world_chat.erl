%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 世界聊天查询
%%%
%%%----------------------------------------------------------------------

-module(util_m_world_chat).

-include("common.hrl").
-include("db_mnesia.hrl").

-compile(export_all).

%% 增加世界聊天
add_world_chat(MWorldChat) ->
    mnesia:dirty_write(?DB_WORLD_CHAT_M, MWorldChat).

%% 更新世界聊天
update_world_chat(MWorldChat) ->
    mnesia:dirty_write(?DB_WORLD_CHAT_M, MWorldChat).

%% 删除世界聊天
delete_world_chat(Id) ->
    mnesia:dirty_delete(?DB_WORLD_CHAT_M, Id).

%% 删除所有世界聊天
clear_world_chat() ->
    mnesia:clear_table(?DB_WORLD_CHAT_M).

%% 获取所有世界聊天
get_all_world_chat() ->
    MatchPre = #world_chat_m{_ = '_'},
    mnesia:dirty_match_object(?DB_WORLD_CHAT_M, MatchPre).

%% 获取世界聊天的信息
get_world_chat(Id) ->
    mnesia:dirty_read(?DB_WORLD_CHAT_M, Id).

%% 匹配类型世界聊天
match_world_chat(ChatType) ->
    MatchPre = #world_chat_m{chat_type = ChatType, _ = '_'},
    mnesia:dirty_match_object(?DB_WORLD_CHAT_M, MatchPre).

%% 根据玩家id获取聊天信息
world_chat_by_role_id(ChatType, RoleId) ->
    MatchPre = #world_chat_m{chat_type = ChatType, role_id = RoleId, _ = '_'},
    mnesia:dirty_match_object(?DB_WORLD_CHAT_M, MatchPre).