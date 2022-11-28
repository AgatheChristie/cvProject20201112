%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 数据结构初始化
%%%
%%%----------------------------------------------------------------------

-module(db_field_init).

-include("common.hrl").

-include("tab.hrl").


-compile(export_all).



%% 世界聊天
init_world_chat(?NONE) ->
    init_world_chat();
init_world_chat(#world_chat{} = WorldChat) ->
    WorldChat.

init_world_chat() ->
    #world_chat{}.