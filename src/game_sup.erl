-module(game_sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).
-include("common.hrl").
%% 定义一个启动本监督树的API
start_link() ->
    ?CVI("start_link start_link"),
    {ok, Sup} = supervisor:start_link({local, ?MODULE}, ?MODULE, []),

%% 消息中间件监控树
    ok = util_game:start_child(Sup, {bank_sup, {bank_sup, start_link, []},
        permanent, infinity, supervisor, []}),


%%    %% 玩家分组监控树
%%    ok = util_game:start_child(Sup, {serv_role_group_sup, {serv_role_group_sup, start_link, []},
%%        permanent, infinity, supervisor, []}),
%%
%%    %% 玩家分组管理进程
%%    ok = util_game:start_child(Sup, {serv_role_group_mgr, {serv_role_group_mgr, start_link, []},
%%        permanent, 30000, worker, [serv_role_group_mgr]}),

    {ok, Sup}.
init([]) ->

    {ok, {{one_for_one, 10, 10}, []}}.
