%% coding: latin-1

-module(serv_db_mysql_mgr).

-include("common.hrl").

%% gen_server
-export([start_link/0, do_call/3, do_info/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

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
init(_Arg) ->
    erlang:process_flag(trap_exit, true),
    %% 设置随机种子
    util_rand:seed(),
    util_db_game:init_db_mysql(),
    {ok, #state{}}.

handle_call(Req, From, State) ->
    ?HANDLE_CALL(Req, From,State).

handle_cast(Req, State) ->
    ?HANDLE_INFO(Req, State).

handle_info(Info, State) ->
    ?HANDLE_INFO(Info, State).

terminate(_Reason, _State) ->
    TerminateReason = util_game:get_terminate_reason(),
    ?ERROR("DB finished:~w", [TerminateReason]),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ====================================================================
%% Internal functions
%% ====================================================================


%% 进入场景key
do_call({enter_scene_key, SceneKey, SArvgIds, CArvgIds, FunNode, FatherKey}, _From, State) ->
    ?ERROR("fawf:~p end",[{SceneKey, SArvgIds, CArvgIds, FunNode, FatherKey}]),
    {reply, cventer_scene_key, State};


do_call(_Request, _From, State) ->
    {reply, ok, State}.

%% 进程退出
do_info({'EXIT', ExitPid, _}, State) ->
    ?ERROR("DB proce exit:~w", [ExitPid]),
    {noreply, State};

do_info(_Msg, State) ->
    ?ERROR("unknown req:~w", [_Msg]),
    {noreply, State}.

%% ====================================================================
%% Internal functions
%% ====================================================================

