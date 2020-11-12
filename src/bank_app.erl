-module(bank_app).
-behaviour(application).
-export([start/2, stop/1]).

-include("common.hrl").

start(_Type, _Args) ->
	?CVI("Staart ~p ...", [?MODULE]),

	game_sup:start_link(),

	{ok, self()}.

stop(_State) ->
	?CVI("Stop ~p!", [?MODULE]),
	ok.
