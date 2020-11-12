-module(bank).
-export([start/0]). 
-include("common.hrl").

start() ->
    ?CVI("Start ~p ...", [?MODULE]),
    application:start(bank).
