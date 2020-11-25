-module(bank).
-export([start/0, start_server/0, stop/0]).
-include("common.hrl").

start_server() ->
    ?CVI("Start App:~p end", [cvserver]),
    net_adm:ping('cvnice@192.168.20.89'),
    application:start(cvserver).



start() ->
    ?CVI("Start ~p All APP!", [?MODULE]),
    db_mysql:start().
%%    game:start().


stop() ->
    ?CVI("Stop ~p All APP!", [?MODULE]),
    db_mysql:stop().
%%    game:stop().