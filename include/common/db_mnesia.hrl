%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
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
-define(DB_ROLE_SAVE_M(TabType), util:prefix_n("m_db_role_save", [TabType])).
-define(DB_ROLE_SAVE_MSG_M(TabType), util:prefix_n("m_db_role_save_msg", [TabType])).
-define(DB_ROLE_DETAIL_M(TabType), util:prefix_n("m_db_role_detail", [TabType])).
-define(DB_ROLE_SIMPLE_M(TabType), util:prefix_n("m_db_role_simple", [TabType])).
-define(DB_ROLE_COLLECT_M(TabType), util:prefix_n("m_db_role_collect", [TabType])).
-define(DB_RANK_INFO_M(RankType), util:prefix_n("m_db_rank_info", [RankType])).
-define(DB_SNAPSHOT_M(SnapshotType), util:prefix_n("m_db_snapshot", [SnapshotType])).
-define(DB_WHOLE_ROLE_M(WholeRoleType), util:prefix_n("m_db_whole_role", [WholeRoleType])).
-define(DB_BAN_MGR_M(Type), util:prefix_n("m_db_ban_mgr", [Type])).

%% 基础固定表
-define(DB_SENSITIVE_KEY_M, m_db_sensitive_key).
-define(DB_RANK_M, m_db_rank).
-define(DB_ICON_M, m_db_icon).
-define(DB_PUBLIC_MAIL_M, m_db_public_mail).
-define(DB_WORLD_CHAT_M, m_db_world_chat).
-define(DB_PUBLIC_PLAY_M, m_db_public_play).
-define(DB_LEAGUE_M, m_db_league).
-define(DB_CROSS_M, m_db_cross).
-define(DB_RUN_LIGHT_M, m_db_run_light).
-define(DB_ACTIVITY_M, m_db_activity).
-define(DB_ACTIVITY_GROUP_M, m_db_activity_group).
-define(DB_ACTIVITY_MIX_M, m_db_activity_mix).
-define(DB_MERGE_SERVER_M, m_db_merge_server).
-define(DB_ACTIVE_CHAT_M, m_db_active_chat).
-define(DB_WHOLE_ROLE_M, m_db_whole_role).
-define(DB_FIGHT_SOCKET_M, m_db_fight_socket).
-define(DB_PUBLIC_PRIVILEGE_M, m_db_public_privilege).

%% 功能固定表
-define(DB_CITY_M, m_db_city).
-define(DB_ROLE_ORDER_M, m_db_role_order).
-define(DB_TEAM_ORDER_M, m_db_team_order).
-define(DB_BATTLE_INFO_M, m_db_battle_info).
-define(DB_BATTLE_REPORT_INFO_M, m_db_battle_report_info).
-define(DB_CAMP_INFO_M, m_db_camp_info).
-define(DB_PLOT_MON_M, m_db_plot_mon).
-define(DB_TREND_INFO_M, m_db_trend_info).
-define(DB_VOTE_INFO_M, m_db_vote_info).
-define(DB_SUBJECT_M, m_db_subject).
-define(DB_MJ_CHALLENGE_INFO_M, m_db_mj_challenge_info).

%% 玩家表分表
-define(M_MAX_BASE_TAB, 1).                                              %% 玩家基础缓存表
-define(M_MAX_GAME_TAB, 1).                                              %% 玩家game缓存表
-define(M_MAX_GATEWAY_TAB, 1).                                           %% 玩家gateway缓存表
-define(M_MAX_FIGHT_TAB, 1).                                             %% 玩家fight缓存表
-define(M_MAX_OFFLINE_TAB, 1).                                           %% 玩家离线缓存表
-define(M_MAX_ROLE_SAVE_TAB, 1).                                         %% 玩家保存缓存表
-define(M_MAX_ROLE_SAVE_MSG_TAB, 1).                                     %% 玩家保存离线信息缓存表
-define(M_MAX_DETAIL_TAB, 1).                                            %% 玩家详细缓存表
-define(M_MAX_COLLECT_TAB, 1).                                           %% 玩家简单收集表
-define(M_MAX_SIMPLE_TAB, 1).                                            %% 玩家精简信息表

