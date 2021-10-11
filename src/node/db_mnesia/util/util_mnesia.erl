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
    , import_table_defines/0
    , table_defines/0
    , table_defines_fix/0
    , table_defines_dynamic/0
    , node_table_defines/2
    , line_table_defines/2
    , role_base_table_defines/2
    , role_game_table_defines/2
    , role_gateway_table_defines/2
    , role_fight_table_defines/2
    , role_detail_table_defines/2
%%    , role_offline_table_defines/2
    , role_collect_table_defines/2
    , dummy_table_defines/2
    , dummy_detail_table_defines/2
    , rank_info_table_defines/0
    , rank_info_table_defines2/2
    , arena_match_table_defines/0
    , arena_match_table_defines2/2
    , snapshot_table_defines/0
    , snapshot_table_defines2/2
]).

%% 初始化mnesia数据库表
init_mnesia_db() ->
    TabDefines = util_mnesia:table_defines(),
    init_mnesia_db2(TabDefines),
    init_data().

init_mnesia_db2([]) ->
    ok;
init_mnesia_db2(TabDefines) ->
    [{Tab, TabDefine} | TTabDefines] = TabDefines,
    mnesia:create_table(Tab, TabDefine),
    init_mnesia_db2(TTabDefines).

%% 重要的mnesia表
import_table_defines() ->
    NodeTabs = node_table_defines(?MAX_NODE_TYPE, []),
    LineTabs = line_table_defines(?MAX_NODE_TYPE, []),
    NodeTabs ++ LineTabs.

%% mnesia的表定义
table_defines() ->
    DynamicTabs = table_defines_dynamic(),
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

%% 动态表定义
table_defines_dynamic() ->
    MaxNodeType = 18,
    NodeTabs = node_table_defines(MaxNodeType, []),
    LineTabs = line_table_defines(MaxNodeType, []),
    RoleBaseTabs = role_base_table_defines(?M_MAX_BASE_TAB, []),
    RoleGameTabs = role_game_table_defines(?M_MAX_GAME_TAB, []),
    RoleGatewayTabs = role_gateway_table_defines(?M_MAX_GATEWAY_TAB, []),
    RoleFightTabs = role_fight_table_defines(?M_MAX_FIGHT_TAB, []),
%%    RoleOfflineTabs = role_offline_table_defines(?M_MAX_OFFLINE_TAB, []),
    RoleDetailTabs = role_detail_table_defines(?M_MAX_DETAIL_TAB, []),
    RoleCollectTabs = role_collect_table_defines(?M_MAX_COLLECT_TAB, []),
    RoleDummyTabs = dummy_table_defines(?M_MAX_DUMMY_TAB, []),
    DummyDetailTabs = dummy_detail_table_defines(?M_MAX_DETAIL_TAB, []),
    RankInfoTabs = rank_info_table_defines(),
    ArenaMatchTabs = arena_match_table_defines(),
    SnapshotTabs = snapshot_table_defines(),
    NodeTabs ++ LineTabs ++ RoleBaseTabs ++ RoleGameTabs ++
        RoleGatewayTabs ++ RoleFightTabs ++ RoleDetailTabs
        ++ RoleCollectTabs ++ RoleDummyTabs ++ DummyDetailTabs ++ RankInfoTabs
        ++ ArenaMatchTabs ++ SnapshotTabs.

%% 节点表
node_table_defines(0, Result) ->
    Result;
node_table_defines(NodeType, Result) ->
    NewNodeType = NodeType - 1,
    NewResult = [{?DB_NODE_M(NodeType), ?RAM_TABLE(set, node_m)} | Result],
    node_table_defines(NewNodeType, NewResult).

%% 节点分线表
line_table_defines(0, Result) ->
    Result;
line_table_defines(NodeType, Result) ->
    NewNodeType = NodeType - 1,
    NewResult = [{?DB_LINE_M(NodeType), ?RAM_TABLE(set, line_m)} | Result],
    line_table_defines(NewNodeType, NewResult).

%% 玩家基础表
role_base_table_defines(0, Result) ->
    Result;
role_base_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_BASE_M(MaxType), ?RAM_TABLE(set, role_base_m)} | Result],
    role_base_table_defines(NewMaxType, NewResult).

%% 玩家游戏表
role_game_table_defines(0, Result) ->
    Result;
role_game_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_GAME_M(MaxType), ?RAM_TABLE(set, role_game_m)} | Result],
    role_game_table_defines(NewMaxType, NewResult).

%% 玩家游戏表
role_gateway_table_defines(0, Result) ->
    Result;
