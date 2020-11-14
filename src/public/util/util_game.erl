%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 游戏内公共函数接口
%%%
%%%----------------------------------------------------------------------
-module(util_game).

-include("common.hrl").


-export([
    start_child/2
    , set_terminate_reason/1
    , get_terminate_reason/0
]).

%% 启动某个子服务
start_child(Sup, Child) ->
    case catch supervisor:start_child(Sup, Child) of
        {ok, _Pid} ->
            ok;
        {error, {already_started, _Pid}} ->
            ok;
        Other ->
            ?CVI(">>>>~p\n", [Other]),
            throw(Other)
    end.

%% 设置结束原因(不使用exit(Reason),为了防止sasl报告)
set_terminate_reason(Reason) ->
    erlang:put(terminate_reason, Reason).

%% 获取结束原因
get_terminate_reason() ->
    erlang:get(terminate_reason).