%% 数据是否落地
-define(MNESIA_NOT_SAVE, 0).                                             %% 数据不落地
-define(MNESIA_IS_SAVE, 1).                                              %% 数据需落地

%% 定时的间隔
-define(MNESIA_SAVE_SEC, 60).                                            %% 定时落地间隔

%% mnesia的表record定义
%% mnesia节点表
-record(node_m, {
    node_key = {none, 0},                                                %% 节点主键 {节点名, self_type}
    node = none,                                                         %% 节点名
    master_node = none,                                                  %% master节点
    server_id = 0,                                                       %% 服唯一id
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
    re_camp_id = 0,                                                      %% 推荐势力id
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

%% mnesia玩家保存信息表
-record(role_save_m, {
    role_id = 0,                                                         %% 玩家id
    line_id = 0,                                                         %% 分线id
    max_msg_id = 0,
    is_change = 0                                                        %% 是否更改
}).

%% mnesia玩家保存离线信息表
-record(role_save_msg_m, {
    msg_key = {0, 0},                                                    %% {玩家id,消息id}
    role_id = 0,                                                         %% 玩家id
    msg_id = 0,                                                          %% 消息id
    deal_sec = 0,                                                        %% 处理时间
    msg = none                                                           %% 消息
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
    league_id = 0,                                                       %% 联盟id
    league_post = 0,                                                     %% 联盟职位
    league_name = <<"">>,                                                %% 联盟名
    head_portrait_id = 0,                                                %% 正在使用的头像id
    chat_frame_id = 0,                                                   %% 正在使用的气泡id
    resume = <<"">>,                                                     %% 个人简介
    create_server_id = 0,                                                %% 创角时的服务器平台id
    role_status = 0,                                                     %% 玩家状态
    login_sec = 0,                                                       %% 上线时间
    logout_sec = 0,                                                      %% 下线时间
    login_ip = <<"">>,                                                   %% 登录ip
    detail_actors = [],                                                  %% detail_actor
    detail_teams = [],                                                   %% detail_team
    common_buff_ids = [],                                                %% common_buff_ids
    look_city_id = 0,                                                    %% 查看城池id
    fight_city_id = 0,                                                   %% 查看战况城池id
    fight_sort_id = 0,                                                   %% 查看战况城池对战id
    camp_id = 0,                                                         %% 玩家势力id
    total_contribution = 0,                                              %% 联盟贡献总量(捐献、打地)
    camp_post = 0,                                                       %% 国家职位
    total_devote = 0,                                                    %% 总共贡献度
    now_devote = 0,                                                      %% 本周贡献度
    prev_rank_id = 0,                                                    %% 上周贡献度排名
    yesterday_rank_id = 0,                                               %% 昨日贡献度排名
    unspeack_sec = 0,                                                    %% 禁言时间
    camp_unspeak_sec = 0,                                                %% 国家禁言时间
    camp_value = 0,                                                      %% 地块实力
    actor_value = 0,                                                     %% 武将实力
    build_value = 0,                                                     %% 城建实力
    public_army_value = 0,                                               %% 公共兵种实力
    total_gongxun = 0                                                    %% 总功勋
}).

%% mnesia玩家collect表
%% 分离出来是为了避免脏操作影响到额外的数据,只有统计数据有脏操作影响不大
-record(role_collect_m, {
    role_id = 0,                                                         %% 玩家id
    start_sec = 0,                                                       %% 开始时间
    active_sec = 0,                                                      %% 活跃时间
    active_times = 0                                                     %% 活跃次数
}).

%% 玩家精简信息
-record(role_simple_m, {
    role_id = 0,                                                         %% 玩家id
    sdk_server_id = 0,                                                   %% 服id
    role_name = <<"">>,                                                  %% 玩家名
    acc_name = <<"">>                                                    %% 帐号
}).

%% 敏感字过滤表
-record(sensitive_key_m, {
    key = 0,                                                             %% 敏感字主键hash值
    key_flag = 0
}).

%% mnesia排行榜表
-record(rank_m, {
    id = 0,                                                              %% 自增id
    rank_type = 0,                                                       %% 榜单类型
    start_sec = 0,                                                       %% 结束时间
    end_sec = 0,                                                         %% 开始时间
    award_sec = 0,                                                       %% 发奖时间
    rank_status = 0,                                                     %% 榜单状态
    rank_len = 0,                                                        %% 榜单人数
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    is_award = 0,                                                        %% 榜单是否已经发奖 0没有 1有
    is_clear = 0,                                                        %% 榜单是否已经清空 0没有 1有
    is_change = 0,                                                       %% 榜单是否有变动 0没有 1有
    is_merge_collect = 0                                                 %% 榜单是否合服后重新收集 0没有 1有
}).

%% mnesia排行榜信息表
-record(rank_info_m, {
    rank_key = {0, 0},                                                   %% 主键
    self_id = 0,                                                         %% 自身id(玩家id)
    rank_sec = 0,                                                        %% 上榜时间
    rank_id = 0,                                                         %% 榜单id
    rank_value_1 = 0,                                                    %% 第1个排行榜值
    rank_value_2 = 0,                                                    %% 第2个排行榜值
    rank_value_3 = 0,                                                    %% 第3个排行榜值
    now_rank_value_1 = 0,                                                %% 当前第1个排行榜值
    now_rank_value_2 = 0,                                                %% 当前第2个排行榜值
    now_rank_value_3 = 0                                                 %% 当前第3个排行榜值
}).

%% 联盟表
-record(league_m, {
    id = 0,                                                              %% 联盟id
    server_only_ids = [],                                                %% 服务器唯一id列表
    name = <<"">>,                                                       %% 联盟名字
    icon_id = 1,                                                         %% 联盟图标id
    pid,                                                                 %% 联盟进程pid
    level = 0,                                                           %% 联盟等级
    camp_id = 0,                                                         %% 联盟势力id
    exp = 0,                                                             %% 联盟经验
    scene_key = {0, 0},                                                  %% 场景key
    scene_node = none,                                                   %% 场景节点
    create_sec = 0,                                                      %% 创建时间
    notice_board = <<"">>,                                               %% 联盟公告
    leader_id = 0,                                                       %% 会长角色id
    members = [],                                                        %% 成员列表
    member_num = 0,                                                      %% 当前成员数量
    league_resources = [],                                               %% 联盟资源
    total_member_num = 0,                                                %% 当前最多成员数量
    join_type = 0,                                                       %% 设置加入类型 0:手动同意 1：自动
    join_conditions = [],                                                %% 设置加入条件限制
    league_applys = [],                                                  %% 申请列表
    league_logs = [],                                                    %% 联盟日志
    league_chats = [],                                                   %% 联盟聊天
    total_score = 0,                                                     %% 公会总评分
    mail_sec = 0,                                                        %% 上次发送联盟邮件时间戳
    demise_info = none,                                                  %% 禅让信息
    modify_notice_sec = 0,                                               %% 修改公告倒计时
    diplomacy_infos = [],                                                %% 外交信息列表
    dip_send_applys = [],                                                %% 发送结盟申请列表
    dip_receive_applys = []                                              %% 接受结盟申请列表
}).

%% 图标信息
-record(icon_m, {
    icon_id = 0,                                                         %% 图标id
    icon_status = 0,                                                     %% 图标状态
    advance_sec = 0,                                                     %% 提前通知时间
    start_sec = 0,                                                       %% 开始时间
    advance_end_sec = 0,                                                 %% 预告服务端结束时间
    server_end_sec = 0,                                                  %% 服务端结束时间
    end_sec = 0,                                                         %% 结束时间
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    is_notice = 0                                                        %% 是否已提前通知在线玩家
}).

%% mnesia公共邮件表
-record(public_mail_m, {
    id = 0,                                                              %% 自增id
    template_id = 0,                                                     %% 模板id
    int_values = [],                                                     %% 整形参数列表
    string_values = [],                                                  %% 字符串参数列表
    title = <<>>,                                                        %% 标题
    content = <<>>,                                                      %% 内容
    conditions = [],                                                     %% 邮件条件
    items = [],                                                          %% 道具列表
    log_type = 0,                                                        %% 日志类型
    type = 0,                                                            %% 全服邮件 0:全服 1:多人
    mail_sort = 0,                                                       %% 邮件分类 1.联盟邮件 2.分组邮件 3.系统邮件
    mail_type = 0,                                                       %% 邮件类型 1.无附件邮件 2.普通附件邮件
    role_ids = [],                                                       %% 玩家列表
    send_sec = 0                                                         %% 发送时间
}).

%% 世界聊天内容
-record(world_chat_m, {
    id = 0,                                                              %% 自增id
    chat_type = 0,                                                       %% 聊天类型
    role_id = 0,                                                         %% 玩家id
    is_light = 0,                                                        %% 是否跑马灯 0否 1是
    chat_sec = 0,                                                        %% 世界聊天时间
    chat_parts = [],                                                     %% 聊天模板信息
    is_admin = 0,                                                        %% 是否后台发送 0否 1是
    is_world = 0                                                         %% 是否存储
}).

%% 世界聊天内容组合
-record(world_chat_part_m, {
    type = 0,                                                            %% 类型
    content = <<>>,                                                      %% 内容
    int_values = [],                                                     %% 整形参数列表
    string_values = [],                                                  %% 字符串参数列表
    template_id = 0                                                      %% 模板id
}).

%% 公用玩法表
-record(public_play_m, {
    config_id = 0,                                                       %% 配置表
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    custom_data = none                                                   %% 自定义数据
}).

%% 服务器合服
-record(merge_server_m, {
    server_id = 0,                                                       %% 服务器id
    merge_server_id = 0                                                  %% 合服服务器id
}).

%% 跨服信息
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

%% 跑马灯信息
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
    terms = [],                                                          %% 活动子项信息列表
    is_open = 0,                                                         %% 是否开启(0:否,1:是)
    start_sec = 0,                                                       %% 开始时间
    end_sec = 0,                                                         %% 结束时间
    daily_reset = 0,                                                     %% 是否每日重置(0否1是)
    delay_sec = 0,                                                       %% 活动结束后延迟关闭时间
    desc = <<"">>,                                                       %% 活动描述
    start_condition = 0,                                                 %% 活动总开关开始条件
    end_condition = 0,                                                   %% 活动总开关结束条件
    init_condition = 0                                                   %% 初始化条件
}).

