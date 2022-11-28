%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 世界聊天管理接口
%%%
%%%----------------------------------------------------------------------
-module(util_world_chat_mgr).

-include("common.hrl").
-include("db_mnesia.hrl").
-include("tab.hrl").


-compile(export_all).


chat_type_only_id(_ChatType) ->
    ?ERROR("cvChatType err:~w", [_ChatType]),
    0.

%% 初始化世界聊天
init_world_chat() ->
    %% 查看数据库中所有的世界聊天列表
    WorldChats = util_world_chat_mgr:list(),
    %% 按时间排序,先发送的先获取唯一id
    WorldChats2 = lists:keysort(#world_chat.id, WorldChats),
    ?ERROR("WorldChats2 data:~w", [WorldChats2]),
    %%   init_world_chat2(WorldChats2),
    %% 获取所有缓存
    %%    MWorldChats = util_m_world_chat:get_all_world_chat(),
    %% 重新持久
    %%   util_world_chat_mgr:save_data2(MWorldChats, WorldChats2),
    ok.

init_world_chat2([]) ->
    next;
init_world_chat2(WorldChats) ->
    [WorldChat | TWorldChats] = WorldChats,
    #world_chat{
        id = ChatId,
        chat_type = ChatType
    } = WorldChat,
    MWorldChat = util_world_chat_mgr:to_m_world_chat(WorldChat),
    OnlyId = util_world_chat_mgr:chat_type_only_id(ChatType),
    case OnlyId =:= 0 of
        true ->
            init_world_chat2(TWorldChats);
        false ->
            MWorldChat2 = MWorldChat#world_chat_m{
                id = OnlyId
            },
            %% 加入mnesia内存
            util_m_world_chat:add_world_chat(MWorldChat2),
            %% 删除旧的数据
            util_world_chat_mgr:delete(ChatId),
            init_world_chat2(TWorldChats)
    end.


to_m_world_chat(WorldChat) ->
    #world_chat{
        id = Id,
        role_id = RoleId,
        chat_type = ChatType,
        chat_sec = ChatSec,
        is_light = IsLight,
        chat_parts = ChatParts
    } = WorldChat,
    MChatParts = to_m_chat_part(ChatParts, []),
    #world_chat_m{
        id = Id,
        role_id = RoleId,
        chat_type = ChatType,
        chat_sec = ChatSec,
        is_light = IsLight,
        chat_parts = MChatParts
    }.

to_world_chat(MWorldChat) ->
    #world_chat_m{
        id = Id,
        role_id = RoleId,
        chat_type = ChatType,
        chat_sec = ChatSec,
        is_light = IsLight,
        chat_parts = MChatParts
    } = MWorldChat,
    InitWorldChat = db_field_init:init_world_chat(),
    ChatParts = to_chat_part(MChatParts, []),
    InitWorldChat#world_chat{
        id = Id,
        role_id = RoleId,
        chat_type = ChatType,
        chat_sec = ChatSec,
        is_light = IsLight,
        chat_parts = ChatParts
    }.

to_m_chat_part([], Result) ->
    lists:reverse(Result);
to_m_chat_part([ChatPart | TChatParts], Result) ->
    #chat_part{
        type = Type,
        content = Content,
        int_values = IntValues,
        string_values = StringValues,
        template_id = ChatTemId
    } = ChatPart,
    MChatPart = #world_chat_part_m{
        type = Type,
        content = Content,
        int_values = IntValues,
        string_values = StringValues,
        template_id = ChatTemId
    },
    to_m_chat_part(TChatParts, [MChatPart | Result]).

to_chat_part([], Result) ->
    lists:reverse(Result);
to_chat_part([MChatPart | TMChatParts], Result) ->
    #world_chat_part_m{
        type = Type,
        content = Content,
        int_values = IntValues,
        string_values = StringValues,
        template_id = ChatTemId
    } = MChatPart,
    ChatPart = #chat_part{
        type = Type,
        content = Content,
        int_values = IntValues,
        string_values = StringValues,
        template_id = ChatTemId
    },
    to_chat_part(TMChatParts, [ChatPart | Result]).

%% 同步保存世界聊天数据
replace_once(WorldChat) ->
    #world_chat{id = Id} = WorldChat,
    PoolId = util_db_game:assign_pool_id(Id),
    util_db:assign_write_sync(db_world_chat, replace, WorldChat, PoolId).

%% 查找world_chat
select(Id) ->
    PoolId = util_db_game:assign_pool_id(Id),
    util_db:assign_select_sync(db_world_chat, select, [Id], PoolId).

%% 查找所有world_chat
list() ->
    util_db:select_sync(db_world_chat, list, []).

%% 删除world_chat
delete(Id) ->
    PoolId = util_db_game:assign_pool_id(Id),
    util_db:assign_delete_sync(db_world_chat, delete, [Id], PoolId).

%% 持久数据
save_data() ->
    WorldChats = util_world_chat_mgr:list(),
    MWorldChats = util_m_world_chat:get_all_world_chat(),
    save_data2(MWorldChats, WorldChats).

save_data2([], DelWorldChats) ->
    del_world_chat_log(DelWorldChats);
save_data2([MWorldChat | TMWorldChats], DelWorldChats) ->
    #world_chat_m{
        id = Id
    } = MWorldChat,
    %% 判断是否还在数据库中
    case lists:keyfind(Id, #world_chat.id, DelWorldChats) of
        #world_chat{} ->
            DelWorldChats2 = lists:keydelete(Id, #world_chat.id, DelWorldChats),
            WorldChat = to_world_chat(MWorldChat),
            util_world_chat_mgr:replace_once(WorldChat),
            save_data2(TMWorldChats, DelWorldChats2);
        _ ->
            WorldChat = to_world_chat(MWorldChat),
            util_world_chat_mgr:replace_once(WorldChat),
            save_data2(TMWorldChats, DelWorldChats)
    end.

%% 删除聊天记录
del_world_chat_log([]) ->
    next;
del_world_chat_log([DelWorldChat | TDelWorldChats]) ->
    #world_chat{
        id = Id
    } = DelWorldChat,
    util_world_chat_mgr:delete(Id),
    del_world_chat_log(TDelWorldChats).

get_cross_chat(ChatType) ->
    MWorldChats = util_m_world_chat:match_world_chat(ChatType),
    %% 按id由小大到排序
    MWorldChats2 = lists:keysort(#world_chat_m.id, MWorldChats),
    %% 尾递归又倒序了一次
    PChatContents = util_chat:to_p_world_chats(MWorldChats2, []),
    {ok, PChatContents}.

%% 清空聊天
clear_world_chat() ->
    util_m_world_chat:clear_world_chat(),
    WorldChats = util_world_chat_mgr:list(),
    util_world_chat_mgr:del_world_chat_log(WorldChats).



