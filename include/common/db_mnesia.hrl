%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author zhanglei
%%% @date  2016.8.29
%%% mnesia数据库
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(DB_MNESIA_HRL).
-define(DB_MNESIA_HRL, true).

%% mnesia的表定义
%% {disc_copies, NodeList}  磁盘 + 内存
%% {ram_copies, NodeList}   内存
%% {disc_only_copies}   磁盘

%% 内存表
-define(RAM_TABLE(Type, Rec),
    [
        {ram_copies, [node()]},
        {type, Type},
        {record_name, Rec},
        {attributes, record_info(fields, Rec)}
    ]).

%% 内存加磁盘表
-define(DISK_TABLE(Type, Rec),
    [
        {disc_copies, [node()]},
        {type, Type},
        {record_name, Rec},
        {attributes, record_info(fields, Rec)}
    ]).

%% 磁盘表
-define(DISK_ONLY_TABLE(Type, Rec),
    [
        {disc_only_copies, [node()]},
        {type, Type},
        {record_name, Rec},
        {attributes, record_info(fields, Rec)}
    ]).

%% mnesia的表定义
%% 基础动态扩展
-define(DB_NODE_M(NodType), util:prefix_n("m_db_node", [NodType])).
-define(DB_LINE_M(NodType), util:prefix_n("m_db_line", [NodType])).
-define(DB_ROLE_BASE_M(TabType), util:prefix_n("m_db_role_base", [TabType])).
-define(DB_ROLE_GAME_M(TabType), util:prefix_n("m_db_role_game", [TabType])).
-define(DB_ROLE_GATEWAY_M(TabType), util:prefix_n("m_db_role_gateway", [TabType])).
-define(DB_ROLE_FIGHT_M(TabType), util:prefix_n("m_db_role_fight", [TabType])).
-define(DB_ROLE_OFFLINE_M(TabType), util:prefix_n("m_db_role_offline", [TabType])).
-define(DB_ROLE_DETAIL_M(TabType), util:prefix_n("m_db_role_detail", [TabType])).
-define(DB_ROLE_COLLECT_M(TabType), util:prefix_n("m_db_role_collect", [TabType])).
-define(DB_DUMMY_M(TabType), util:prefix_n("m_db_dummy", [TabType])).
-define(DB_DUMMY_DETAIL_M(TabType), util:prefix_n("m_db_dummy_detail", [TabType])).
-define(DB_RANK_INFO_M(RankType), util:prefix_n("m_db_rank_info", [RankType])).
-define(DB_SNAPSHOT_M(SnapshotType), util:prefix_n("m_db_snapshot", [SnapshotType])).

%% 功能动态扩展
-define(DB_ARENA_MATCH_M(GroupId), util:prefix_n("m_db_arena_match", [GroupId])).

%% 基础固定表
-define(DB_SENSITIVE_KEY_M, m_db_sensitive_key).
-define(DB_RANK_M, m_db_rank).
-define(DB_ICON_M, m_db_icon).
-define(DB_PUBLIC_MAIL_M, m_db_public_mail).
-define(DB_WORLD_CHAT_M, m_db_world_chat).
-define(DB_HANGHUI_M, m_db_hanghui).
-define(DB_PUBLIC_PLAY_M, m_db_public_play).
-define(DB_ROLE_NAME_USED_M, m_db_role_name_used).
-define(DB_DUMMY_SELECT_M, m_db_dummy_select).
-define(DB_DUMMY_GROW_M, m_db_dummy_grow).
-define(DB_CROSS_M, m_db_cross).
-define(DB_TEAM_M, m_db_team).
-define(DB_BAN_M, m_ban).
-define(DB_RUN_LIGHT_M, m_db_run_light).
-define(DB_ACTIVITY_M, m_db_activity).
-define(DB_ACTIVITY_GROUP_M, m_db_activity_group).
-define(DB_ACTIVITY_MIX_M, m_db_activity_mix).
-define(DB_PLAY_REFRESH_M, m_db_play_refresh).
-define(DB_MERGE_SERVER_M, m_db_merge_server).
-define(DB_ACTIVE_CHAT_M, m_db_active_chat).

