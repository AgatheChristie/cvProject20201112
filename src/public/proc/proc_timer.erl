%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.08.04
%%% 进程内timer模块,基于进程字典实现
%%% 当time循环触发时,根据Ref List获取
%%% 所有的timer(进程字典,key为Ref)是否需要触发,如果触发
%%% 则调用Mod:handle_timeout/2处理
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(proc_timer).
-include("common.hrl").

-export([
    start_timer/3
    , start_timer/4
    , read_timer/1
    , cancel_timer/1
    , on_timeout_loop/1
    , timer_list/0
    , do_add_timer/4
    , do_get_timer_remain/1
    , do_delete_timer/1
    , do_get_timer_list/0
    , do_set_timer_list/1
    , do_invoke_timeout/4
]).

%% timer ref 列表
-define(TIMER_LIST_KEY, proc_timer_list).
%% timer 对应的key
-define(TIMER_REF_KEY(Ref), {proc_timer_ref, Ref}).

%% 数据
-record(timer_data, {
    mod = "",                              %% 回调模块
    time = 0,                              %% timer时间
    msg = "",                              %% 对应的msg
    loop = flase,                          %% 是否循环
    invoke_time = 0                        %% 触发时间
}).

%% 开始timer
start_timer(Mod, Time, Msg) ->
    start_timer(Mod, Time, Msg, false).

%% 开始timer
start_timer(Mod, Time, Msg, Loop) ->
    do_add_timer(Mod, Time, Msg, Loop).

%% 读取timer剩余时间
read_timer(Ref) ->
    do_get_timer_remain(Ref).

%% 取消timer
cancel_timer(Ref) when is_reference(Ref) ->
    do_delete_timer(Ref);
cancel_timer(_) ->
    ok.

%% 执行timer逻辑
on_timeout_loop(State) ->
    NowMs = util_time:now_ms(),
    List = do_get_timer_list(),
    Fun =
        fun(Ref, StateAcc) ->
            TimerData = erlang:get(?TIMER_REF_KEY(Ref)),
            #timer_data{
                invoke_time = InvokeTime
            } = TimerData,
            case InvokeTime =< NowMs of
                true ->
                    %% 时间到了执行
                    do_invoke_timeout(Ref, TimerData, NowMs, StateAcc);
                false ->
                    StateAcc
            end
        end,
    State2 = lists:foldl(Fun, State, List),
    {ok, State2}.

%% 获取timer列表
timer_list() ->
    [erlang:get(?TIMER_REF_KEY(Ref)) || Ref <- do_get_timer_list()].

%% 添加timer
do_add_timer(Mod, Time, Msg, Loop) ->
    Ref = erlang:make_ref(),
    NowMs = util_time:now_ms(),
    InvokeTime = NowMs + Time,
    TimerData =
        #timer_data{
            mod = Mod,
            time = Time,
            msg = Msg,
            loop = Loop,
            invoke_time = InvokeTime
        },
    do_set_timer_list([Ref | do_get_timer_list()]),
    erlang:put(?TIMER_REF_KEY(Ref), TimerData),
    Ref.

%% 获取timer剩余时间
do_get_timer_remain(RefKey) ->
    case erlang:get(?TIMER_REF_KEY(RefKey)) of
        undefined ->
            ?NONE;
        #timer_data{invoke_time = TimeMs} ->
            NowMs = util_time:now_ms(),
            RemainMs = TimeMs - NowMs,
            ?IF(RemainMs >= 0, RemainMs, false)
    end.

%% 删除timer
do_delete_timer(Ref) ->
    do_set_timer_list(lists:delete(Ref, do_get_timer_list())),
    erlang:erase(?TIMER_REF_KEY(Ref)),
    ok.

%% 获取timer list
do_get_timer_list() ->
    case erlang:get(?TIMER_LIST_KEY) of
        undefined ->
            [];
        List ->
            List
    end.

%% 设置timer list
do_set_timer_list(List) ->
    erlang:put(?TIMER_LIST_KEY, List).

%% 执行timeout
do_invoke_timeout(Ref, TimerData, Now, State) ->
    #timer_data{
        mod = Mod,
        msg = Msg,
        time = Time,
        loop = Loop
    } = TimerData,
    try
        State2 =
            case Mod:handle_timeout(Msg, State) of
                ok ->
                    State;
                {ok, State2_1} ->
                    State2_1;
                State2_1 ->
                    State2_1
            end,
        case Loop of
            false ->
                do_delete_timer(Ref);
            true ->
                TimerData2 = TimerData#timer_data{invoke_time = Now + Time},
                erlang:put(?TIMER_REF_KEY(Ref), TimerData2)
        end,
        State2
    catch
        _T:_R:_S ->
            ?ERROR(":~w timeout:~w err~p:~p ~p", [Mod, Msg, _T, _R, _S]),
            do_delete_timer(Ref),
            State
    end.
