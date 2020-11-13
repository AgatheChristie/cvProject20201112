%% coding: latin-1


-module(util_app).

-include("common.hrl").

-export([
    start_self_apps/0
    , ensure_started/1
    , start_apps/1
    , stop_apps/1
    , manage_apps/6
    , is_app_running/1
]).

%% 确保自带的app启动
start_self_apps() ->
    %% erlang自带的httpd server
    ok = util_app:ensure_started(inets),
    ok = util_app:ensure_started(crypto),
    ok = util_app:ensure_started(asn1),
    ok = util_app:ensure_started(public_key),
    %% erlang安全套接层启动
    ok = util_app:ensure_started(ssl),
    ok.

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ?CVI("ddaf"),
            ok
    end.

%% 启动app列表
start_apps(Apps) ->
    manage_apps(fun lists:foldl/3,
        fun application:start/1,
        fun application:stop/1,
        already_started,
        cannot_start_app,
        Apps).

%% 停止app列表
stop_apps(Apps) ->
    manage_apps(fun lists:foldr/3,
        fun application:stop/1,
        fun application:start/1,
        not_started,
        cannot_stop_app,
        Apps).

%% 管理app列表
manage_apps(Iterate, Do, Undo, SkipError, ErrorTag, Apps) ->
    Iterate(fun(App, Acc) ->
        case Do(App) of
            ok ->
                [App | Acc];
            {error, {SkipError, _}} ->
                Acc;
            {error, Reason} ->
                lists:foreach(Undo, Acc),
                throw({error, {ErrorTag, App, Reason}});
            _ ->
                throw({error, {ErrorTag, App, ""}})
        end
            end, [], Apps),
    ok.


%% 某个app是否运行中
is_app_running(Apps) when is_list(Apps) ->
    lists:all(fun is_app_running/1, Apps);
is_app_running(App) when is_atom(App) ->
    case lists:keyfind(App, 1, application:which_applications()) of
        false ->
            false;
        _ ->
            true
    end.