%% 活动组
-record(activity_group_m, {
    group_id = 0,                                                        %% 活动组id
    group_icon = <<"">>                                                  %% 活动组图标
}).

%% 活动杂项信息
-record(activity_mix_m, {
    id = 0,                                                              %% 自增id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    mix_info = none                                                      %% 杂项信息列表
}).

%% 快照内容
-record(snapshot_m, {
    snapshot_key = {0, 0},                                               %% 主键 {role_id,self_id}
    role_id = 0,                                                         %% 玩家id
    self_id = 0,                                                         %% 自定义id
    send_sec = 0,                                                        %% 快照时间
    custom_data = none                                                   %% 自定义数据
}).

%% 城池信息
-record(city_m, {
    id = 0,                                                              %% 自增id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    map_id = 0,                                                          %% 地图id
    camp_id = 0,                                                         %% 国家id
    minxin_camp_id = 0,                                                  %% 民心国家id
    minxin = 0,                                                          %% 民心
    league_id = 0,                                                       %% 联盟id
    bei_city_mons = [],                                                  %% 城池被动怪物
    zhu_city_mons = [],                                                  %% 城池主动怪物
    defense_war_sec = 0,                                                 %% 自卫军反攻时间
    war_free_sec = 0,                                                    %% 免战时间
    quick_times = 0,                                                     %% 冲锋次数
    quick_sec = 0,                                                       %% 冲锋时间
    team_queues = [],                                                    %% 队伍队列
    common_fights = [],                                                  %% 正常对战排序
    add_fights = [],                                                     %% 突袭对战排序
    role_summarys = [],                                                  %% 玩家统计
    has_fight_times = 0,                                                 %% 已经占领次数
    fight_only_id = 0,                                                   %% 战斗唯一id
    fight_ranks = [],                                                    %% 攻城排名
    fight_role_ids = [],                                                 %% 查看战况的玩家信息
    log_only_id = 0,                                                     %% 战况唯一id
    city_status = 0,                                                     %% 城池状态
    fight_logs = [],                                                     %% 战况信息
    look_role_ids = [],                                                  %% 查看城池的玩家信息
    wild_mon_infos = [],                                                 %% 沙盘野怪信息
    governs = [],                                                        %% 城池治理
    caiwa_plots = [],                                                    %% 采挖地块
    policy_tokens = [],                                                  %% 城池令
    look_gov_role_ids = [],                                              %% 查看治理的玩家信息
    attack_sec = 0,                                                      %% 被攻占时的时间
    minxin_add_effects = [],                                             %% 民心附加效果
    ccl_add_effects = [],                                                %% 城池令附加效果
    city_effects = [],                                                   %% 城池加成效果
    expire_effect_types = [],                                            %% 失效的加成效果
    city_npc_attack = none,                                              %% npc攻城信息
    fight_buff_sec = 0,                                                  %% 对战buff时间
    fight_buffs = [],                                                    %% 对战buff信息
    baggage_cars = []                                                    %% 辎重车
}).

