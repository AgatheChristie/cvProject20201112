%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
%%% @date  2016.8.29
%%% ETS数据库
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(DB_ETS_HRL).
-define(DB_ETS_HRL, true).

%% 玩家分组数据
-define(ETS_ROLE_GROUP_TAB, ets_role_group).
%% 玩家字典数据
-define(ETS_ROLE_DICT_TAB, ets_role_dict).
%% 创角数据收集
-define(ETS_COL_ROLE_CREATE_TAB, ets_col_role_create).
%% 登陆数据收集
-define(ETS_COL_ROLE_LOGIN_TAB, ets_col_role_login).
%% 基础数据收集
-define(ETS_COL_ROLE_BASE_TAB, ets_col_role_base).
%% 聊天日志收集
-define(ETS_COL_CHAT_LOG_TAB, ets_col_chat_log).
%% whole数据
-define(ETS_WHOLE_TABLE, ets_whole).
%% 在线玩家数据
-define(ETS_GW_ROLE_ONLINE_TAB, ets_gw_role_online).
%% 日志id全局ets表
-define(ETS_GLOBAL_LOG_TABLE, ets_global_log).
%% 战斗socket
-define(ETS_FIGHT_SOCKET_TABLE, ets_fight_socket).


-endif. % DB_ETS_HRL