%% 功能固定表
-define(DB_MARKET_M, m_db_market).
-define(DB_MARKET_ROLE_M, m_db_market_role).
-define(DB_AUCTION_M, m_db_auction).
-define(DB_KINGDOM_PLAYER_M, m_db_kingdom_player).
-define(DB_FB_SCENE_M, m_db_fb_scene).
-define(DB_HANGHUI_WAR_M, m_db_hanghui_war).
-define(DB_HANGHUI_WAR_PLAYER_M, m_db_hanghui_war_player).
-define(DB_SERVER_BOSS_PLAYER_M, m_db_server_player).
-define(DB_ANCIENT_M, m_db_ancient).
-define(DB_BOSS_HP_M, m_db_boss_hp).
-define(DB_DARK_TEMPLE_M, m_db_dark_temple).
-define(DB_DARK_TEMPLE_SCENE_M, m_db_dark_temple_scene).
-define(DB_MINE_HOLE_M, m_db_mine_hole).
-define(DB_CONVOY_PLAYER_M, m_db_convoy_player).
-define(DB_NEARBY_MATCH_M, m_db_nearby_match).
-define(DB_WARCRAFT_PLAYER_M, m_db_warcraft_player).
-define(DB_WARCRAFT_HANGHUI_M, m_db_warcraft_hanghui).
-define(DB_DARK_SHRINE_SCENE_M, m_db_dark_shrine_scene).
-define(DB_DARK_SHRINE_FIGHT_M, m_db_dark_shrine_fight).
-define(DB_DARK_SHRINE_FIGHT_SCENE_M, m_db_dark_shrine_fight_scene).
-define(DB_ETERNAL_TOWER_M, m_db_eternal_tower).
-define(DB_HANGHUI_CROSS_WAR_M, m_db_hanghui_cross_war).
-define(DB_HANGHUI_CROSS_WAR_PLAYER_M, m_db_hanghui_cross_war_player).

%% 玩家表分表
-define(M_MAX_BASE_TAB, 1).                                              %% 玩家基础缓存表
-define(M_MAX_GAME_TAB, 1).                                              %% 玩家game缓存表
-define(M_MAX_GATEWAY_TAB, 1).                                           %% 玩家gateway缓存表
-define(M_MAX_FIGHT_TAB, 1).                                             %% 玩家fight缓存表
-define(M_MAX_OFFLINE_TAB, 1).                                           %% 玩家离线缓存表
-define(M_MAX_DETAIL_TAB, 1).                                            %% 玩家详细缓存表
-define(M_MAX_COLLECT_TAB, 1).                                           %% 玩家简单收集表
-define(M_MAX_DUMMY_TAB, 1).                                             %% 假人缓存表
-define(M_MAX_DUMMY_DETAIL_TAB, 1).                                      %% 假人详细缓存表
-define(M_MAX_OFFLINE_MSG_TAB, 1).                                       %% 离线玩家消息表

%% mnesia的表record定义
%% mnesia节点表
-record(node_m, {
    node_key = {none, 0},                                                %% 节点主键 {节点名, self_type}
    node = none,                                                         %% 节点名
    master_node = none,                                                  %% master节点
    server_only_id = 0,                                                  %% 服唯一id
    node_type = 0,                                                       %% 节点类型
    self_type = 0,                                                       %% 节点自定义类型
    cross_node_type = 0,                                                 %% 跨服节点类型
    node_ip = 0,                                                         %% 节点ip
    is_pong = 0,                                                         %% 是否连通
    is_full = 0,                                                         %% 是否满人
    is_open = 0,                                                         %% 是否开启
    cur_num = 0,                                                         %% 当前人数
    max_num = 0                                                          %% 最大人数
}).

%% 分线
-record(line_m, {
    line_id = 0,                                                         %% 分线id
    node = none,                                                         %% 节点名
    node_type = 0,                                                       %% 节点类型
    line_type = 0,                                                       %% 分线类型
    line_port = 0,                                                       %% 分线端口
    line_ip = 0,                                                         %% 内网分线ip
    extranet_line_ip = 0,                                                %% 外网分线ip
    is_full = 0,                                                         %% 是否满人
    is_open = 0,                                                         %% 是否开启
    role_ids = [],                                                       %% 玩家列表
    cur_num = 0,                                                         %% 当前人数
    max_num = 0                                                          %% 最大人数
}).

%% mnesia玩家base表
-record(role_base_m, {
    role_id = 0,                                                         %% 玩家id
    assign_game_node = none,                                             %% 分配的游戏节点
    assign_gateway_node = none,                                          %% 分配的网关节点
    login_node = none,                                                   %% 登陆节点
    m_login_sec = 0,                                                     %% 登陆时间(创角时不为0,登陆网关后为0)
    m_logout_sec = 0                                                     %% 退出时间(玩家进程退出时不为0,其他时候都为0)
}).

