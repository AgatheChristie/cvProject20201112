%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
%%% @date  2016.8.29
%%% 玩家分组信息
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(ROLE_GROUP_HRL).
-define(ROLE_GROUP_HRL, true).

%% 初始启动的分组进程
-define(ROLE_GROUP_PROCESS, 2).                                             %% 初始启动的分线

%% 分组是否已满
-define(ROLE_GROUP_NOT_FULL, 0).                                            %% 未满人
-define(ROLE_GROUP_IS_FULL, 1).                                             %% 已满人

%% 处理消息标识
-define(RGM_DEAL_MSG, rgm_deal_msg).                                        %% 发送到玩家组管理
-define(RG_DEAL_MSG, rg_deal_msg).                                          %% 发送到玩家组

%% 分类消息体
-define(RG_ADD_PUBLIC_MAIL, add_public_mail).                               %% 增加公共邮件
-define(RG_WORLD_CHAT, world_chat).                                         %% 世界聊天广播
-define(RG_ACTIVITY_CHANGE, activity_change).                               %% 活动变化
-define(RG_ACTIVITY_TERM_CHANGE, activity_term_change).                     %% 活动子项变化
-define(RG_ICON_UPDATE, icon_update).                                       %% 图标更新
-define(RG_DELETE_CHAT, delete_chat).                                       %% 删除聊天记录

%% 玩家分组
-record(role_group, {
    group_id = 0,                                                           %% 分组id
    is_full = 0,                                                            %% 分组是否已满
    role_count = 0,                                                         %% 玩家数量
    role_ids = []                                                           %% 玩家列表
}).


-endif. % ROLE_GROUP_HRL