%% 玩家指令信息
-record(role_order_m, {
    id = "",                                                             %% 标识
    subject_key = {0, 0},                                                %% 主体主键
    subject_type = 0,                                                    %% 主体类型
    subject_id = 0,                                                      %% 主体id
    line_id = 0,                                                         %% 分线id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    team_keys = []                                                       %% 队伍主键列表
}).

%% 玩家队伍指令信息
-record(team_order_m, {
    team_key = {0, 0, 0},                                                %% {主体类型,主体id,队伍id}
    subject_type = 0,                                                    %% 主体类型
    subject_id = 0,                                                      %% 主体id
    subject_key = {0, 0},                                                %% 主体主键{主体类型,主体id}
    line_id = 0,                                                         %% 分线id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    team_id = 0,                                                         %% 队伍id
    order_type = 0,                                                      %% 指令类型
    team_status = 0,                                                     %% 队伍状态
    team_shiqi = 0,                                                      %% 队伍士气
    team_shiqi_sec = 0,                                                  %% 队伍士气时间
    map_id = 0,                                                          %% 地图id
    born_city_id = 0,                                                    %% 出生城池id
    now_city_id = 0,                                                     %% 当前城池id
    back_city_id = 0,                                                    %% 返回城池id
    plot_id = 0,                                                         %% 地块id
    buildup_id = 0,                                                      %% 集结id
    far_army_id = 0,                                                     %% 远征军id
    start_sec = 0,                                                       %% 开始时间
    end_sec = 0,                                                         %% 结束时间
    is_loop_end = 0,                                                     %% 单次指令循环是否结束
    team_speed = 0,                                                      %% 队伍移动速度
    is_skip_fight = 0,                                                   %% 是否跳过战斗 0.否 1.是
    now_deal_times = 0,                                                  %% 当前处理次数
    max_deal_times = 0,                                                  %% 最大处理次数
    auto_back = 0,                                                       %% 自动回城 0:否 1:是
    retreat_times = 0,                                                   %% 回撤次数
    order_actors = [],                                                   %% 指令中的角色信息
    order_req_custom = none,                                             %% 请求自定义信息
    order_walk_custom = none                                             %% 行军自定义信息
}).