%% mnesia玩家game表
-record(role_gateway_m, {
    role_id = 0,                                                         %% 玩家id
    gateway_node = none                                                  %% 网关节点
}).

%% mnesia玩家game表
-record(role_game_m, {
    role_id = 0,                                                         %% 玩家id
    role_status = 0,                                                     %% 玩家状态
    game_node = none                                                     %% 游戏节点
}).

%% mnesia玩家fight表
-record(role_fight_m, {
    role_id = 0,                                                         %% 玩家id
    fight_node = none                                                    %% 战斗节点
}).

%% mnesia玩家detail表
-record(role_detail_m, {
    role_id = 0,                                                         %% 玩家id
    server_only_ids = [],                                                %% 服务器唯一id列表
    role_name = <<"">>,                                                  %% 玩家名
    acc_name = <<"">>,                                                   %% 帐号
    team_info = none,                                                    %% 队伍信息
    single_server_id = 0,                                                %% 创角时的服务器平台id
    scene_info = none,                                                   %% 当前场景信息
    hanghui_id = 0,                                                      %% 行会id
    hanghui_name = <<"">>,                                               %% 行会名
    dummy_grow_id = 0,                                                   %% 假人成长id
    role_status = 0,                                                     %% 玩家状态
    login_sec = 0,                                                       %% 上线时间
    logout_sec = 0,                                                      %% 下线时间
    login_ip = <<"">>,                                                   %% 登录ip
    vip_level = 0,                                                       %% vip等级
    svip_level = 0,                                                      %% svip等级
    touxian_level = 0,                                                   %% 头衔等级
    fight_actors = [],                                                   %% fight_actor
    pets = [],                                                           %% 宠物
    partners = [],                                                       %% 伙伴
    chat_dress_ids = [],                                                 %% 个性聊天
    arena_group_id = 0,                                                  %% 竞技场段位
    arena_win_times = 0,                                                 %% 竞技场胜利次数
    arena_total_times = 0                                                %% 竞技场总次数
}).

%% mnesia玩家collect表
%% 分离出来是为了避免脏操作影响到额外的数据,只有统计数据有脏操作影响不大
-record(role_collect_m, {
    role_id = 0,                                                         %% 玩家id
    start_sec = 0,                                                       %% 开始时间
    active_sec = 0,                                                      %% 活跃时间
    active_times = 0                                                     %% 活跃次数
}).

%% 假人表
-record(dummy_m, {
    dummy_only_id = 0,                                                   %% 假人唯一id
    dummy_name = <<>>,                                                   %% 假人名
    dummy_id = 0,                                                        %% 假人id
    team_info = none,                                                    %% 队伍信息
    scene_node = none,                                                   %% 场景节点
    scene_key = {0, 0},                                                  %% 场景key
    dummy_status = 0                                                     %% 假人状态
}).


-record(dummy_detail_m, {
    dummy_id = 0,                                                        %% 假人id
    select_id = 0,                                                       %% 假人库id
    role_id = 0,                                                         %% 玩家id
    role_name = <<>>,                                                    %% 玩家名
    team_info = none,                                                    %% 队伍信息
    hanghui_id = 0,                                                      %% 行会id
    hanghui_name = <<>>,                                                 %% 行会名
    vip_level = 0,                                                       %% vip等级
    touxian_level = 0,                                                   %% 头衔等级
    pets = [],                                                           %% 宠物
    dummy_actors = []                                                    %% 角色战斗信息
}).


-record(sensitive_key_m, {
    key = 0,                                                             %% 敏感字主键hash值
    key_flag = 0
}).


-record(rank_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    rank_type = 0,                                                       %% 榜单类型
    start_sec = 0,                                                       %% 结束时间
    end_sec = 0,                                                         %% 开始时间
    award_sec = 0,                                                       %% 发奖时间
    rank_status = 0,                                                     %% 榜单状态
    is_award = 0,                                                        %% 榜单是否已经发奖 0没有 1有
    is_clear = 0,                                                        %% 榜单是否已经清空 0没有 1有
    is_change = 0,                                                       %% 榜单是否有变动 0没有 1有
    is_merge_collect = 0                                                 %% 榜单是否合服后重新收集 0没有 1有
}).


