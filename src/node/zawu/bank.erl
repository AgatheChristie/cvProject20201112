-module(bank).
-export([start/0, start_server/0, stop/0]).
-include("common.hrl").

start_server() ->
    ?ERROR("Start App:~p end", [cvserver]),
    net_adm:ping('cvnice@192.168.1.13'),
    %% net_adm:ping('cvbank@192.168.1.197'),
    application:start(cvserver).



start() ->
    ?ERROR("Start ~p All APP!", [?MODULE]),
    db_mysql:start().
%%    game:start().


stop() ->
    ?ERROR("Stop ~p All APP!", [?MODULE]),
    db_mysql:stop().
%%    game:stop().