%% 战役信息
-record(battle_info_m, {
    id = "",                                                             %% 战役标识
    line_id = 0,                                                         %% 分线id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    attack_subject_type = 0,                                             %% 攻方主体类型
    attack_id = 0,                                                       %% 攻方主体id
    attack_name = <<>>,                                                  %% 攻方玩家名字
    attack_team_id = 0,                                                  %% 攻方队伍id
    attack_league_id = 0,                                                %% 攻方联盟id
    attack_league_name = <<>>,                                           %% 攻方联盟名字
    attack_camp_id = 0,                                                  %% 攻方势力id
    defense_subject_type = 0,                                            %% 守方主体类型
    defense_id = 0,                                                      %% 守方主体id
    defense_name = <<>>,                                                 %% 守方玩家名字
    defense_team_id = 0,                                                 %% 守方队伍id
    defense_league_id = 0,                                               %% 守方联盟id
    defense_league_name = 0,                                             %% 守方联盟名字
    defense_camp_id = 0,                                                 %% 守方势力id
    city_id = 0,                                                         %% 战斗城池
    city_camp_id = 0,                                                    %% 战斗城池归属的势力
    is_skip_fight = 0,                                                   %% 是否跳过战斗 0.否 1.是
    battle_type = 0,                                                     %% 战斗类型
    battle_step = 0,                                                     %% 战斗步骤
    battle_details = [],                                                 %% 战斗详情
    total_fight_times = 0,                                               %% 战斗总次数
    fight_infos = [],                                                    %% 战斗信息
    total_result = 3,                                                    %% 战役总结果 默认是3,默认超时的结果
    total_status = 0,                                                    %% 战役总状态
    result_sec = 0,                                                      %% 结果时间
    start_sec = 0,                                                       %% 开始时间
    end_sec = 0                                                          %% 结束时间
}).