-record(rank_info_m, {
    rank_key = {0, 0},                                                   %% 主键({rank_type,self_id})
    self_id = 0,                                                         %% 自定义id(玩家id)
    rank_sec = 0,                                                        %% 上榜时间
    rank_id = 0,                                                         %% 榜单排名id
    rank_value_1 = 0,                                                    %% 第1个排行榜值
    rank_value_2 = 0,                                                    %% 第2个排行榜值
    rank_value_3 = 0,                                                    %% 第3个排行榜值
    now_rank_value_1 = 0,                                                %% 当前第1个排行榜值
    now_rank_value_2 = 0,                                                %% 当前第2个排行榜值
    now_rank_value_3 = 0                                                 %% 当前第3个排行榜值
}).


-record(icon_m, {
    icon_id = 0,                                                         %% 图标id
    icon_status = 0,                                                     %% 图标状态
    start_sec = 0,                                                       %% 开始时间
    advance_end_sec = 0,                                                 %% 提前结束时间
    end_sec = 0,                                                         %% 结束时间
    advance_sec = 0,                                                     %% 提前通知时间
    is_notice = 0                                                        %% 是否已提前通知在线玩家
}).


-record(public_mail_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    template_id = 0,                                                     %% 模板id
    title = <<>>,                                                        %% 标题
    content = <<>>,                                                      %% 内容
    conditions = [],                                                     %% 邮件条件
    items = [],                                                          %% 道具列表
    log_type = 0,                                                        %% 日志类型
    type = 0,                                                            %% 全服邮件 0:全服 1:多人
    mail_type = 0,                                                       %% 邮件类型
    role_ids = [],                                                       %% 玩家列表
    send_sec = 0                                                         %% 发送时间
}).


-record(world_chat_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    chat_type = 0,                                                       %% 聊天类型
    role_id = 0,                                                         %% 玩家id
    is_light = 0,                                                        %% 是否跑马灯 0否 1是
    chat_sec = 0,                                                        %% 世界聊天时间
    chat_parts = [],                                                     %% 聊天模板信息
    is_admin = 0                                                         %% 是否后台发送 0否 1是
}).

-record(world_chat_part_m, {
    type = 0,                                                            %% 类型
    content = <<>>,                                                      %% 内容
    int_values = [],                                                     %% 整形参数列表
    string_values = [],                                                  %% 字符串参数列表
    template_id = 0                                                      %% 模板id
}).


-record(hanghui_m, {
    id = 0,                                                              %% 行会id
    version = 0,                                                         %% 版本
    server_only_ids = [],                                                %% 服务器唯一id列表
    name = <<"">>,                                                       %% 行会名字
    icon_id = 1,                                                         %% 行会图标Id
    pid,                                                                 %% 行会进程pid
    level = 0,                                                           %% 行会等级
    builds = [],                                                         %% 行会建筑
    scene_key = {0, 0},                                                  %% 场景key
    scene_node = none,                                                   %% 场景节点
    create_sec = 0,                                                      %% 创建时间
    notice_board = <<"">>,                                               %% 行会公告
    leader_id = 0,                                                       %% 会长角色id
    members = [],                                                        %% 成员列表
    member_num = 0,                                                      %% 当前成员数量
    total_member_num = 0,                                                %% 当前最多成员数量
    join_type = 0,                                                       %% 设置加入类型 0:手动同意 1：自动
    join_conditions = [],                                                %% 设置加入条件限制
    hanghui_applys = [],                                                 %% 申请列表
    hanghui_logs = [],                                                   %% 行会日志
    hanghui_chats = [],                                                  %% 行会聊天
    assets = 0,                                                          %% 行会资金
    total_score = 0,                                                     %% 公会总评分
    hanghui_scenes = [],                                                 %% 行会场景
    mail_sec = 0,                                                        %% 上次发送行会邮件时间戳
    convene_sec = 0,                                                     %% 行会战召集使用时间
    filter_help_sec = 0,                                                 %% 过滤过期行会货运求助信息
    help_id = 1,                                                         %% 行会货运求助自增ID
    freight_helps = [],                                                  %% 行会货运求助信息列表
    aid_id = 1,                                                          %% 协助自增ID
    aid_infos = [],                                                      %% 协助信息列表
    hanghui_beast = none,                                                %% 行会神兽信息
    hanghui_question = none,                                             %% 行会答题信息
    hanghui_transmits = [],                                              %% 行会传功信息列表
    is_enroll = 0,                                                       %% 是否已报名跨服公会战 0否1是
    cross_war_advance_sec = 0                                            %% 跨服行会战提前广播开启
}).


