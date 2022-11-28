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
-include("tab.hrl").


-compile(export_all).

%% 检查是否落地缓存
check_is_save(IsSave, IsSaveSec, IsTimer) ->
    ?IF(IsSave =:= ?MNESIA_IS_SAVE, next, ?C2SERR(?E_NOT_NEED_SAVE_DATA)),
    case IsTimer of
        true ->
            NowSec = util_time:now_sec(),
            DiffSec = NowSec - IsSaveSec,
            ?IF(DiffSec >= ?MNESIA_SAVE_SEC, next, ?C2SERR(?E_NOT_NEED_SAVE_SEC));
        false ->
            next
    end.

%% 初始化mnesia数据库表
init_mnesia_db() ->
    TabDefines = util_mnesia:table_defines(),
    init_mnesia_db2(TabDefines).

init_mnesia_db2([]) ->
    ok;
init_mnesia_db2([{Tab, TabDefine} | TTabDefines]) ->
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
        {?DB_PUBLIC_PLAY_M, ?RAM_TABLE(set, public_play_m)},
        {?DB_LEAGUE_M, ?RAM_TABLE(set, league_m)},
        {?DB_MERGE_SERVER_M, ?RAM_TABLE(set, merge_server_m)},
        {?DB_ACTIVE_CHAT_M, ?RAM_TABLE(set, active_chat_m)},
        {?DB_CROSS_M, ?RAM_TABLE(set, cross_m)},
        {?DB_RUN_LIGHT_M, ?RAM_TABLE(set, run_light_m)},
        {?DB_ACTIVITY_M, ?RAM_TABLE(set, activity_m)},
        {?DB_ACTIVITY_GROUP_M, ?RAM_TABLE(set, activity_group_m)},
        {?DB_ACTIVITY_MIX_M, ?RAM_TABLE(set, activity_mix_m)},
        {?DB_CITY_M, ?RAM_TABLE(set, city_m)},
        {?DB_ROLE_ORDER_M, ?RAM_TABLE(set, role_order_m)},
        {?DB_TEAM_ORDER_M, ?RAM_TABLE(set, team_order_m)},
        {?DB_BATTLE_INFO_M, ?RAM_TABLE(set, battle_info_m)},
        {?DB_BATTLE_REPORT_INFO_M, ?RAM_TABLE(set, battle_report_info_m)},
        {?DB_CAMP_INFO_M, ?RAM_TABLE(set, camp_info_m)},
        {?DB_PLOT_MON_M, ?RAM_TABLE(set, plot_mon_m)},
        {?DB_FIGHT_SOCKET_M, ?RAM_TABLE(set, fight_socket_m)},
        {?DB_WHOLE_ROLE_M, ?RAM_TABLE(set, whole_role_m)},
        {?DB_TREND_INFO_M, ?RAM_TABLE(set, trend_info_m)},
        {?DB_VOTE_INFO_M, ?RAM_TABLE(set, vote_info_m)},
        {?DB_SUBJECT_M, ?RAM_TABLE(set, subject_m)},
        {?DB_PUBLIC_PRIVILEGE_M, ?RAM_TABLE(set, public_privilege_m)},
        {?DB_MJ_CHALLENGE_INFO_M, ?RAM_TABLE(set, mj_challenge_info_m)}
    ].

