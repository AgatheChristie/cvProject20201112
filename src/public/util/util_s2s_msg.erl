%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 公共函数接口
%%%
%%%----------------------------------------------------------------------
-module(util_s2s_msg).

-include("common.hrl").


-export([
    s2s_request/6,
    request_notback/6,
    request_callback/6,
    handle_request_notback/2,
    handle_request_callback/2,
    handle_response_callback/2
]).

%% 异步请求,带回调,带超时
s2s_request(MsgFlag, MsgSeq, ReceivePid, ReceiveMod, ReceiveArgs, SendMod) ->
    request_notback(MsgFlag, MsgSeq, ReceivePid, ReceiveMod, ReceiveArgs, SendMod, ?CAST_TIMEOUT).

%% 内部接口,无回调
request_notback(MsgFlag, MsgSeq, ReceivePid, ReceiveMod, ReceiveArgs, SendMod) when is_pid(ReceivePid) ->
    request_notback(MsgFlag, MsgSeq, ReceivePid, ReceiveMod, ReceiveArgs, SendMod, ?CAST_TIMEOUT);
request_notback(MsgFlag, MsgSeq, {ReceiveName, ReceiveNode}, ReceiveMod, ReceiveArgs, SendMod) ->
    request_notback(MsgFlag, MsgSeq, {ReceiveName, ReceiveNode}, ReceiveMod, ReceiveArgs, SendMod, ?CAST_TIMEOUT).

request_notback(MsgFlag, MsgSeq, ReceivePid, ReceiveMod, ReceiveArgs, SendMod, TimeOut) when is_pid(ReceivePid) ->
    request_notback(MsgFlag, MsgSeq, {ReceivePid, erlang:node(ReceivePid)}, ReceiveMod, ReceiveArgs, SendMod, TimeOut);
request_notback(MsgFlag, MsgSeq, {ReceiveName, ReceiveNode}, ReceiveMod, ReceiveArgs, _SendMod, _TimeOut) ->
    ReceiveFun = fun ReceiveMod:s2s_request_notback/4,
    Args = {MsgFlag, MsgSeq, ReceiveFun, ReceiveArgs},
    util_mid_msg:cast_msg(ReceiveName, ReceiveNode, {request_notback, Args}).

%% 内部接口,有回调
request_callback(MsgFlag, MsgSeq, ReceivePid, ReceiveMod, ReceiveArgs, SendMod) when is_pid(ReceivePid) ->
    request_callback(MsgFlag, MsgSeq, {ReceivePid, erlang:node(ReceivePid)}, ReceiveMod, ReceiveArgs, SendMod, ?CAST_TIMEOUT);
request_callback(MsgFlag, MsgSeq, {ReceiveName, ReceiveNode}, ReceiveMod, ReceiveArgs, SendMod) ->
    request_callback(MsgFlag, MsgSeq, {ReceiveName, ReceiveNode}, ReceiveMod, ReceiveArgs, SendMod, ?CAST_TIMEOUT).

request_callback(MsgFlag, MsgSeq, ReceivePid, ReceiveMod, ReceiveArgs, SendMod, TimeOut) when is_pid(ReceivePid) ->
    request_callback(MsgFlag, MsgSeq, {ReceivePid, erlang:node(ReceivePid)}, ReceiveMod, ReceiveArgs, SendMod, TimeOut);
