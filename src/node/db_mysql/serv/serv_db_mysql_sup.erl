%% coding: latin-1
%%%----------------------------------------------------------------------
%%%  zhanglei
%%%  2016.05.04
%%%  游戏timer驱动器,一个timer驱动多个进程
%%%
%%%----------------------------------------------------------------------
-module(serv_db_mysql_sup).
-behaviour(supervisor).

-include("common.hrl").

-export([init/1, start_link/0]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    AChild = {serv_db_mysql,
        {serv_db_mysql, start_link, []},
        transient,
        30000,
        worker,
        [serv_db_mysql]
    },
    {ok, {{simple_one_for_one, 10, 10}, [AChild]}}.