-record(public_play_m, {
    config_id = 0,                                                       %% 配置表
    version = 0,
    int_values = [],                                                     %% 整形信息列表
    string_values = []                                                   %% 字符串信息列表
}).


-record(play_refresh_m, {
    play_key = {0, 0},                                                   %% 配置表
    scene_id = 0,                                                        %% 场景id
    term_id = 0,                                                         %% 子项id
    scene_keys = []
}).


-record(merge_server_m, {
    server_id = 0,                                                       %% 服务器id
    merge_server_id = 0
}).


-record(role_name_used_m, {
    id = 0,                                                              %% 玩家id
    version = 0,                                                         %% 数据版本号
    name = <<"">>,                                                       %% 曾用名
    new_name = <<"">>,                                                   %% 新名字
    change_sec = 0                                                       %% 修改名字时间
}).


-record(dummy_select_m, {
    select_id = 0,                                                       %% 假人选择id
    dummy_ids = []                                                       %% 假人列表
}).


-record(dummy_grow_m, {
    role_id = 0,                                                         %% 玩家id
    grow_id = 0,                                                         %% 成长id
    rename_sec = 0,                                                      %% 下次改名时间
    grow_sec = 0,                                                        %% 下次成长时间
    rank_type = 0,                                                       %% 排行榜id
    min_rank_id = 0,                                                     %% 最高排名
    max_rank_id = 0                                                      %% 最低排名
}).


-record(cross_m, {
    server_id = 0,                                                       %% 游戏服唯一id
    server_ip = "",                                                      %% 游戏服务器ip
    cross_type = 0,                                                      %% 跨服服务器类型,读配置表cross_type.xls
    cross_server_id = 0,                                                 %% 跨服服务器id
    cross_server_name = 0,                                               %% 跨服服务器名
    cross_server_ip = "",                                                %% 跨服服务器ip
    pang_times = 0,                                                      %% 掉线次数
    is_pong = 0,                                                         %% 是否连通
    server_node = 0                                                      %% 游戏服节点信息
}).


-record(team_m, {
    team_id = 0,                                                         %% 队伍id
    group_id = 0,                                                        %% 组id
    target_id = 0,                                                       %% 目标id
    server_only_ids = [],                                                %% 服务器唯一id列表
    is_auto_agree = 0,                                                   %% 是否自动同意 0：否 1：是
    need_power = 0,                                                      %% 需要战力
    prepare_scene_id = 0,                                                %% 准备进入的场景id
    prepare_arvg_ids = [],                                               %% 准备参数信息
    prepare_end_sec = 0,                                                 %% 准备结束时间
    prepare_force_sec = 0,                                               %% 强制操作时间
    leader_id = 0,                                                       %% 队长玩家id
    create_sec = 0,                                                      %% 创建时间
    team_members = [],                                                   %% 队员信息列表
    apply_ids = [],                                                      %% 请求加入队伍玩家列表
    invite_ids = [],                                                     %% 邀请加入队伍玩家id
    chat_id = 0,                                                         %% 队伍聊天id
    team_chats = []                                                      %% 聊天内容
}).


-record(ban_m, {
    id = 0,                                                              %% 唯一id
    role_id = 0,                                                         %% 角色id
    type = 0,                                                            %% 封禁类型
    start_sec = 0,                                                       %% 封禁开始时间
    end_sec = 0                                                          %% 封禁结束时间
}).


-record(run_light_m, {
    id = 0,                                                              %% 唯一id
    is_loop = 0,                                                         %% 是否循环播放
    priority_id = 0,                                                     %% 优先级id
    is_start = 0,                                                        %% 是否启动
    interval_sec = 0,                                                    %% 间隔时间
    content = <<"">>,                                                    %% 内容
    max_run_times = 0,                                                   %% 最大执行次数
    run_times = 0,                                                       %% 执行次数
    run_status = 0,                                                      %% 执行状态
    start_sec = 0,                                                       %% 开始时间
    end_sec = 0                                                          %% 结束时间
}).

%% 活动
-record(activity_m, {
    id = 0,                                                              %% 活动id
    group_id = 0,                                                        %% 活动组id
    group_icon = <<"">>,                                                 %% 活动组图标
    name = <<"">>,                                                       %% 活动名
    icon = <<"">>,                                                       %% 活动图标
    head_icon = <<"">>,                                                  %% 活动头图标
    type = 0,                                                            %% 活动类型
    data_type = 1,                                                       %% 数据类型(1:配置表,2:后台配置)
    terms = [],                                                          %% 活动子项信息列表
    is_open = 0,                                                         %% 是否开启(0:否,1:是)
    start_sec = 0,                                                       %% 开始时间
    end_sec = 0,                                                         %% 结束时间
    daily_reset = 0,                                                     %% 是否每日重置(0否1是)
    delay_sec = 0,                                                       %% 活动结束后延迟关闭时间
    desc = <<"">>,                                                       %% 活动描述
    end_condition = 0,                                                   %% 活动总开关结束条件
    init_condition = 0                                                   %% 初始化条件
}).

