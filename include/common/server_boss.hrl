%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author
%%% @date
%%%         世界boss定义
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(SERVER_BOSS_HRL).
-define(SERVER_BOSS_HRL, true).

%% 日志定时收集 5分钟一次
-define(SERVER_BOSS_LOG_DIFF, 300).                                       %% 定时日志收集时间

%% 活动玩法状态
-define(SERVER_BOSS_INIT, 1).                                             %% 初始化中
-define(SERVER_BOSS_START, 2).                                            %% 开始
-define(SERVER_BOSS_SUMMARY, 3).                                          %% 结算
-define(SERVER_BOSS_STOP, 4).                                             %% 结束

%% 玩家状态
-define(NOT_IN_SERVER_BOSS, 0).                                           %% 没有进入玩法
-define(IS_IN_SERVER_BOSS, 1).                                            %% 在玩法中
-define(IS_LEAVE_SERVER_BOSS, 2).                                         %% 离开玩法

%% 世界boss信息
-record(server_boss, {
    play_status = 0,                                                      %% 玩法状态
    start_sec = 0,                                                        %% 世界boss开始时间
    end_sec = 0,                                                          %% 世界boss结束时间
    icon_id = 0,                                                          %% 图标id
    scene_id = 0,                                                         %% 场景id
    scene_node = none,                                                    %% 场景节点
    is_common_end = false,                                                %% 进程是否正常结束
    mon_level = 0,                                                        %% 怪物等级
    mon_hp = 0,                                                           %% 怪物当前血量
    kill_id = 0,                                                          %% 最终击杀玩家id
    loop_hurt_sec = 0,                                                    %% 最后一次更新伤害信息时间
    loop_log_sec = 0                                                      %% 下一次记录日志时间
}).

-endif. % SERVER_BOSS_HRL