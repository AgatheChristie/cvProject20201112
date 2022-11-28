%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author taiqi
%%% @date  2016.10.09
%%% cloud_msg
%%% @end
%%%
%%%----------------------------------------------------------------------
-ifndef(MID_MSG_HRL).
-define(MID_MSG_HRL, true).

-define(MSG_TYPE_SELF, 1).                                                %% 来自本地节点的消息
-define(MSG_TYPE_OTHER, 2).                                               %% 来自其它节点的消息

%% 消息互发数量
-define(MID_MSG_MAX, 8).                                                 %% serv_msg最大进程数

%% 进程字典宏
-define(TX_PNAME, mid_tx_pname).
-define(RX_PNAME, mid_rx_pname).

-endif.
