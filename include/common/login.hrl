%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
%%% @date  2016.8.09
%%% 登陆
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(LOGIN_HRL).
-define(LOGIN_HRL, true).

%% 网关退出类型
-define(LOGOUT_NORMAL, logout_normal).                                %% 正常退出
-define(LOGOUT_HEART_TIMEOUT, heart_timeout).                         %% 心跳超时
-define(LOGOUT_HEART_QUICK, heart_quick).                             %% 心跳过快
-define(LOGOUT_SOCKET_EXIT, socket_exit).                             %% socket exit
-define(LOGOUT_RELOGIN_FAILURE, relogin_failure).                     %% 重登录失败原进程退出
-define(LOGOUT_RELOGIN_SUCCESS, relogin_success).                     %% 重登录成功原进程退出
-define(LOGOUT_REGISTER_ERROR, register_error).                       %% 注册进程失败
-define(LOGOUT_TCP_ERROR, tcp_error).                                 %% tcp_error
-define(LOGOUT_TCP_CLOSE, tcp_close).                                 %% tcp_closed
-define(LOGOUT_CONNECT_LOST, connect_lost).                           %% 丢失连接
-define(LOGOUT_ANTI_CHEAT, anti_cheat).                               %% 防作弊
-define(LOGOUT_TCP_TIMEOUT, tcp_timeout).                             %% tcp timeout
-define(LOGOUT_TCP_LISTEN, tcp_listen).                               %% tcp监听出错
-define(LOGOUT_PROTO_ERROR, proto_error).                             %% 协议出错
-define(LOGOUT_PROTO_UNPACK, proto_unpack).                           %% 协议解包
-define(LOGOUT_PROTO_PACK, proto_pack).                               %% 协议封包
-define(LOGOUT_PROTO_CRYPTO, proto_crypto).                           %% 第一个包解密出错
-define(LOGOUT_PACK_TIMEOUT, pack_timeout).                           %% 第一个包超时
-define(LOGOUT_CALL_NORMAL, call_normal).                             %% s2s_call退出
-define(LOGOUT_MONI_NORMAL, moni_normal).                             %% 模拟协议退出
-define(LOGOUT_ROLE_NORMAL, role_normal).                             %% 正常退出
-define(LOGOUT_ROLE_INIT_DATA, role_init_data).                       %% 玩家初始化数据
-define(LOGOUT_QUICK_LOGIN, quick_login).                             %% 快速换线正常退出
-define(LOGOUT_SERVER_MAINTAIN, server_maintain).                     %% 服务器维护
-define(LOGOUT_QUICK_KICK, quick_kick).                               %% 紧急快速踢人
-define(LOGOUT_REPEATE_LOGIN, repeate_login).                         %% 重复登陆
-define(LOGOUT_LOGIN_ERROR, login_error).                             %% 登陆出错
-define(LOGOUT_RELOGIN_ERROR, relogin_error).                         %% 重登陆出错
-define(LOGOUT_SOCKET_SEND, socket_send).                             %% soceke发送出错

%% socket退出类型
-define(SOCKET_NORMAL, socket_normal).                                %% 正常退出
-define(SOCKET_CONNECT_LOST, socket_connect_lost).                    %% 丢失连接退出
-define(SOCKET_TIMEOUT, socket_timeout).                              %% tcp timeout

%% 重登陆进入类型
-define(SELECT_ENTER_FLAG, 1).                                        %% 正常登陆协议流程却是重登陆
-define(RELOGIN_ENTER_FLAG, 2).                                       %% 重登陆协议流程

%% 登陆分配节点信息保护时间
-define(LOGIN_PROTECT_TIME, 120).
%% 登出分配节点信息保护时间
-define(LOGOUT_PROTECT_TIME, 120).
%% 不在线玩家缓存报错时间
-define(CACHE_PROTECT_TIME, 120).

-endif.
