%% coding: latin-1
%%%--------------------------------------------------------
%%% @author
%%% @date
%%% 世界聊天管理进程
%%% @end
%%%--------------------------------------------------------
-module(serv_world_chat_mgr).

-include("common.hrl").
-include("time_engine.hrl").


%% gen_server
-export([start_link/0, cast/2, call/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([s2s_request_callback/4, s2s_request_notback/4]).

-record(state, {}).

%% ====================================================================
%% Api functions
%% ====================================================================
%% 启动
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% ====================================================================
%% gen_server callbacks
%% ====================================================================
%% 初始化
init(_Arg) ->
    erlang:process_flag(trap_exit, true),
    %% 设置随机种子
    util_rand:seed(),
    util_mid_msg:init_process(),
    self() ! {init_world_chat},
    {ok, #state{}}.

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
    ?INFO("serv_world_chat_mgr begin close", []),
    util_world_chat_mgr:save_data(),
    ?INFO("serv_world_chat_mgr end close", []),
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

%% 初始化世界聊天
do_info({init_world_chat}, State) ->
    ok = util_world_chat_mgr:init_world_chat(),
    {noreply, State};

%% 清空聊天记录
do_info({clear_world_chat}, State) ->
    util_world_chat_mgr:clear_world_chat(),
    {noreply, State};



%% loop
do_info({?TIMING_SEC_EVENT, NowSec, NowMs}, State) ->
    NewState =
        case catch loop(NowSec, NowMs, State) of
            {ok, State2} ->
                State2;
            _Other ->
                ?ERROR("serv_world_chat_mgr err:~p", [_Other]),
                State
        end,
    {noreply, NewState};

%% 异步调用请求处理,无回调
do_info({request_notback, _Args} = Req, State) ->
    case catch util_s2s_msg:handle_request_notback(Req, State) of
        {ok, State2} ->
            {noreply, State2};
        _Reason ->
            ?ERROR("chuli _Args:~w err ~w", [_Args, _Reason]),
            {noreply, State}
    end;

%% 异步调用请求处理
do_info({request_callback, _Args} = Req, State) ->
    case catch util_s2s_msg:handle_request_callback(Req, State) of
        {ok, State2} ->
            {noreply, State2};
        _Reason ->
            ?ERROR("chuli _Args:~w err ~w", [_Args, _Reason]),
            {noreply, State}
    end;

%% 异步调用返回值处理
do_info({response_callback, _Args} = Req, State) ->
    case catch util_s2s_msg:handle_response_callback(Req, State) of
        {ok, State2} ->
            {noreply, State2};
        _Reason ->
            ?ERROR("chuli _Args:~w err ~w", [_Args, _Reason]),
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
    ?ERROR("unkonw  s2s_handle_request request:~w", [_MsgId]),
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