role_gateway_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_GATEWAY_M(MaxType), ?RAM_TABLE(set, role_gateway_m)} | Result],
    role_gateway_table_defines(NewMaxType, NewResult).

%% 玩家游戏表
role_fight_table_defines(0, Result) ->
    Result;
role_fight_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_FIGHT_M(MaxType), ?RAM_TABLE(set, role_fight_m)} | Result],
    role_fight_table_defines(NewMaxType, NewResult).

%% 玩家详细缓存表
role_detail_table_defines(0, Result) ->
    Result;
role_detail_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_DETAIL_M(MaxType), ?RAM_TABLE(set, role_detail_m)} | Result],
    role_detail_table_defines(NewMaxType, NewResult).

%% 玩家离线缓存表
%%role_offline_table_defines(0, Result) ->
%%    Result;
%%role_offline_table_defines(MaxType, Result) ->
%%    NewMaxType = MaxType - 1,
%%    NewResult = [{?DB_ROLE_OFFLINE_M(MaxType), ?RAM_TABLE(set, role)} | Result],
%%    role_offline_table_defines(NewMaxType, NewResult).
%% 玩家简单收集表
role_collect_table_defines(0, Result) ->
    Result;
role_collect_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_COLLECT_M(MaxType), ?RAM_TABLE(set, role_collect_m)} | Result],
    role_collect_table_defines(NewMaxType, NewResult).

%% 玩家假人缓存表
dummy_table_defines(0, Result) ->
    Result;
dummy_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_DUMMY_M(MaxType), ?RAM_TABLE(set, dummy_m)} | Result],
    dummy_table_defines(NewMaxType, NewResult).

%% 假人详细缓存表
dummy_detail_table_defines(0, Result) ->
    Result;
dummy_detail_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_DUMMY_DETAIL_M(MaxType), ?RAM_TABLE(set, dummy_detail_m)} | Result],
    dummy_detail_table_defines(NewMaxType, NewResult).

%% 排行榜信息
rank_info_table_defines() ->
    RankTypes = [1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1011, 1015, 1009, 1017, 1014, 1016, 1022, 1020, 1019, 1018, 1010, 1013, 1021, 1012, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034],
    rank_info_table_defines2(RankTypes, []).

rank_info_table_defines2([], Result) ->
    Result;
rank_info_table_defines2(RankTypes, Result) ->
    [RankType | TRankTypes] = RankTypes,
    DefinesList =
        [
            {?DB_RANK_INFO_M(RankType), ?RAM_TABLE(set, rank_info_m)}
        ],
    NewResult = DefinesList ++ Result,
    rank_info_table_defines2(TRankTypes, NewResult).

%% 竞技场匹配
arena_match_table_defines() ->
    GroupIds = [1, 2, 3, 4, 5, 6, 7, 8],
    arena_match_table_defines2(GroupIds, []).

arena_match_table_defines2([], Result) ->
    Result;
arena_match_table_defines2(GroupIds, Result) ->
    [GroupId | TGroupIds] = GroupIds,
    DefinesList =
        [
            {?DB_ARENA_MATCH_M(GroupId), ?RAM_TABLE(set, arena_match_m)}
        ],
    NewResult = DefinesList ++ Result,
    arena_match_table_defines2(TGroupIds, NewResult).

%% 快照信息
snapshot_table_defines() ->
    SnapshotTypes = [1001, 1002],
    snapshot_table_defines2(SnapshotTypes, []).

snapshot_table_defines2([], Result) ->
    Result;
snapshot_table_defines2(SnapshotTypes, Result) ->
    [SnapshotType | TSnapshotTypes] = SnapshotTypes,
    DefinesList =
        [
            {?DB_SNAPSHOT_M(SnapshotType), ?RAM_TABLE(set, snapshot_m)}
        ],
    NewResult = DefinesList ++ Result,
    snapshot_table_defines2(TSnapshotTypes, NewResult).

init_data() ->
    MBossPlayer = #server_boss_player_m{
        role_id = 700001,
        player_status = 1,
        total_damage = 40000
    },
    util_m_server_boss_player:add_server_boss_player(MBossPlayer),
    MBossPlayer2 = #server_boss_player_m{
        role_id = 700002,
        player_status = 2
    },
    util_m_server_boss_player:add_server_boss_player(MBossPlayer2),
    MBossPlayer3 = #server_boss_player_m{
        role_id = 700003,
        player_status = 1
    },
    util_m_server_boss_player:add_server_boss_player(MBossPlayer3),
    ok.



