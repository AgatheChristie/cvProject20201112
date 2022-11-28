%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%%  taiqi
%%%  2016-11-4
%%%  配置相关
%%%
%%%----------------------------------------------------------------------
-ifndef(CONFIG_HRL).
-define(CONFIG_HRL, true).

%% 对应的配置文件
-define(CONFIG_MOD_BEAM, util_config_mod).

%% ip和域名转换
-record(ip_domain, {
    ip = "",                                                              %% ip
    domain = ""                                                           %% 域名
}).

-endif.