request_callback(MsgFlag, MsgSeq, {ReceiveName, ReceiveNode}, ReceiveMod, ReceiveArgs, SendMod, TimeOut) ->
    ReceiveFun = fun ReceiveMod:s2s_request_callback/4,
    SendFun = fun SendMod:s2s_response_callback/4,
    RequestId = erlang:make_ref(),
    DictFun =
        fun(TMsgFlag, TMsgSeq, ResponseMsg, State) ->
            SendFun(TMsgFlag, TMsgSeq, ResponseMsg, State)
        end,
    %% 保存回调函数
    erlang:put({RequestId, ?S2S_CONVERT_FUN}, DictFun),
    %% 保存回调定时器
    TimerRef = proc_timer:start_timer(SendMod, TimeOut, {request_timeout, {ReceiveName, ReceiveNode}, RequestId, MsgFlag, MsgSeq}),
    erlang:put({RequestId, ?S2S_CONVERT_TIMER}, TimerRef),
    Args = {self(), node(), RequestId, MsgFlag, MsgSeq, ReceiveFun, ReceiveArgs},
    util_mid_msg:cast_msg(ReceiveName, ReceiveNode, {request_callback, Args}).

%% 无回调目标进程,处理请求消息
handle_request_notback({request_notback, Args}, State) ->
    {MsgFlag, MsgSeq, ReceiveFun, ReceiveArgs} = Args,
    case catch ReceiveFun(MsgFlag, MsgSeq, ReceiveArgs, State) of
        {ok, State2} ->
            {ok, State2};
        {ok, State2, _ResponseMsg} ->
            {ok, State2};
        _ERR ->
            ?ERROR("异步请求处理失败:~w", [{MsgFlag, MsgSeq, ReceiveFun}]),
            ?ERROR("异步请求处理失败:~w ~n", [_ERR]),
            {ok, State}
    end.

%% 有回调目标进程,处理请求消息
handle_request_callback({request_callback, Args}, State) ->
    {SendPid, SendNode, RequestId, MsgFlag, MsgSeq, ReceiveFun, ReceiveArgs} = Args,
    case catch ReceiveFun(MsgFlag, MsgSeq, ReceiveArgs, State) of
        {error, Code} ->
            s2s_response(SendPid, SendNode, RequestId, MsgFlag, MsgSeq, {error, Code}, State);
        {'EXIT', _E} ->
            ?ERROR("异步请求处理失败:~w", [{SendPid, SendNode, RequestId, MsgFlag, MsgSeq, ReceiveFun}]),
            ?ERROR("异步请求处理失败:~w ~n", [_E]),
            s2s_response(SendPid, SendNode, RequestId, MsgFlag, MsgSeq, {error, ?E_ERROR_HANLE}, State);
        {ok, State2} ->
            s2s_response(SendPid, SendNode, RequestId, MsgFlag, MsgSeq, {ok}, State2);
        {ok, State2, ResponseMsg} ->
            s2s_response(SendPid, SendNode, RequestId, MsgFlag, MsgSeq, ResponseMsg, State2);
        _ERR ->
            ?ERROR("异步请求处理失败:~w", [{SendPid, SendNode, RequestId, MsgFlag, MsgSeq, ReceiveFun}]),
            ?ERROR("异步请求处理失败:~w ~n", [_ERR]),
            s2s_response(SendPid, SendNode, RequestId, MsgFlag, MsgSeq, {error, ?E_ERROR_HANLE}, State)
    end.

%% 返回请求处理结果
s2s_response(SendPid, SendNode, RequestId, MsgFlag, MsgSeq, ResponseMsg, State) ->
    Args = {erlang:self(), node(), RequestId, MsgFlag, MsgSeq, ResponseMsg},
    util_mid_msg:cast_msg(SendPid, SendNode, {response_callback, Args}),
    {ok, State}.

%% 处理返回值response消息
handle_response_callback({response_callback, {_ReceivePid, _ReceiveNode, RequestId, MsgFlag, MsgSeq, ResponseMsg}}, State) ->
    case erlang:erase({RequestId, ?S2S_CONVERT_FUN}) of
        undefined ->
            {ok, State};
        SendFun ->
            %% 清除定时器
            case erlang:erase({RequestId, ?S2S_CONVERT_TIMER}) of
                undefined ->
                    next;
                TimerRef ->
                    proc_timer:cancel_timer(TimerRef)
            end,
            SendFun(MsgFlag, MsgSeq, ResponseMsg, State)
    end.