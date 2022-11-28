%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% ets管理接口
%%%
%%%----------------------------------------------------------------------

-module(util_ets_mgr).

-include("common.hrl").
-include("db_mnesia.hrl").
-include("login.hrl").
-include("db_ets.hrl").
-include("role_group.hrl").
-include("role_dict.hrl").
-include("app.hrl").
-include("log.hrl").
-include("gw_role.hrl").
-include("admin_collect.hrl").
-include("tab.hrl").
-include("node.hrl").

-export([
    init_ets/1
    , many_init_ets/1
    , single_init_ets/0
    , manage_init_est/0
    , center_init_est/0
    , world_init_est/0
    , game_init_ets/0
    , offline_init_ets/0
    , fight_init_ets/0
    , whole_init_ets/0
    , login_init_ets/0
    , log_init_ets/0
    , chat_init_ets/0
    , admin_init_ets/0
    , gateway_init_ets/0
    , db_mysql_init_ets/0
    , poll_init_ets/0
    , db_mnesia_init_ets/0
]).

%% 初始化ets表
init_ets(NodeType) ->
    case util_config:many_node() of
        true ->
            many_init_ets(NodeType);
        false ->
            single_init_ets()
    end.

%% 多节点启动
many_init_ets(NodeType) ->
    case NodeType of
        ?MANAGE_TYPE ->
            manage_init_est();
        ?CENTER_TYPE ->
            center_init_est();
        ?GATEWAY_TYPE ->
            gateway_init_ets();
        ?GAME_TYPE ->
            game_init_ets();
        ?FIGHT_TYPE ->
            fight_init_ets();
        ?WHOLE_TYPE ->
            whole_init_ets();
        ?DB_MYSQL_TYPE ->
            db_mysql_init_ets();
        ?LOG_TYPE ->
            log_init_ets();
        ?CHAT_TYPE ->
            chat_init_ets();
        ?ADMIN_TYPE ->
            admin_init_ets();
        ?LOGIN_TYPE ->
            login_init_ets();
        ?POLL_TYPE ->
            poll_init_ets();
        ?DB_MNESIA_TYPE ->
            db_mnesia_init_ets();
        ?WORLD_TYPE ->
            world_init_est();
        ?OFFLINE_TYPE ->
            offline_init_ets();

        _ ->
            ?ERROR("节点类型~w启动ets出错", [NodeType]),
            0
    end.

%% 单节点启动
single_init_ets() ->
    manage_init_est(),
    center_init_est(),
    world_init_est(),
    game_init_ets(),
    offline_init_ets(),
    fight_init_ets(),
    whole_init_ets(),
    login_init_ets(),
    log_init_ets(),
    chat_init_ets(),
    admin_init_ets(),
    gateway_init_ets(),
    db_mysql_init_ets(),
    poll_init_ets(),
    db_mnesia_init_ets(),

    ok.

%% ====================================================================
%% 管理服ets表
%% ====================================================================
manage_init_est() ->
    ets:new(?ETS_APP_NODE_TABLE, [named_table, set, public, {read_concurrency, true}, {keypos, #app_node_info.app_node}]),
    ok.

%% ====================================================================
%% 中央服ets表
%% ====================================================================
center_init_est() ->
    ok.

%% ====================================================================
%% 世界服ets表
%% ====================================================================
world_init_est() ->
    %% ordered_set 中key是有序的, set 中key是无序的
    ok.

%% ====================================================================
%% 游戏服ets表
%% ====================================================================
game_init_ets() ->
    %% ordered_set 中key是有序的, set 中key是无序的
    ets:new(?ETS_ROLE_GROUP_TAB, [named_table, set, public, {read_concurrency, true}, {keypos, #role_group.group_id}]),
    ets:new(?ETS_ROLE_DICT_TAB, [named_table, set, public, {read_concurrency, true}, {keypos, #role_dict.dict_key}]),
    ok.

%% ====================================================================
%% 离线服ets表
%% ====================================================================
offline_init_ets() ->
    ok.

%% ====================================================================
%% 战斗服ets表
%% ====================================================================
fight_init_ets() ->
    ok.

%% ====================================================================
%% 全局服ets表
%% ====================================================================
whole_init_ets() ->
    ets:new(?ETS_WHOLE_TABLE, [named_table, set, public, {read_concurrency, true}, {keypos, #whole_id.id}]),
    ok.

%% ====================================================================
%% 登陆服ets表
%% ====================================================================
login_init_ets() ->
    ok.

%% ====================================================================
%% 日志服ets表
%% ====================================================================
log_init_ets() ->
    ets:new(?ETS_GLOBAL_LOG_TABLE, [named_table, set, public, {read_concurrency, true}, {keypos, #log_global.flag}]),
    ok.

%% ====================================================================
%% 聊天服ets表
%% ====================================================================
chat_init_ets() ->
    ok.

%% ====================================================================
%% 后台管理服ets表
%% ====================================================================
admin_init_ets() ->
    ets:new(?ETS_COL_ROLE_CREATE_TAB, [named_table, set, public, {read_concurrency, true}, {keypos, #col_role_create.player_id}]),
    ets:new(?ETS_COL_ROLE_LOGIN_TAB, [named_table, set, public, {read_concurrency, true}, {keypos, #col_role_login.player_id}]),
    ets:new(?ETS_COL_ROLE_BASE_TAB, [named_table, set, public, {read_concurrency, true}, {keypos, #col_role_base.player_id}]),
    ets:new(?ETS_COL_CHAT_LOG_TAB, [named_table, set, public, {read_concurrency, true}, {keypos, #col_chat_log.chat_key}]),
    ok.

%% ====================================================================
%% 网关服ets表
%% ====================================================================
gateway_init_ets() ->
    ets:new(?ETS_GW_ROLE_ONLINE_TAB, [named_table, set, public, {read_concurrency, true}, {keypos, #gw_role_online.gw_pid}]),
    ok.

%% ====================================================================
%% 数据服ets表
%% ====================================================================
db_mysql_init_ets() ->
    ok.

%% ====================================================================
%% 轮询服ets表
%% ====================================================================
poll_init_ets() ->
    ok.

%% ====================================================================
%% db_mnesia服ets表
%% ====================================================================
db_mnesia_init_ets() ->
    ok.