%% 活动组
-record(activity_group_m, {
    group_id = 0,                                                        %% 活动组id
    group_icon = <<"">>                                                  %% 活动组图标
}).


-record(arena_match_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    is_change = 0,                                                       %% 是否变动
    group_id = 0,                                                        %% 段位id
    win_rate = 0,                                                        %% 胜率
    match_ids = []                                                       %% 之前匹配的玩家列表
}).


-record(market_m, {
    id = 0,                                                              %% 自增id
    role_id = 0,                                                         %% 角色id
    pos = 0,                                                             %% 角色出售栏位
    item_id = 0,                                                         %% 道具id
    item_num = 0,                                                        %% 道具数量
    item_type = 0,                                                       %% 道具类型
    price_variety = 0,                                                   %% 价格变化百分比
    book_ids = [],                                                       %% 预订角色id列表
    is_broadcast = 0,                                                    %% 是否广播过 0否1是
    shelf_sec = 0,                                                       %% 上架时间
    show_sec = 0,                                                        %% 公示时间
    end_sec = 0                                                          %% 下架时间
}).


-record(market_role_m, {
    role_id = 0,                                                         %% 角色id
    version = 0,                                                         %% 版本号
    sell_items = [],                                                     %% 出售道具
    book_items = [],                                                     %% 预订道具
    market_logs = [],                                                    %% 日志
    is_save = 0                                                          %% 是否需要保存 0否1是
}).


-record(auction_m, {
    id = 0,                                                              %% 唯一id
    version = 0,                                                         %% 版本号
    type = 0,                                                            %% 拍卖类型:1全服2行会
    hanghui_id = 0,                                                      %% 行会id
    item_id = 0,                                                         %% 拍卖道具id
    item_num = 0,                                                        %% 拍卖道具数量
    cur_price = 0,                                                       %% 当前竞价价格
    role_id = 0,                                                         %% 当前竞价者id
    beneficiarys = [],                                                   %% 受益者ID列表
    auction_ids = [],                                                    %% 竞拍者ID列表
    end_sec = 0,                                                         %% 拍卖结束时间
    play_id = 0,                                                         %% 玩法id
    show_sec = 0,                                                        %% 公示结束时间
    broadcast_sec = 0,                                                   %% 广播时间
    is_broadcast = 0,                                                    %% 是否已广播
    sell_role_id = 0,                                                    %% 出售者id
    auction_sec = 0                                                      %% 道具允许拍卖时间
}).


-record(kingdom_player_m, {
    id = 0,                                                              %% 玩家id
    version = 0,                                                         %% 版本号
    player_status = 0,                                                   %% 玩家状态
    player_events = []                                                   %% 王国事件信息
}).


-record(fb_scene_m, {
    fb_key = {0, 0},                                                     %% 主键 {scene_id, team_id}
    scene_id = 0,                                                        %% 场景id
    true_team_id = 0,                                                    %% 真实队伍id
    fb_id = 0,
    role_id = 0,                                                         %% 玩家id
    scene_node = none,                                                   %% 场景节点
    scene_key = {0, 0}                                                   %% 场景key
}).


-record(server_boss_player_m, {
    role_id = 0,                                                         %% 玩家id
    player_status = 0,                                                   %% 玩家状态
    total_damage = 0                                                     %% 总伤害
}).


-record(hanghui_war_m, {
    id = 0,                                                              %% 唯一id
    version = 0,                                                         %% 版本号
    round = 0,                                                           %% 轮数
    area_id = 0,                                                         %% 分区id
    is_winner_group = 0,                                                 %% 是否胜者组(0否1是),最终轮才生效
    hanghui_id = 0,                                                      %% 行会ID
    mon_id = 0,                                                          %% 神兽ID
    enemy_hanghui_id = 0,                                                %% 敌对行会ID
    enemy_mon_id = 0,                                                    %% 敌对神兽ID
    win_hanghui_id = 0,                                                  %% 获胜行会ID
    compensate_id = 0,                                                   %% 补偿积分行会ID
    start_sec = 0,                                                       %% 开始时间
    end_sec = 0,                                                         %% 结束时间
    status = 0,                                                          %% 状态(0初始化中1活动中2已结算)
    summary_sec = 0                                                      %% 结算时间
}).

