%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-11-1
%%%
%%%
%%%----------------------------------------------------------------------
-module(util_mid_msg).

-include("common.hrl").
-include("mid_msg.hrl").

-export([
    serv_cloud_rx_msg/1
    , serv_cloud_tx_msg/1
    , init_process/0
    , get_rx_pname/0
    , set_rx_pname/1
    , get_tx_pname/0
    , set_tx_pname/1
    , cast_msg/3
    , broad_msg_to_other/4
    , router_msg_to_receive/3
]).

serv_cloud_rx_msg(Id) ->
    util:prefix_n("serv_mid_msg_rx", [Id]).

serv_cloud_tx_msg(Id) ->
    util:prefix_n("serv_mid_msg_tx", [Id]).

%% 所有进程在初始化的时候都执行这个,去添加收发消息的进程名
init_process() ->
    util_rand:seed(),
    Id = util_rand:rand(1, ?MID_MSG_MAX),
    RxPname = util_mid_msg:serv_cloud_rx_msg(Id),
    TxPname = util_mid_msg:serv_cloud_tx_msg(Id),
    set_rx_pname(RxPname),
    set_tx_pname(TxPname),
    ok.

%% 获取接收进程名
get_rx_pname() ->
    case erlang:get(?RX_PNAME) of
        undefined ->
            ?NONE;
        PName ->
            PName
    end.
set_rx_pname(PName) ->
    erlang:put(?RX_PNAME, PName).

get_tx_pname() ->
    case erlang:get(?TX_PNAME) of
        undefined ->
            ?NONE;
        PName ->
            PName
    end.
set_tx_pname(PName) ->
    erlang:put(?TX_PNAME, PName).

%% 节点间通讯,告诉serv_message_tx进程,向目标节点发消息
cast_msg(ReceiveName, ReceiveNode, Msg) ->
    %% 发给自己的tx进程
    case util_config:is_mid_msg() of
        true ->
            TxName = get_tx_pname(),
            NewMsg = {?MSG_TYPE_SELF, ReceiveNode, ReceiveName, Msg},
            util:local_send(TxName, NewMsg);
        false ->
            util:rpc_send(ReceiveName, ReceiveNode, Msg)
    end.

%% 向目标结点发消息,只会发给同名的消息进程
broad_msg_to_other(?NONE, _ReceiveName, _Msg, _RxName) ->
    %%?INFO(?_U("目标节点为空,没有该接收进程~w"), [_ReceiveName]),
    ok;
broad_msg_to_other(_ReceiveNode, ?NONE, _Msg, _RxName) ->
    %%?INFO(?_U("接收进程~w为空"), [_ReceiveNode]),
    ok;
broad_msg_to_other(ReceiveNode, ReceiveName, Msg, RxName) ->
    %% 发给对方的rx进程
    NewMsg = {?MSG_TYPE_OTHER, node(), ReceiveName, Msg},
    util:rpc_send(RxName, ReceiveNode, NewMsg),
    ok.

%% 路由消息到接收进程
router_msg_to_receive(SendNode, ReceiveName, Msg) ->
    case util_config:is_mid_msg() of
        true ->
            util:local_send(ReceiveName, Msg);
        false ->
            util:rpc_send(ReceiveName, SendNode, Msg)
    end.