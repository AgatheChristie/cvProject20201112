%% coding: latin-1

-module(serv_role_group).

-include("common.hrl").


%% gen_server


-export([start_link/1, init/1]).

-record(state, {
    group_id = 0
}).

%% ====================================================================
%% Api functions
%% ====================================================================
%% 启动
start_link(GroupId) ->

    gen_server:start_link({local, ?MODULE}, ?MODULE, [GroupId], []).

%% ====================================================================
%% gen_server callbacks
%% ====================================================================
%% 初始化
init([GroupId]) ->
    erlang:process_flag(trap_exit, true),
    State = #state{group_id =  GroupId},

    {ok, State}.
