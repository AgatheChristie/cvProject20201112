%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 聊天接口
%%%
%%%----------------------------------------------------------------------
-module(util_chat).

-include("common.hrl").

-include("log.hrl").
-include("db_mnesia.hrl").
-include("tab.hrl").


-compile(export_all).


%% 世界聊天记录转换
to_p_world_chats([], Result) ->
    Result;
to_p_world_chats([MWorldChat | TMWorldChats], Result) ->
    {ok, PChatContent} = to_p_world_chat(MWorldChat),
    to_p_world_chats(TMWorldChats, [PChatContent | Result]).

to_p_world_chat(#world_chat_m{} = _MWorldChat) ->
    PChatContent = {qqq,ar},
    {ok, PChatContent}.




