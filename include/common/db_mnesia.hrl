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



%% 基础固定表
-define(DB_SENSITIVE_KEY_M, m_db_sensitive_key).
-define(DB_RANK_M, m_db_rank).
-define(DB_ICON_M, m_db_icon).
-define(DB_PUBLIC_MAIL_M, m_db_public_mail).
-define(DB_WORLD_CHAT_M, m_db_world_chat).
-define(DB_PUBLIC_PLAY_M, m_db_public_play).
-define(DB_ROLE_NAME_USED_M, m_db_role_name_used).
-define(DB_DUMMY_SELECT_M, m_db_dummy_select).
-define(DB_DUMMY_GROW_M, m_db_dummy_grow).
-define(DB_CROSS_M, m_db_cross).
-define(DB_BAN_M, m_ban).
-define(DB_RUN_LIGHT_M, m_db_run_light).
-define(DB_ACTIVITY_M, m_db_activity).
-define(DB_ACTIVITY_GROUP_M, m_db_activity_group).
-define(DB_ACTIVITY_MIX_M, m_db_activity_mix).
-define(DB_MERGE_SERVER_M, m_db_merge_server).
-define(DB_ACTIVE_CHAT_M, m_db_active_chat).

%% 功能固定表

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
    create_server_id = 0,                                                %% 创角时的服务器平台id
    role_status = 0,                                                     %% 玩家状态
    login_sec = 0,                                                       %% 上线时间
    logout_sec = 0,                                                      %% 下线时间
    login_ip = <<"">>,                                                   %% 登录ip
    fight_actors = []                                                    %% fight_actor
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

%% mnesia假人detail表
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

%% 敏感字过滤表
-record(sensitive_key_m, {
    key = 0,                                                             %% 敏感字主键hash值
    key_flag = 0
}).

%% mnesia排行榜表
-record(rank_m, {
    id = 0,                                                              %% 自增id
    version = 0,                                                         %% 版本号
    rank_type = 0,                                                       %% 榜单类型
    start_sec = 0,                                                       %% 结束时间
    end_sec = 0,                                                         %% 开始时间
    award_sec = 0,                                                       %% 发奖时间
    rank_status = 0,                                                     %% 榜单状态
    rank_len = 0,                                                        %% 榜单人数
    is_award = 0,                                                        %% 榜单是否已经发奖 0没有 1有
    is_clear = 0,                                                        %% 榜单是否已经清空 0没有 1有
    is_change = 0,                                                       %% 榜单是否有变动 0没有 1有
    is_merge_collect = 0                                                 %% 榜单是否合服后重新收集 0没有 1有
}).

%% mnesia排行榜信息表
-record(rank_info_m, {
    rank_key = {0, 0},                                                   %% 主键
    self_id = 0,                                                         %% 自身id(玩家id)
    section_id = 0,                                                      %% 分段值
    rank_sec = 0,                                                        %% 上榜时间
    rank_id = 0,                                                         %% 榜单id
    rank_value_1 = 0,                                                    %% 第1个排行榜值
    rank_value_2 = 0,                                                    %% 第2个排行榜值
    rank_value_3 = 0,                                                    %% 第3个排行榜值
    now_rank_value_1 = 0,                                                %% 当前第1个排行榜值
    now_rank_value_2 = 0,                                                %% 当前第2个排行榜值
    now_rank_value_3 = 0                                                 %% 当前第3个排行榜值
}).

%% mnesia排行榜分段信息表
-record(rank_section_m, {
    section_id = 0,                                                      %% 分段id
    min_values = [0, 0, 0],                                              %% 当前分段最小值列表
    max_values = [0, 0, 0],                                              %% 当前分段最大值列表
    section_len = 0,                                                     %% 分段长度
    s_rank_infos = []                                                    %% 分段rank_info_m榜单总信息
}).

%% 图标信息
-record(icon_m, {
    icon_id = 0,                                                         %% 图标id
    version = 0,                                                         %% 版本号
    icon_status = 0,                                                     %% 图标状态
    start_sec = 0,                                                       %% 开始时间
    advance_end_sec = 0,                                                 %% 提前结束时间
    end_sec = 0,                                                         %% 结束时间
    advance_sec = 0,                                                     %% 提前通知时间
    is_notice = 0                                                        %% 是否已提前通知在线玩家
}).

%% mnesia公共邮件表
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

%% 世界聊天内容
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

%% 公用玩法表
-record(public_play_m, {
    config_id = 0,                                                       %% 配置表
    version = 0,                                                         %% 版本号
    custom_data = none                                                   %% 自定义数据
}).

%% 服务器合服
-record(merge_server_m, {
    server_id = 0,                                                       %% 服务器id
    merge_server_id = 0
}).

%% 玩家曾用名
-record(role_name_used_m, {
    id = 0,                                                              %% 玩家id
    version = 0,                                                         %% 数据版本号
    name = <<"">>,                                                       %% 曾用名
    new_name = <<"">>,                                                   %% 新名字
    change_sec = 0                                                       %% 修改名字时间
}).

%% 假人选择
-record(dummy_select_m, {
    select_id = 0,                                                       %% 假人选择id
    dummy_ids = []                                                       %% 假人列表
}).

%% 假人成长
-record(dummy_grow_m, {
    role_id = 0,                                                         %% 玩家id
    grow_id = 0,                                                         %% 成长id
    rename_sec = 0,                                                      %% 下次改名时间
    grow_sec = 0,                                                        %% 下次成长时间
    rank_type = 0,                                                       %% 排行榜id
    min_rank_id = 0,                                                     %% 最高排名
    max_rank_id = 0                                                      %% 最低排名
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

%% 封禁信息
-record(ban_m, {
    id = 0,                                                              %% 唯一id
    role_id = 0,                                                         %% 角色id
    type = 0,                                                            %% 封禁类型
    start_sec = 0,                                                       %% 封禁开始时间
    end_sec = 0                                                          %% 封禁结束时间
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

%% 快照内容
-record(snapshot_m, {
    snapshot_key = {0, 0},                                               %% 主键 {role_id,self_id}
    role_id = 0,                                                         %% 玩家id
    self_id = 0,                                                         %% 自定义id
    send_sec = 0,                                                        %% 快照时间
    custom_data = none                                                   %% 自定义数据
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

