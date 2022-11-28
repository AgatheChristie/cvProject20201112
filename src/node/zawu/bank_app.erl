-module(bank_app).
-behaviour(application).
-export([start/2, stop/1]).

-include("common.hrl").

start(_Type, _Args) ->
	?ERROR("Start ~p ...", [?MODULE]),

	bank_sup:start_link(),

	{ok, self()}.

stop(_State) ->
	?ERROR("Stop ~p!", [?MODULE]),
	ok.
