%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
%%% @date  2016.8.29
%%% 玩家字典信息
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(ROLE_DICT_HRL).
-define(ROLE_DICT_HRL, true).

%% 玩家字典分类
-define(DICT_SORT_ATTR, 1).                                              %% 字典属性
-define(DICT_SORT_RED, 2).                                               %% 字典红点

%% 字典属性
-record(role_dict, {
    dict_key = {0, 0, 0, 0},                                             %% 主键{玩家id,分类,栏位,标识}
    custom_data = none                                                   %% 自定义属性
}).

%% 字典属性
-record(dict_attr, {
    attr = none,                                                         %% 属性
    first_attr = none,                                                   %% 一级属性
    buff_ids = []                                                        %% buff_ids
}).

%% 字典红点
-record(dict_red, {
    send_red_ids = [],                                                   %% 发送的红点
    is_take_red = 0,                                                     %% 是否获取红点
    trigger_items = []                                                   %% 触发红点道具
}).

-endif. % ROLE_DICT_HRL
