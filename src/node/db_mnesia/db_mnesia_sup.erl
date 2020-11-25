%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.07.19
%%% mnesia缓存监督树
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(db_mnesia_sup).

-include("common.hrl").
-include("app.hrl").
-include("node.hrl").

-behaviour(supervisor).

-export([
    init/1,
    start_link/0
]).

%% 启动监督树
start_link() ->
    {ok, Sup} = supervisor:start_link({local, ?MODULE}, ?MODULE, []),




    ?CVI("mnesia缓存 Sup = ~w", [Sup]),
    {ok, Sup}.

%% sup 初始化
init([]) ->
    {ok, {{one_for_one, 10, 10}, []}}.

%% ====================================================================
%% Include functions
%% ====================================================================