%% 动态表定义
table_defines_dynamic() ->
    MaxNodeType = util_node:convert_node_type(?MAX_NODE_TYPE),
    NodeTabs = node_table_defines(MaxNodeType, []),
    LineTabs = line_table_defines(MaxNodeType, []),
    RoleBaseTabs = role_base_table_defines(?M_MAX_BASE_TAB, []),
    RoleGameTabs = role_game_table_defines(?M_MAX_GAME_TAB, []),
    RoleGatewayTabs = role_gateway_table_defines(?M_MAX_GATEWAY_TAB, []),
    RoleFightTabs = role_fight_table_defines(?M_MAX_FIGHT_TAB, []),
    RoleOfflineTabs = role_offline_table_defines(?M_MAX_OFFLINE_TAB, []),
    RoleSaveTabs = role_save_table_defines(?M_MAX_ROLE_SAVE_TAB, []),
    RoleSaveMsgTabs = role_save_msg_table_defines(?M_MAX_ROLE_SAVE_MSG_TAB, []),
    RoleDetailTabs = role_detail_table_defines(?M_MAX_DETAIL_TAB, []),
    RoleCollectTabs = role_collect_table_defines(?M_MAX_COLLECT_TAB, []),
    RoleSimpleTabs = role_simple_table_defines(?M_MAX_SIMPLE_TAB, []),

    RankInfoTabs = rank_info_table_defines(),
    SnapshotTabs = snapshot_table_defines(),
    Types = lists:seq(1, 3),
    BanMgrTabs = ban_mgr_table_defines(Types, []),
    NodeTabs ++ LineTabs ++ RoleBaseTabs ++ RoleOfflineTabs ++ RoleSaveTabs ++
        RoleSaveMsgTabs ++ RoleGameTabs ++ RoleGatewayTabs ++ RoleFightTabs ++
        RoleDetailTabs ++ RoleCollectTabs ++ RoleSimpleTabs ++ RankInfoTabs ++
        SnapshotTabs ++ BanMgrTabs.

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
role_offline_table_defines(0, Result) ->
    Result;
role_offline_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_OFFLINE_M(MaxType), ?RAM_TABLE(set, role)} | Result],
    role_offline_table_defines(NewMaxType, NewResult).

%% 玩家保存缓存表
role_save_table_defines(0, Result) ->
    Result;
role_save_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_SAVE_M(MaxType), ?RAM_TABLE(set, role_save_m)} | Result],
    role_save_table_defines(NewMaxType, NewResult).

%% 玩家保存离线信息缓存表
role_save_msg_table_defines(0, Result) ->
    Result;
role_save_msg_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_SAVE_MSG_M(MaxType), ?RAM_TABLE(set, role_save_msg_m)} | Result],
    role_save_msg_table_defines(NewMaxType, NewResult).

%% 玩家简单收集表
role_collect_table_defines(0, Result) ->
    Result;
role_collect_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_COLLECT_M(MaxType), ?RAM_TABLE(set, role_collect_m)} | Result],
    role_collect_table_defines(NewMaxType, NewResult).

%% 玩家简单信息表
role_simple_table_defines(0, Result) ->
    Result;
role_simple_table_defines(MaxType, Result) ->
    NewMaxType = MaxType - 1,
    NewResult = [{?DB_ROLE_SIMPLE_M(MaxType), ?RAM_TABLE(set, role_simple_m)} | Result],
    role_simple_table_defines(NewMaxType, NewResult).

%% 排行榜信息
rank_info_table_defines() ->
    RankTypes = [1,2,3],
    rank_info_table_defines2(RankTypes, []).

rank_info_table_defines2([], Result) ->
    Result;
rank_info_table_defines2([RankType | TRankTypes], Result) ->
    DefinesList =
        [
            {?DB_RANK_INFO_M(RankType), ?RAM_TABLE(set, rank_info_m)}
        ],
    NewResult = DefinesList ++ Result,
    rank_info_table_defines2(TRankTypes, NewResult).

%% 快照信息
snapshot_table_defines() ->
    SnapshotTypes = [1,2,3],
    snapshot_table_defines2(SnapshotTypes, []).

snapshot_table_defines2([], Result) ->
    Result;
snapshot_table_defines2([SnapshotType | TSnapshotTypes], Result) ->
    DefinesList =
        [
            {?DB_SNAPSHOT_M(SnapshotType), ?RAM_TABLE(set, snapshot_m)}
        ],
    NewResult = DefinesList ++ Result,
    snapshot_table_defines2(TSnapshotTypes, NewResult).

%% 封禁管理
ban_mgr_table_defines([], Result) ->
    Result;
ban_mgr_table_defines([Type | Types], Result) ->
    NewResult = [{?DB_BAN_MGR_M(Type), ?RAM_TABLE(set, ban_mgr_m)} | Result],
    ban_mgr_table_defines(Types, NewResult).