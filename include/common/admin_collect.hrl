%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
%%% @date  2016.8.09
%%% 后台数据收集
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(ADMIN_COLLECT_HRL).
-define(ADMIN_COLLECT_HRL, true).

%% 后台数据收集进程的数量m
-define(ADMIN_COLLECT_COUNT, 1).
%% 每次提交的数量
-define(ADMIN_SUBMIT_COUNT, 50).

%% ets表的结构
%% 后台玩家创角
-record(col_role_create, {
    player_id = 0,                                                       %% 玩家id
    collect_id = 0,                                                      %% 收集进程id
    username = "",                                                       %% 账号名
    nickname = "",                                                       %% 玩家名
    sdk_platform_id = 0,                                                 %% sdk平台id
    sdk_channel = "",                                                    %% sdk渠道
    sdk_server_id = 0,                                                   %% sdk服务器id,创角时的服务器id
    plat_server = 0,                                                     %% 创角时平台服务器id
    via_id = 0,                                                          %% 来源id
    camp_id = 0,                                                         %% 国家id
    login_ip = "",                                                       %% 登陆ip
    device_desc = "",                                                    %% 当前登录的设备描述
    other_desc = "",                                                     %% 其他的描述(浏览器)
    role_type = 0,                                                       %% 玩家类型
    reg_time = 0,                                                        %% 注册时间
    self_attach = "",                                                    %% 自定义字段
    package_name = <<"">>,                                               %% 游戏包名
    invite_id = 0                                                        %% 邀请玩家ID
}).

%% 后台玩家登陆
-record(col_role_login, {
    player_id = 0,                                                       %% 玩家id
    collect_id = 0,                                                      %% 收集进程id
    username = "",                                                       %% 账号名
    nickname = "",                                                       %% 玩家名
    sdk_platform_id = 0,                                                 %% sdk平台id
    camp_id = 0,                                                         %% 国家id
    plat_server = 0,                                                     %% 创角时平台服务器id
    sdk_server_id = 0,                                                   %% sdk服务器id,创角时的服务器id
    role_type = 0,                                                       %% 玩家类型
    device_desc = "",                                                    %% 当前登录的设备描述
    other_desc = "",                                                     %% 其他的描述(浏览器)
    login_ip = "",                                                       %% 登陆ip
    login_sec = 0,                                                       %% 登录时间
    power_value = 0,                                                     %% 实力
    head_id = 0,                                                         %% 头像id
    main_hall_level = 0,                                                 %% 主殿等级
    jinzhu = 0,                                                          %% 金珠
    tongqian = 0,                                                        %% 铜钱
    zhanhun = 0,                                                         %% 战魂
    recharge = 0,                                                        %% 充值金额
    package_name = <<"">>                                                %% 游戏包名
}).

%% 后台玩家基础
-record(col_role_base, {
    player_id = 0,                                                       %% 玩家id
    collect_id = 0,                                                      %% 收集进程id
    username = "",                                                       %% 账号名
    nickname = "",                                                       %% 玩家名
    camp_id = 0,                                                         %% 国家id
    head_id = 0,                                                         %% 头像id
    power_value = 0,                                                     %% 实力
    main_hall_level = 0,                                                 %% 主殿等级
    jinzhu = 0,                                                          %% 金珠
    tongqian = 0,                                                        %% 铜钱
    zhanhun = 0,                                                         %% 战魂
    recharge = 0,                                                        %% 充值金额
    role_type = 0,                                                       %% 玩家类型
    package_name = <<"">>,                                               %% 游戏包名
    is_fcm = 0,                                                          %% 是否防沉迷
    age = 0,                                                             %% 玩家年龄
    online_sec = 0                                                       %% 当天在线时长
}).

%% 聊天日志
-record(col_chat_log, {
    chat_key = {0, 0},                                                   %% 主键
    player_id = 0,                                                       %% 玩家id
    collect_id = 0,                                                      %% 收集进程id
    plat_server = 0,                                                     %% 创角时平台服务器id
    sdk_platform_id = 0,                                                 %% sdk平台id
    app_id = 0,                                                          %% app_id
    type = 0,                                                            %% 类型
    chat_type = 0,                                                       %% 聊天类型
    username = "",                                                       %% 账号名
    nickname = "",                                                       %% 玩家名
    level = 0,                                                           %% 等级
    vip = 0,                                                             %% vip等级
    content = "",                                                        %% 聊天内容
    chat_sec = 0                                                         %% 聊天时间
}).

-endif.
