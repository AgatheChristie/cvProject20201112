%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% mnesia的接口函数
%%%
%%%----------------------------------------------------------------------
-module(util_mnesia).

-include("common.hrl").
-include("db_mnesia.hrl").
-include("node.hrl").


-export([
    init_mnesia_db/0
    , init_mnesia_db2/1
    , table_defines/0
]).

%% 初始化mnesia数据库表
init_mnesia_db() ->
    TabDefines = util_mnesia:table_defines(),
    init_mnesia_db2(TabDefines).

init_mnesia_db2([]) ->
    ok;
init_mnesia_db2([{Tab, TabDefine} | TTabDefines]) ->
    mnesia:create_table(Tab, TabDefine),
    init_mnesia_db2(TTabDefines).


%% mnesia的表定义
table_defines() ->
    DynamicTabs = [],
    FixTabs = table_defines_fix(),
    FixTabs ++ DynamicTabs.

%% 固定表定义
table_defines_fix() ->
    [
        {?DB_SENSITIVE_KEY_M, ?RAM_TABLE(ordered_set, sensitive_key_m)},
        {?DB_RANK_M, ?RAM_TABLE(set, rank_m)},
        {?DB_ICON_M, ?RAM_TABLE(set, icon_m)},
        {?DB_PUBLIC_MAIL_M, ?RAM_TABLE(set, public_mail_m)},
        {?DB_WORLD_CHAT_M, ?RAM_TABLE(set, world_chat_m)},
        {?DB_PUBLIC_PLAY_M, ?RAM_TABLE(set, public_play_m)},
        {?DB_MERGE_SERVER_M, ?RAM_TABLE(set, merge_server_m)},
        {?DB_ACTIVE_CHAT_M, ?RAM_TABLE(set, active_chat_m)},
        {?DB_DUMMY_SELECT_M, ?RAM_TABLE(set, dummy_select_m)},
        {?DB_DUMMY_GROW_M, ?RAM_TABLE(set, dummy_grow_m)},
        {?DB_ROLE_NAME_USED_M, ?RAM_TABLE(set, role_name_used_m)},
        {?DB_CROSS_M, ?RAM_TABLE(set, cross_m)},
        {?DB_BAN_M, ?RAM_TABLE(set, ban_m)},
        {?DB_RUN_LIGHT_M, ?RAM_TABLE(set, run_light_m)},
        {?DB_ACTIVITY_M, ?RAM_TABLE(set, activity_m)},
        {?DB_ACTIVITY_GROUP_M, ?RAM_TABLE(set, activity_group_m)},
        {?DB_ACTIVITY_MIX_M, ?RAM_TABLE(set, activity_mix_m)}
    ].
