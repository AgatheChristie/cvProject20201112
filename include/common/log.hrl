%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
%%% @date  2016.08.09
%%% 日志定义
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(LOG_HRL).
-define(LOG_HRL, true).

%% 日志ets表
-define(ETS_LOG_TAB(LogName), util:prefix_n("ets_log", [LogName])).

%% 持久日志时间
-define(DUMP_LOG_TIME, 300).
-define(DUMP_ERROR_LOG_TIME, 10).

%% 各日志版本记录
-define(LOG_INTERFACE_VER, 1).                                          %% 操作界面版本
-define(LOG_LOGIN_ROLE_VER, 1).                                         %% 登陆版本
-define(LOG_LOGOUT_ROLE_VER, 1).                                        %% 退出版本
-define(LOG_CREATE_ROLE_VER, 1).                                        %% 创角版本
-define(LOG_ROLE_LEVEL_VER, 1).                                         %% 玩家等级版本
-define(LOG_ITEM_ADD_VER, 1).                                           %% 增加物品版本
-define(LOG_ITEM_DEL_VER, 1).                                           %% 删除物品版本
-define(LOG_SHOP_BUY_VER, 1).                                           %% 商店购买版本
-define(LOG_CARD_VER, 1).                                               %% 充值卡版本
-define(LOG_ACTIVITY_VER, 1).                                           %% 活动版本
-define(LOG_ONLINE_PEAK_VER, 1).                                        %% 在线人数峰值版本
-define(LOG_CREATE_ACTOR_VER, 1).                                       %% 开启角色栏位版本
-define(LOG_TASK_VER, 1).                                               %% 任务版本
-define(LOG_RANK_VER, 1).                                               %% 排行榜
-define(LOG_RANK_REWARD_VER, 1).                                        %% 排行榜奖励版本
-define(LOG_PLAYER_PAY_VER, 1).                                         %% 充值日志版本
-define(LOG_MAIL_VER, 1).                                               %% 邮件日志版本
-define(LOG_MAIL_ITEM_VER, 1).                                          %% 邮件道具日志版本
-define(LOG_RENAME_VER, 1).                                             %% 改名版本
-define(LOG_PLAYER_INFO_VER, 1).                                        %% 玩家信息版本
-define(LOG_ADMIN_MAIL_VER, 1).                                         %% 后台邮件版本
-define(LOG_MONEY_ADD_VER, 1).                                          %% 货币版本
-define(LOG_MONEY_DEL_VER, 1).                                          %% 货币版本
-define(LOG_BUY_TIMES_VER, 1).                                          %% 玩法购买次数版本
-define(LOG_PLAY_MIX_VER, 1).                                           %% 杂项玩法版本
-define(LOG_PLAY_TIMES_VER, 1).                                         %% 玩法次数版本
-define(LOG_ICON_OPEN_VER, 1).                                          %% 图标版本
-define(LOG_FIGHT_POWER_VER, 1).                                        %% 战力日志版本
-define(LOG_ROLE_CONTENT_VER, 1).                                       %% 玩家内容(聊天、自定义信息)版本
-define(LOG_PANEL_CLICK_VER, 1).                                        %% 面板点击版本
-define(LOG_GUILD_VER, 1).                                              %% 国家创建版本
-define(LOG_CAMP_POS_INFO_VER, 1).                                      %% 国家职位变更版本
-define(LOG_FB_CHALLENGE_VER, 1).                                       %% 副本挑战版本
-define(LOG_CAMP_OUTPUT_VER, 1).                                        %% 国家产量版本
-define(LOG_ATTACK_CITY_VER, 1).                                        %% 城池攻城版本
-define(LOG_CAMP_SCIENCE_VER, 1).                                       %% 国家科技版本
-define(LOG_CAMP_SCIENCE_SUPPORT_VER, 1).                               %% 国家支援版本
-define(LOG_TREND_VER, 1).                                              %% 天下大势版本
-define(LOG_POWER_VALUE_VER, 1).                                        %% 实力版本
-define(LOG_TEAM_ORDER_VER, 1).                                         %% 队伍指令版本
-define(LOG_TEAM_STATUS_VER, 1).                                        %% 队伍状态版本
-define(LOG_GAME_WIN_AWARD_VER, 1).                                     %% 赛季结算玩家获奖版本

%% 各日志收集宏
-define(LOG_ERROR_MSG, log_error_msg).