%% 行会战玩家信息
-record(hanghui_war_player_m, {
    role_id = 0,                                                         %% 玩家id
    hanghui_id = 0,                                                      %% 行会ID
    is_leave = 0,                                                        %% 是否离开行会战场景(0否1是)
    kill_num = 0,                                                        %% 击杀数
    collect_num = 0,                                                     %% 采集数
    plunder_num = 0,                                                     %% 掠夺数
    score = 0,                                                           %% 积分
    mon_blood = 0,                                                       %% 神兽血量
    blood_score = 0,                                                     %% 血量转换积分
    batter_num = 0,                                                      %% 连续击杀数
    score_rewards = []                                                   %% 积分阶段奖励ID列表
}).

%% 快照内容
-record(snapshot_m, {
    snapshot_key = {0, 0},                                               %% 主键 {role_id,self_id}
    version = 0,                                                         %% 版本号
    role_id = 0,                                                         %% 玩家id
    self_id = 0,                                                         %% 自定义id
    send_sec = 0,                                                        %% 快照时间
    custom_data = none                                                   %% 自定义数据
}).

%% 远古遗迹
-record(ancient_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    boss_id = 0,                                                         %% boss_id
    group_id = 0,                                                        %% 组id
    revive_sec = 0,                                                      %% 复活时间
    dead_times = 0,                                                      %% 死亡次数
    fight_times = 0,                                                     %% 挑战次数
    max_fight_times = 0                                                  %% 最大挑战次数
}).

%% boss血量信息
-record(boss_hp_m, {
    id = 0,                                                              %% boss_id
    version = 0,                                                         %% 版本号
    scene_sub_type = 0,                                                  %% 场景子类型
    born_sec = 0,                                                        %% 出生时间
    hp = 0,                                                              %% 当前血量
    max_hp = 0,                                                          %% 最大血量上限
    custom_data = none                                                   %% 自定义数据
}).

%% 黑暗神殿信息
-record(dark_temple_m, {
    fb_id = 0,                                                           %% 副本ID
    scene_key = {0, 0},                                                  %% 场景key
    scene_node = none,                                                   %% 场景节点
    scene_id = 0,                                                        %% 场景id
    true_team_id = 0,                                                    %% 真实队伍id
    mon_status = 0,                                                      %% 怪物状态 0活1死亡
    relive_sec = 0                                                       %% 复活时间
}).

%% 黑暗神殿场景信息
-record(dark_temple_scene_m, {
    fb_id = 0,                                                           %% 副本ID
    scene_id = 0,                                                        %% 场景id
    role_infos = [],                                                     %% 参与玩家信息
    req_infos = [],                                                      %% 请求信息
    belong_id = 0,                                                       %% 归属者
    is_summary = 0                                                       %% 是否已结算(0否1是)
}).

%% 矿洞信息
-record(mine_hole_m, {
    id = 0,                                                              %% 矿洞id
    version = 0,                                                         %% 版本号
    is_cross = 0,                                                        %% 是否跨服数据(0否1是)
    mine_members = [],                                                   %% 矿工信息
    mine_helps = [],                                                     %% 矿洞协助信息
    scene_key = {0, 0},                                                  %% 场景key
    scene_node = none,                                                   %% 场景节点
    scene_id = 0,                                                        %% 场景id
    enter_role_ids = []                                                  %% 进入场景玩家id列表
}).

%% 护送信息
-record(convoy_player_m, {
    id = 0,                                                              %% 玩家id
    version = 0,                                                         %% 版本号
    max_only_id = 0,                                                     %% 最大id
    convoy_id = 0,                                                       %% 护送id
    term_status = 0,                                                     %% 护送状态
    is_change = 0,                                                       %% 数据是否有变动
    convoy_details = []                                                  %% 护送信息
}).

%% 附近的人匹配信息
-record(nearby_match_m, {
    id = 0,                                                              %% 玩家等级
    version = 0,                                                         %% 版本号
    is_change = 0,                                                       %% 数据是否有变动
    role_ids = []                                                        %% 玩家id
}).

