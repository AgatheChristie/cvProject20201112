%% coding: latin-1

-module(db_mysql_sup).
-include("common.hrl").
-include("app.hrl").


-behaviour(supervisor).

-export([
    init/1,
    start_link/0
]).

%% 启动监督树
start_link() ->
    {ok, Sup} = supervisor:start_link({local, ?MODULE}, ?MODULE, []),


    ok = util_db_mysql_sup:start_db_mysql_sup(Sup),




    ?CVI("ddw Sup = ~w", [Sup]),

    {ok, Sup}.

%% sup 初始化
init([]) ->
    {ok, {{one_for_one, 10, 10}, []}}.

%% ====================================================================
%% Include functions
%% ====================================================================
