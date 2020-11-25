%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 时间公共函数接口
%%%
%%%----------------------------------------------------------------------
-module(util_time).

-include("common.hrl").
-include("time_engine.hrl").

-export([
    set_now_sec/1
    , set_now_ms/1]).

-define(NOW_SEC_CACHE, now_sec_cache).
-define(NOW_MS_CACHE, now_ms_cache).



%% 设置当时时间cache(NowMs)
set_now_sec(NowSec) ->
    erlang:put(?NOW_SEC_CACHE, NowSec).

%% 设置当时时间cache(NowMs)
set_now_ms(NowMs) ->
    erlang:put(?NOW_MS_CACHE, NowMs).