%% 战报战役信息
-record(battle_report_info_m, {
    id = "",                                                             %% 战役标识
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    attack_subject_type = 0,                                             %% 攻方主体类型
    attack_id = 0,                                                       %% 攻方主体id
    attack_name = <<>>,                                                  %% 攻方主体名字
    attack_team_id = 0,                                                  %% 攻方队伍id
    attack_league_id = 0,                                                %% 攻方联盟id
    attack_league_name = <<>>,                                           %% 攻方联盟名字
    attack_camp_id = 0,                                                  %% 攻方势力id
    attack_is_read = 0,                                                  %% 攻方是否查看
    defense_subject_type = 0,                                            %% 守方主体类型
    defense_id = 0,                                                      %% 守方主体id
    defense_name = <<>>,                                                 %% 守方主体名字
    defense_team_id = 0,                                                 %% 守方队伍id
    defense_league_id = 0,                                               %% 守方联盟id
    defense_league_name = 0,                                             %% 守方联盟名字
    defense_camp_id = 0,                                                 %% 守方势力id
    defense_is_read = 0,                                                 %% 守方是否查看
    city_id = 0,                                                         %% 战斗城池
    city_camp_id = 0,                                                    %% 战斗城池归属的势力
    is_skip_fight = 0,                                                   %% 是否跳过战斗 0.否 1.是
    battle_type = 0,                                                     %% 战斗类型
    battle_details = [],                                                 %% 战斗详情
    total_fight_times = 0,                                               %% 战斗总次数
    fight_infos = [],                                                    %% 战斗信息
    total_result = 0,                                                    %% 战役总结果
    result_sec = 0,                                                      %% 结果时间
    start_sec = 0,                                                       %% 开始时间
    end_sec = 0                                                          %% 结束时间
}).

