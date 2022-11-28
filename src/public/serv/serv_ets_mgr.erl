%% coding: latin-1
%%%--------------------------------------------------------
%%% @author
%%% @date
%%% ets表管理进程
%%% @end
%%%--------------------------------------------------------
-module(serv_ets_mgr).

-include("common.hrl").
-include("time_engine.hrl").


%% gen_server
-export([start_link/1, cast/2, call/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([s2s_request_callback/4, s2s_request_notback/4]).

-record(state, {node_type = 0}).

%% ====================================================================
%% Api functions
%% ====================================================================
%% 启动
start_link(NodeType) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [NodeType], []).

%% ====================================================================
%% gen_server callbacks
%% ====================================================================
%% 初始化
init([NodeType]) ->
    erlang:process_flag(trap_exit, true),
    %% 设置随机种子
    util_rand:seed(),
    util_mid_msg:init_process(),
    util_ets_mgr:init_ets(NodeType),
    State = #state{node_type = NodeType},
    {ok, State}.

%% handle_call回调函数
handle_call(Req, From, State) ->
    ?HANDLE_CALL(Req, From, State).

%% handle_cast回调函数
handle_cast(Req, State) ->
    ?HANDLE_INFO(Req, State).

%% handle_info回调函数
handle_info(Req, State) ->
    ?HANDLE_INFO(Req, State).

%% terminate回调函数
terminate(_Reason, _State) ->
    ?INFO(   "节点:~的ets表管理进程完成关闭", [node()]),
    ok.

%% code_change回调函数
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ====================================================================
%% Internal functions
%% ====================================================================
do_call(Req, _From, State) ->
    ?ERROR("unknown req:~w", [Req]),
    {noreply, State}.

%% loop
do_info({?TIMING_SEC_EVENT, NowSec, NowMs}, State) ->
    NewState =
        case catch loop(NowSec, NowMs, State) of
            {ok, State2} ->
                State2;
            _Other ->
                ?ERROR( "ets表管理进程有错:~p", [_Other]),
                State
        end,
    {noreply, NewState};

%% 异步调用请求处理,无回调
do_info({request_notback, _Args} = Req, State) ->
    case catch util_s2s_msg:handle_request_notback(Req, State) of
        {ok, State2} ->
            {noreply, State2};
        _Reason ->
            ?ERROR( "处理 _Args:~w 出错:~w", [_Args, _Reason]),
            {noreply, State}
    end;

%% 异步调用请求处理
do_info({request_callback, _Args} = Req, State) ->
    case catch util_s2s_msg:handle_request_callback(Req, State) of
        {ok, State2} ->
            {noreply, State2};
        _Reason ->
            ?ERROR( "处理 _Args:~w 出错:~w", [_Args, _Reason]),
            {noreply, State}
    end;

%% 异步调用返回值处理
do_info({response_callback, _Args} = Req, State) ->
    case catch util_s2s_msg:handle_response_callback(Req, State) of
        {ok, State2} ->
            {noreply, State2};
        _Reason ->
            ?ERROR( "处理 _Args:~w 出错:~w", [_Args, _Reason]),
            {noreply, State}
    end;

do_info(Req, State) ->
    ?ERROR("unknown req:~w", [Req]),
    {noreply, State}.

%% 定时循环
loop(NowSec, NowMs, State) ->
    util_time:set_now_ms(NowMs),
    util_time:set_now_sec(NowSec),
    {ok, State}.

%% 协议远程异步回调结果
s2s_request_callback(MsgId, MsgSeq, ResponseMsg, State) ->
    s2s_handle_request(MsgId, MsgSeq, ResponseMsg, State).

s2s_request_notback(MsgId, MsgSeq, ResponseMsg, State) ->
    s2s_handle_request(MsgId, MsgSeq, ResponseMsg, State).

s2s_handle_request(_MsgId, _MsgSeq, _ResponseMsg, State) ->
    ?ERROR( "未知类型的s2s_handle_request回应:~w", [_MsgId]),
    {ok, State}.

%% ====================================================================
%% Export functions
%% ====================================================================
%% 发送cast请求
cast(Id, Req) ->
    gen_server:cast(Id, Req).

%% 发送call请求
call(Id, Req) ->
    catch gen_server:call(Id, Req, ?CALL_TIMEOUT).