%% 魔兽入侵玩家信息表
-record(warcraft_player_m, {
    role_id = 0,                                                         %% 玩家id
    player_status = 0,                                                   %% 玩家状态
    hanghui_id = 0,                                                      %% 行会id
    scene_key = {0, 0},                                                  %% 场景key
    scene_node = none,                                                   %% 场景节点
    total_damage = 0,                                                    %% 总伤害
    last_dead_damage = 0,                                                %% 上次死亡时总伤害
    total_points = 0,                                                    %% 总积分
    shield_num = 0,                                                      %% 护盾值
    recovery_times = 0,                                                  %% 护盾已恢复次数
    recovery_sec = 0,                                                    %% 护盾恢复至满值时间
    zero_sec = 0,                                                        %% 护盾清零时间
    snatch_points = 0,                                                   %% 可掠夺玩家积分
    stop_recovery_sec = 0                                                %% 护盾暂停时间已恢复时间
}).

%% 魔兽入侵行会信息表
-record(warcraft_hanghui_m, {
    hanghui_id = 0,                                                      %% 行会id
    total_points = 0,                                                    %% 总积分
    role_ids = [],                                                       %% 玩家列表
    members = 0                                                          %% 参与人数
}).

%% 新黑暗神殿各层场景信息
-record(dark_shrine_scene_m, {
    scene_id = 0,                                                        %% 场景id
    scene_key = {0, 0},                                                  %% 场景key
    scene_node = none,                                                   %% 场景节点
    biology_num = 0,                                                     %% 黑暗生物剩余数量
    treasure_num = 0,                                                    %% 黑暗宝藏剩余数量
    orb_num = 0                                                          %% 黑暗宝珠剩余数量
}).

%% 新黑暗神殿战斗场景信息
-record(dark_shrine_fight_scene_m, {
    mon_id = 0,                                                          %% 怪物ID
    scene_key = {0, 0},                                                  %% 场景key
    scene_node = none,                                                   %% 场景节点
    scene_id = 0,                                                        %% 场景id
    true_team_id = 0                                                     %% 真实队伍id
}).

%% 新黑暗神殿战斗信息
-record(dark_shrine_fight_m, {
    mon_id = 0,                                                          %% 怪物ID
    scene_id = 0,                                                        %% 场景id
    role_infos = [],                                                     %% 参与玩家信息
    req_infos = [],                                                      %% 请求信息
    belong_id = 0,                                                       %% 归属者
    is_summary = 0                                                       %% 是否已结算(0否1是)
}).

%% 永恒之塔信息
-record(eternal_tower_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    tower_ranks = [],                                                    %% 塔榜单信息
    tower_infos = [],                                                    %% 塔信息
    tower_logs = []                                                      %% 塔日志信息
}).

%% 跨服行会战信息
-record(hanghui_cross_war_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    status = 0,                                                          %% %% 状态 0初始化1开始2结算中3结束
    server_worlds = [],                                                  %% 所有服世界等级信息
    enroll_infos = [],                                                   %% 报名信息
    overlord_area_id = 0,                                                %% 霸主战区id
    area_ids = [],                                                       %% 普通战区id列表
    overlord_hanghui_name = <<"">>,                                      %% 上届霸主行会名
    overlord_leader_name = <<"">>                                        %% 上届霸主会长名
}).

%% 跨服行会战玩家信息
-record(hanghui_cross_war_player_m, {
    role_id = 0,                                                         %% 玩家id
    hanghui_id = 0,                                                      %% 行会ID
    area_id = 0,                                                         %% 跨服行会战分区id
    area_type = 0,                                                       %% 跨服行会战分区类型 1霸主 2普通
    is_leave = 0,                                                        %% 是否离开跨服行会战场景(0否1是)
    kill_num = 0,                                                        %% 击杀数
    collect_num = 0,                                                     %% 采集数
    score = 0,                                                           %% 积分
    score_rewards = [],                                                  %% 积分阶段奖励ID列表
    shield_sec = 0,                                                      %% 护盾结束时间
    shield_use_sec = 0                                                   %% 护盾下次使用时间
}).

%% 活跃聊天记录
-record(active_chat_m, {
    role_id = 0,                                                         %% 玩家id
    total_times = 0,                                                     %% 聊天总数
    deal_times = 0,                                                      %% 处理次数
    repeat_times = 0,                                                    %% 重复次数
    probe_times = 0,                                                     %% 封禁之后,探测聊天次数
    contents = []                                                        %% 聊天内容
}).

%% 活动杂项信息
-record(activity_mix_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    mix_info = none                                                      %% 杂项信息列表
}).

-endif. % DB_MNESIA_HRL