%% 国家信息
-record(camp_info_m, {
    id = 0,                                                              %% 国家id
    city_ids = [],                                                       %% 占领城池ids
    once_city_ids = [],                                                  %% 占领过的城池ids
    pid = <<>>,                                                          %% 国家进程pid
    notice_board = <<>>,                                                 %% 国家公告
    leader_id = 0,                                                       %% 国主角色id
    camp_members = [],                                                   %% 成员列表
    member_count = 0,                                                    %% 成员数量
    today_donate = 0,                                                    %% 国家今日总贡献
    today_gongxun = 0,                                                   %% 国家今日总功勋
    mail_sec = 0,                                                        %% 上次发送国家邮件时间戳
    demise_info = none,                                                  %% 禅让信息
    impeach_info = none,                                                 %% 弹劾信息
    camp_chats = [],                                                     %% 国家聊天
    chat_id = 0,                                                         %% 国家聊天自增id
    box_increment_id = 0,                                                %% 国家宝箱自增id
    treasure_increment_id = 0,                                           %% 国家宝藏自增id
    devote_sec = 0,                                                      %% 国家贡献度统计时间戳
    modify_notice_sec = 0,                                               %% 公告修改时间戳
    leader_born_sec = 0,                                                 %% 国主产生时间戳
    camp_resources = [],                                                 %% 国家资源
    camp_logs = [],                                                      %% 国家日志
    city_output_sec = 0,                                                 %% 国家城池结算时间
    welfare_boxs = [],                                                   %% 福利宝箱
    welfare_box_nums = [],                                               %% 各个来源宝箱的数量
    treasures = [],                                                      %% 福利宝藏
    camp_exp = 0,                                                        %% 国家经验
    camp_level = 0,                                                      %% 国家等级
    treasure_exp = 0,                                                    %% 宝藏经验
    look_role_ids = [],                                                  %% 打开界面玩家ids
    day_treasure_times = 0,                                              %% 今日获得宝藏次数
    science = none,                                                      %% 国家科技
    camp_effects = [],                                                   %% 国家自身加成信息
    role_effects = [],                                                   %% 玩家加成信息
    city_effects = [],                                                   %% 城池加成信息
    resource_decimals = [],                                              %% 资源小数
    yesterday_login_num = 0,                                             %% 昨天登录总人数
    today_login_num = 0,                                                 %% 今日登录总人数
    today_pay = 0,                                                       %% 国家今日总充值
    last_reset_sec = 0,                                                  %% 上次重置时间
    camp_status = 0,                                                     %% 国家状态
    status_end_sec = 0,                                                  %% 国家状态结束时间
    camp_death_sec = 0,                                                  %% 国家灭亡时间
    attack_camp_id = 0,                                                  %% 进攻的国家id
    camp_post_applys = [],                                               %% 申请列表
    camp_npc_attack = none,                                              %% 国家npc攻城信息
    camp_falings = [],                                                   %% 国家法令
    camp_signs = [],                                                     %% 国家标记
    total_science_point = 0,                                             %% 总科技点
    week_science_point = 0,                                              %% 本周科技点
    extra_science_point = 0,                                             %% 额外科技点
    buildup_infos = [],                                                  %% 集结信息
    far_army_info = none,                                                %% 远征军信息
    role_summarys = [],                                                  %% 攻击本方瓮城玩家统计
    camp_activitys = [],                                                 %% 国家活动
    camp_wgfks = [],                                                     %% 亡国富库
    camp_xlfjs = [],                                                     %% 寻龙分金
    finished_win_type = 0                                                %% 结算时达成的目标类型
}).

