-module(cvserver_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, Sup} = cvserver_sup:start_link(),
    manage:start(),
    {ok, Sup}.

stop(_State) ->
    manage:stop(),
    ok.