%% 已处理放入数据库日志
-define(LOG_INTERFACE, log_interface).                                  %% 操作界面(登陆界面/创角界面/欢迎界面)
-define(LOG_LOGIN_ROLE, log_login_role).                                %% 登录日志
-define(LOG_LOGOUT_ROLE, log_logout_role).                              %% 登出日志
-define(LOG_CREATE_ROLE, log_create_role).                              %% 创角日志
-define(LOG_ROLE_LEVEL, log_role_level).                                %% 等级日志
-define(LOG_ITEM_ADD, log_item_add).                                    %% 物品日志
-define(LOG_ITEM_DEL, log_item_del).                                    %% 物品日志
-define(LOG_SHOP_BUY, log_shop_buy).                                    %% 商店购买日志(只记录金币跟元宝两类购买)
-define(LOG_CARD, log_card).                                            %% 充值卡日志
-define(LOG_ACTIVITY, log_activity).                                    %% 活动日志
-define(LOG_ONLINE_PEAK, log_online_peak).                              %% 在线人数日志(每分钟记录一次)
-define(LOG_CREATE_ACTOR, log_create_actor).                            %% 开启角色栏位日志
-define(LOG_TASK, log_task).                                            %% 任务日志
-define(LOG_RANK, log_rank).                                            %% 排行榜
-define(LOG_RANK_REWARD, log_rank_reward).                              %% 排行榜奖励日志
-define(LOG_PLAYER_PAY, log_player_pay).                                %% 充值日志
-define(LOG_MAIL, log_mail).                                            %% 邮件日志
-define(LOG_MAIL_ITEM, log_mail_item).                                  %% 邮件道具日志
-define(LOG_RENAME, log_rename).                                        %% 改名日志
-define(LOG_PLAYER_INFO, log_player_info).                              %% 玩家信息
-define(LOG_ADMIN_MAIL, log_admin_mail).                                %% 后台邮件日志
-define(LOG_MONEY_ADD, log_money_add).                                  %% 货币日志
-define(LOG_MONEY_DEL, log_money_del).                                  %% 货币日志
-define(LOG_BUY_TIMES, log_buy_times).                                  %% 玩法购买次数
-define(LOG_PLAY_MIX, log_play_mix).                                    %% 杂项玩法
-define(LOG_PLAY_TIMES, log_play_times).                                %% 玩法次数
-define(LOG_ICON_OPEN, log_icon_open).                                  %% 图标开放
-define(LOG_FIGHT_POWER, log_fight_power).                              %% 战力日志
-define(LOG_ROLE_CONTENT, log_role_content).                            %% 玩家内容(聊天、自定义信息)
-define(LOG_PANEL_CLICK, log_panel_click).                              %% 面板点击日志
-define(LOG_GUILD, log_guild).                                          %% 国家创建日志
-define(LOG_CAMP_POS_INFO, log_camp_pos_info).                          %% 国家职位变更日志
-define(LOG_FB_CHALLENGE, log_fb_challenge).                            %% 副本挑战日志
-define(LOG_CAMP_OUTPUT, log_camp_output).                              %% 国家产量
-define(LOG_ATTACK_CITY, log_attack_city).                              %% 城池攻城
-define(LOG_CAMP_SCIENCE, log_camp_science).                            %% 国家科技
-define(LOG_CAMP_SCIENCE_SUPPORT, log_camp_science_support).            %% 国家科技支援
-define(LOG_TREND, log_trend).                                          %% 天下大势
-define(LOG_POWER_VALUE, log_power_value).                              %% 实力
-define(LOG_TEAM_ORDER, log_team_order).                                %% 队伍指令
-define(LOG_TEAM_STATUS, log_team_status).                              %% 队伍状态
-define(LOG_GAME_WIN_AWARD, log_game_win_award).                        %% 赛季结算玩家获奖

%% 日志进程列表
-define(LOG_NAME_LIST,
    [
        ?LOG_ONLINE_PEAK
        , ?LOG_CREATE_ROLE
        , ?LOG_LOGIN_ROLE
        , ?LOG_LOGOUT_ROLE
        , ?LOG_ITEM_ADD
        , ?LOG_ITEM_DEL
        , ?LOG_INTERFACE
        , ?LOG_ROLE_LEVEL
        , ?LOG_SHOP_BUY
        , ?LOG_CARD
        , ?LOG_ACTIVITY
        , ?LOG_CREATE_ACTOR
        , ?LOG_TASK
        , ?LOG_RANK
        , ?LOG_RANK_REWARD
        , ?LOG_PLAYER_PAY
        , ?LOG_MAIL
        , ?LOG_RENAME
        , ?LOG_PLAYER_INFO
        , ?LOG_ADMIN_MAIL
        , ?LOG_MONEY_ADD
        , ?LOG_MONEY_DEL
        , ?LOG_BUY_TIMES
        , ?LOG_PLAY_MIX
        , ?LOG_PLAY_TIMES
        , ?LOG_ICON_OPEN
        , ?LOG_FIGHT_POWER
        , ?LOG_ROLE_CONTENT
        , ?LOG_PANEL_CLICK
        , ?LOG_ATTACK_CITY
        , ?LOG_CAMP_OUTPUT
        , ?LOG_CAMP_SCIENCE
        , ?LOG_CAMP_SCIENCE_SUPPORT
        , ?LOG_POWER_VALUE
        , ?LOG_TREND
        , ?LOG_FB_CHALLENGE
        , ?LOG_TEAM_ORDER
        , ?LOG_CAMP_POS_INFO
        , ?LOG_TEAM_STATUS
        , ?LOG_GAME_WIN_AWARD
    ]
).

-define(LOG_ERROR_LIST,
    [
        ?LOG_ERROR_MSG
    ]).

%% 收集到中央服的日志
-define(LOG_CENTER_LIST,
    [
    ]).


%% error报错文件名
-define(COMMON_ERROR_FILE, common_error).                              %% error报错文件名
-define(COMMON_ERROR_TEST_FILE, common_error_test).                    %% error报错测试文件名
%% sasl文件名
-define(COMMON_SASL_FILE, common_sasl).                                %% sasl报错文件名

%% 日志全局变量
-record(log_global, {
    flag = "",                                                         %% 全局标志
    value = 0                                                          %% 全局数值
}).

%% 日志
-record(log_info, {
    id = 0,
    content = []
}).

-endif.
