%% coding: latin-1

-module(serv_db_mysql_sup).
-behaviour(supervisor).

-include("common.hrl").

-export([init/1, start_link/0]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    AChild = {server_example,
        {server_example, start_link, []},
        transient,
        30000,
        worker,
        [server_example]
    },
    {ok, {{simple_one_for_one, 10, 10}, [AChild]}}.