%% coding: latin-1


-define(APP_HRL, true).

%% 应用对应的状态码
-define(STATUS_SUCCESS, 0).                                             %% 成功
-define(STATUS_ERROR, 1).                                               %% 错误
-define(STATUS_NORUN, 2).                                               %% 未运行
-define(STATUS_BADRPC, 3).                                              %% rpc调用错误
-define(STATUS_USAGE, 4).                                               %% 用法错误
-define(STATUS_STARTING, 5).                                            %% 正在启动
-define(STATUS_RUNNING, 6).                                             %% 正在运行中
-define(STATUS_STOPING, 7).                                             %% 正在停止


%% 启动的app列表
-define(MANAGE_APP, manage).                                            %% 管理节点
-define(DB_MYSQL_APP, db_mysql).                                        %% mysql节点
-define(DB_MNESIA_APP, db_mnesia).                                      %% mnesia节点

%% 系统自动的app列表
-define(SYS_SASL, sasl).                                                %% 系统日志app

%% 需要启动的app列表
-define(MANAGE_START_APPS, [?SYS_SASL, ?MANAGE_APP]).
-define(DB_MYSQL_START_APPS, [?SYS_SASL, ?DB_MYSQL_APP]).
-define(DB_MNESIA_START_APPS, [?SYS_SASL, ?DB_MNESIA_APP]).

%% app的节点ets表
-define(ETS_APP_NODE_TABLE, ets_app_node).
