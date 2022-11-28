%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 自定义日志输出
%%%
%%%----------------------------------------------------------------------

-module(wg_logger_self).

-export([
    verbose_msg/4,
    debug_msg/4,
    info_msg/4,
    warning_msg/4,
    error_msg/4,
    critical_msg/4
]).

%% Helper functions
verbose_msg(Module, Line, Format, Args) ->
    notify(info_msg, "<V>(~p:~p:~p) : " ++ Format ++ "</V>~n", [self(), Module, Line] ++ Args).

debug_msg(Module, Line, Format, Args) ->
    notify(info_msg, "<D>(~p:~p:~p) : " ++ Format ++ "</D>~n", [self(), Module, Line] ++ Args).

info_msg(Module, Line, Format, Args) ->
    notify(info_msg, "<I>(~p:~p:~p) : " ++ Format ++ "</I>~n", [self(), Module, Line] ++ Args).

warning_msg(Module, Line, Format, Args) ->
    notify(error, "<W>(~p:~p:~p) : " ++ Format ++ "</W>~n", [self(), Module, Line] ++ Args).

error_msg(Module, Line, Format, Args) ->
    notify(error, "<E>(~p:~p:~p) : " ++ Format ++ "</E>~n", [self(), Module, Line] ++ Args).

critical_msg(Module, Line, Format, Args) ->
    notify(error, "<C>(~p:~p:~p) : " ++ Format ++ "</C>~n", [self(), Module, Line] ++ Args).

%% Distribute the message to the Erlang error logger
notify(Type, Format, Args) ->
    LoggerMsg = {Type, group_leader(), {self(), Format, Args}},
    util_error_msg:write_error_log_test(LoggerMsg).