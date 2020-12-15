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
    {atomic, ok} = mnesia:create_table(Tab, TabDefine),
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
        {?DB_HANGHUI_M, ?RAM_TABLE(set, hanghui_m)},
        {?DB_PUBLIC_PLAY_M, ?RAM_TABLE(set, public_play_m)},
        {?DB_PLAY_REFRESH_M, ?RAM_TABLE(set, play_refresh_m)},
        {?DB_MERGE_SERVER_M, ?RAM_TABLE(set, merge_server_m)},
        {?DB_ACTIVE_CHAT_M, ?RAM_TABLE(set, active_chat_m)},
        {?DB_DUMMY_SELECT_M, ?RAM_TABLE(set, dummy_select_m)},
        {?DB_DUMMY_GROW_M, ?RAM_TABLE(set, dummy_grow_m)},
        {?DB_ROLE_NAME_USED_M, ?RAM_TABLE(set, role_name_used_m)},
        {?DB_CROSS_M, ?RAM_TABLE(set, cross_m)},
        {?DB_TEAM_M, ?RAM_TABLE(set, team_m)},
        {?DB_BAN_M, ?RAM_TABLE(set, ban_m)},
        {?DB_RUN_LIGHT_M, ?RAM_TABLE(set, run_light_m)},
        {?DB_ACTIVITY_M, ?RAM_TABLE(set, activity_m)},
        {?DB_ACTIVITY_GROUP_M, ?RAM_TABLE(set, activity_group_m)},
        {?DB_ACTIVITY_MIX_M, ?RAM_TABLE(set, activity_mix_m)},
        {?DB_MARKET_M, ?RAM_TABLE(set, market_m)},
        {?DB_MARKET_ROLE_M, ?RAM_TABLE(set, market_role_m)},
        {?DB_AUCTION_M, ?RAM_TABLE(set, auction_m)},
        {?DB_KINGDOM_PLAYER_M, ?RAM_TABLE(set, kingdom_player_m)},
        {?DB_FB_SCENE_M, ?RAM_TABLE(set, fb_scene_m)},
        {?DB_SERVER_BOSS_PLAYER_M, ?RAM_TABLE(set, server_boss_player_m)},
        {?DB_HANGHUI_WAR_M, ?RAM_TABLE(set, hanghui_war_m)},
        {?DB_HANGHUI_WAR_PLAYER_M, ?RAM_TABLE(set, hanghui_war_player_m)},
        {?DB_ANCIENT_M, ?RAM_TABLE(set, ancient_m)},
        {?DB_BOSS_HP_M, ?RAM_TABLE(set, boss_hp_m)},
        {?DB_DARK_TEMPLE_M, ?RAM_TABLE(set, dark_temple_m)},
        {?DB_DARK_TEMPLE_SCENE_M, ?RAM_TABLE(set, dark_temple_scene_m)},
        {?DB_MINE_HOLE_M, ?RAM_TABLE(set, mine_hole_m)},
        {?DB_CONVOY_PLAYER_M, ?RAM_TABLE(set, convoy_player_m)},
        {?DB_NEARBY_MATCH_M, ?RAM_TABLE(set, nearby_match_m)},
        {?DB_WARCRAFT_PLAYER_M, ?RAM_TABLE(set, warcraft_player_m)},
        {?DB_WARCRAFT_HANGHUI_M, ?RAM_TABLE(set, warcraft_hanghui_m)},
        {?DB_DARK_SHRINE_SCENE_M, ?RAM_TABLE(set, dark_shrine_scene_m)},
        {?DB_DARK_SHRINE_FIGHT_M, ?RAM_TABLE(set, dark_shrine_fight_m)},
        {?DB_DARK_SHRINE_FIGHT_SCENE_M, ?RAM_TABLE(set, dark_shrine_fight_scene_m)},
        {?DB_ETERNAL_TOWER_M, ?RAM_TABLE(set, eternal_tower_m)},
        {?DB_HANGHUI_CROSS_WAR_M, ?RAM_TABLE(set, hanghui_cross_war_m)},
        {?DB_HANGHUI_CROSS_WAR_PLAYER_M, ?RAM_TABLE(set, hanghui_cross_war_player_m)}
    ].
