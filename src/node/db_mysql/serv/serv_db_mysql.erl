%% coding: latin-1
%%%--------------------------------------------------------
%%% @author
%%% @date
%%% 游戏数据库进程
%%% @end
%%%--------------------------------------------------------
-module(serv_db_mysql).

-include("common.hrl").
-include("time_engine.hrl").
-include("db.hrl").

%% gen_server
-export([start_link/1, cast/2, call/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% ====================================================================
%% Api functions
%% ====================================================================
%% 启动
start_link(PoolId) ->
    ServPidName = util_db_mysql_serv:db_mysql_serv_name(PoolId),
    gen_server:start_link({local, ServPidName}, ?MODULE, [PoolId], []).

%% ====================================================================
%% gen_server callbacks
%% ====================================================================
%% 初始化
init([PoolId]) ->
    erlang:process_flag(trap_exit, true),
    %% 调度设置高优先级
    erlang:process_flag(priority, high),
    %% 设置随机种子
    util_rand:seed(),
    State = #db_mysql_state{
        pool_id = PoolId
    },
    util_db_mysql_serv:set_pool_id(PoolId),
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
terminate(_Reason, State) ->
    #db_mysql_state{
        pool_id = PoolId
    } = State,
    TerminateReason = util_game:get_terminate_reason(),
    ServPidName = util_db_mysql_serv:db_mysql_serv_name(PoolId),
    ?INFO("数据库进程~w 结束:~p", [ServPidName, TerminateReason]),
    ok.

%% code_change回调函数
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ====================================================================
%% Internal functions
%% ====================================================================
%% 公共处理
do_call({common_sync, M, F, A}, _From, State) ->
    {ok, State2, ResMsg} = util_db_mysql_serv:deal_common_sync(State, M, F, A),
    {reply, ResMsg, State2};

%% 同步写入
do_call({write_sync, M, F, A}, _From, State) ->
    {ok, State2, ResMsg} = util_db_mysql_serv:deal_write_sync(State, M, F, A),
    {reply, ResMsg, State2};

%% 同步查询
do_call({select_sync, M, F, A}, _From, State) ->
    {ok, State2, ResMsg} = util_db_mysql_serv:deal_select_sync(State, M, F, A),
    {reply, ResMsg, State2};

%% 同步删除
do_call({delete_sync, M, F, A}, _From, State) ->
    {ok, State2, ResMsg} = util_db_mysql_serv:deal_delete_sync(State, M, F, A),
    {reply, ResMsg, State2};

do_call(Req, _From, State) ->
    ?ERROR("unknown req:~w", [Req]),
    {noreply, State}.

%% 定时事件,由wg_timer_engine产生
do_info({?TIMING_SEC_EVENT, NowSec, NowMs}, State) ->
    NewState =
        case catch loop(NowSec, NowMs, State) of
            {ok, State2} ->
                State2;
            _Other ->
                ?ERROR("数据库进程有错:~p", [_Other]),
                State
        end,
    {noreply, NewState};

do_info(Req, State) ->
    ?ERROR("unknown req:~w", [Req]),
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