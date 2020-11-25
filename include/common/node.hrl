%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%%  zhoujunlong
%%%  2011-6-9
%%%  节点相关头文件
%%%
%%%----------------------------------------------------------------------
-ifndef(NODE_HRL).
-define(NODE_HRL, true).

%% 节点类型
-define(MIN_NODE_TYPE, 1).                                              %% 最小值

-define(MANAGE_TYPE, 1).                                                %% 管理节点
-define(CENTER_TYPE, 2).                                                %% 中央管理节点
-define(DB_MNESIA_TYPE, 3).                                             %% mnesia缓存节点
-define(WHOLE_TYPE, 4).                                                 %% 全局管理节点
-define(DB_MYSQL_TYPE, 5).                                              %% mysql数据节点
-define(LOG_TYPE, 6).                                                   %% 日志节点
-define(OFFLINE_TYPE, 7).                                               %% 离线节点
-define(GAME_TYPE, 8).                                                  %% 游戏节点
-define(FIGHT_TYPE, 9).                                                 %% 战斗节点
-define(ADMIN_TYPE, 10).                                                %% 后台节点
-define(CHAT_TYPE, 11).                                                 %% 聊天节点
-define(GATEWAY_TYPE, 12).                                              %% 网关节点
-define(LOGIN_TYPE, 13).                                                %% 登陆节点
-define(WORLD_TYPE, 14).                                                %% 世界节点
-define(POLL_TYPE, 15).                                                 %% 轮询节点
-define(CROSS_TYPE, 16).                                                %% 跨服节点

-define(MAX_NODE_TYPE, 16).                                             %% 最大值


%% 本节点是否连通管理节点
-define(NOT_PONG_NODE, 0).                                              %% 没有连通
-define(IS_PONG_NODE, 1).                                               %% 有连通

%% 节点是否开启
-define(NODE_NOT_OPEN, 0).                                              %% 未开启
-define(NODE_IS_OPEN, 1).                                               %% 开启

%% 分线是否满人
-define(CUR_NOT_FULL, 0).                                               %% 未满
-define(CUR_IS_FULL, 1).                                                %% 已满

%% 节点人数
-record(node_count, {
    node = none,                                                        %% 节点名
    node_type = 0,                                                      %% 节点类型
    node_count = 0                                                      %% 人数
}).

-endif.