%% coding: latin-1
%%%--------------------------------------------------------
%%% @author zhanglei
%%% @date 2016-08-08
%%% mnesia数据库管理进程
%%% @end
%%%--------------------------------------------------------
-module(serv_mnesia_mgr).
-author("kuffios@163.com").
-include("common.hrl").
-include("time_engine.hrl").

%% gen_server
-export([start_link/2, cast/2, call/2, do_info/2, do_call/3]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {
    node_type = 0
}).

%% ====================================================================
%% Api functions
%% ====================================================================
%% 启动
start_link(NodeType, AppMod) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [NodeType, AppMod], []).

%% ====================================================================
%% gen_server callbacks
%% ====================================================================
%% 初始化
init([NodeType, AppMod]) ->
    erlang:process_flag(trap_exit, true),
    %% 设置随机种子
    util_rand:seed(),
    %% 初始化mnesia
    ok = util_mnesia_init:init_mnesia(NodeType, AppMod),
    State = #state{
        node_type = NodeType
    },
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
    TerminateReason = util_game:get_terminate_reason(),
    ?CVI("mnesia database management process end:~p", [TerminateReason]),
    ok.

%% code_change回调函数
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ====================================================================
%% Internal functions
%% ====================================================================
%% 获取MFA信息
do_call({get_mfa_info, M, F, A}, _From, State) ->
    {reply, catch erlang:apply(M, F, A), State};

do_call(Req, _From, State) ->
    ?CVI("unknown req:~w", [Req]),
    {noreply, State}.

%% 定时事件,由wg_timer_engine产生
do_info({?TIMING_SEC_EVENT, NowSec, NowMs}, State) ->
    NewState =
        case catch loop(NowSec, NowMs, State) of
            {ok, State2} ->
                State2;
            _Other ->
                ?CVI("mnesia database management process have err:~p", [_Other]),
                State
        end,
    {noreply, NewState};

do_info(Req, State) ->
    ?CVI("unknown req:~w", [Req]),
    {noreply, State}.

%% 定时循环
loop(NowSec, NowMs, State) ->
    util_time:set_now_ms(NowMs),
    util_time:set_now_sec(NowSec),
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