%% 玩家统一数据表
-record(whole_role_m, {
    role_id = 0,                                                         %% 玩家id
    camp_id = 0,                                                         %% 国家id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    line_id = 0,                                                         %% 分线id
    plot_details = [],                                                   %% 地块详情
    plot_builds = [],                                                    %% 地块建筑
    plot_orders = [],                                                    %% 地块指令
    restore_infos = [],                                                  %% 守军恢复信息
    role_effects = [],                                                   %% 玩家自身加成信息
    resource_items = [],                                                 %% 资源道具信息
    resource_decimals = [],                                              %% 资源小数
    declare_kill_num = 0,                                                %% 宣战击杀数
    crusade_kill_num = 0,                                                %% 群雄讨董击杀数
    nzbz_gongxun = 0,                                                    %% 南征北战功勋
    daily_minxin = 0,                                                    %% 每日累计民心积分
    daily_minxin_flag = 0,                                               %% 民心推送标签
    baggage_car_rewards = []                                             %% 辎重车奖励
}).

%% 公共特权数据表
-record(public_privilege_m, {
    id = 0,                                                              %% 特权id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    status = 0,                                                          %% 状态
    begin_sec = 0,                                                       %% 开始时间
    end_sec = 0                                                          %% 结束时间
}).

%% 大势信息
-record(trend_info_m, {
    id = 0,                                                              %% id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    start_sec = 0,                                                       %% 开始时间
    complete_sec = 0,                                                    %% 完成时间
    end_sec = 0,                                                         %% 结束时间
    max_value = 0,                                                       %% 最大进度值
    value = 0,                                                           %% 当前进度值
    trend_term_camps = [],                                               %% 国家信息
    status = 0                                                           %% 大势状态
}).

%% 投票信息
-record(vote_info_m, {
    id = 0,                                                              %% 唯一id
    is_save = 0,                                                         %% 是否落地缓存
    is_save_sec = 0,                                                     %% 缓存落地时间
    vote_id = 0,                                                         %% 投票id
    reason = <<>>,                                                       %% 投票理由
    end_sec = 0,                                                         %% 结束时间
    is_end = 0,                                                          %% 是否结束
    is_pass = 0,                                                         %% 是否通过
    source_id = 0,                                                       %% 发起人
    target_id = 0,                                                       %% 目标
    vote_terms = [],                                                     %% 投票子项信息
    voter_num = 0,                                                       %% 投票人数量
    voter_ids = []                                                       %% 投票人ids
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

%% 地块怪物部队
-record(plot_mon_m, {
    only_id = 0,                                                         %% 唯一id
    mon_team = none                                                      %% 怪物部队
}).

%% 战斗socket信息
-record(fight_socket_m, {
    socket_key = {0, 0, 0},                                              %% 主键 {节点id,战斗服id,socket自增id}
    fight_node = none,                                                   %% 战斗节点
    node_id = 0,                                                         %% 节点id
    cfs_serv_id = 0,                                                     %% 战斗服id
    socket_id = 0,                                                       %% socket自增id
    socket = none,                                                       %% socket值
    cfs_ip = "",                                                         %% 战斗服ip
    cfs_port = ""                                                        %% 战斗服端口
}).

%% 封禁管理信息
-record(ban_mgr_m, {
    id = 0,                                                              %% 唯一id
    version = 0,                                                         %% 版本
    type = 0,                                                            %% 类型 1:黑名单 2:白名单 3:禁言
    bw_type = 0,                                                         %% 类型：1:帐号,2:IP地址,3:玩家ID
    bw_type_args = "",                                                   %% 帐号/IP/玩家ID
    is_change = 0,                                                       %% 数据是否有变动
    end_sec = 0                                                          %% 结束时间
}).

%% 主体信息
-record(subject_m, {
    id = 0,                                                              %% 主体id
    subject_type = 0,                                                    %% 主体类型
    fun_type = 0,                                                        %% 功能类型
    is_close = 0,                                                        %% 是否关闭
    camp_id = 0,                                                         %% 国家id
    name = "",                                                           %% 名称
    subject_teams = []                                                   %% 主体队伍信息
}).

%% 名将挑战信息
-record(mj_challenge_info_m, {
    id = 0,                                                              %% 图标id
    mj_challenge_roles = [],                                             %% 玩家信息
    mj_challenge_ranks = []                                              %% 排行信息
}).

-endif. % DB_MNESIA_HRL

