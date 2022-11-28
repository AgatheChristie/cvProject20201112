%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
%%% @date  2016.8.29
%%% 网关玩家信息
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(GW_ROLE_HRL).
-define(GW_ROLE_HRL, true).

%% 网关玩家连接接登录状态
-define(GW_ROLE_LOGIN_INIT, 0).                                          %% 登陆初始化
-define(GW_ROLE_LOGIN_FINISH, 1).                                        %% 登录成功

%% 连续接包超时次数
-define(PACK_TIMEOUT_TIMES, 5).

%% 网关登陆标识
-define(GW_ROLE_IS_FIRST, 1).                                            %% 第一次登陆
-define(GW_ROLE_IS_RELOGIN, 2).                                          %% 重复登陆

%% 是否可以推送
-define(GW_NOT_PUSH, 0).                                                 %% 不能推送协议
-define(GW_CAN_PUSH, 1).                                                 %% 可以推送协议

%% 在线信息
-record(gw_role_online, {
    gw_pid = none,                                                       %% 进程
    id = 0                                                               %% 玩家id
}).

%% 网关玩家信息
-record(gw_role, {
    id = 0,                                                              %% 网关玩家id
    gw_pid = none,                                                       %% 网关进程
    gw_send_pid = none,                                                  %% 发送网络进程
    l_socket_pid = none,                                                 %% socket监听进程
    socket_hand = false,                                                 %% socket是否已经建立握手
    socket = none,                                                       %% socket
    socket_close = false,                                                %% socket是否关闭
    socket_data = <<>>,                                                  %% 存储协议数据
    is_push = false,                                                     %% 是否可以推送协议
    login_port = 0,                                                      %% 登陆端口
    length = 0,                                                          %% 包长
    login_status = 0,                                                    %% 登陆状态
    login_ip = <<>>,                                                     %% 登陆ip
    keep_connect = false,                                                %% socket是否保持链接
    ref = 0,                                                             %% socket ref
    recv_cnt_count = 0,                                                  %% 收包数量大小
    pt_times = 0,                                                        %% 连续多个接包超时次数
    is_active = false,                                                   %% 是否已经激活
    heart_timeout_times = 0,                                             %% 心跳超时次数
    last_heart_sec = 0,                                                  %% 上次心跳时间
    stop_reason = "",                                                    %% 停止原因
    stop_sec = 0,                                                        %% 停止时间
    gateway_node = none,                                                 %% 网关节点
    game_node = none,                                                    %% 游戏节点
    fight_node = none                                                    %% 战斗节点
}).

-endif. % GW_ROLE_HRL
