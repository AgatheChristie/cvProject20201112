-module(bank_sup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).
-include("common.hrl").
%% 定义一个启动本监督树的API
start_link() ->
    ?CVI("start_link start_link"),
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    ?CVI("init init"),
    %% 启动2个子进程
    BankCenterSpec = {
      center %% 指定本进程(在子进程中唯一)的名称
      ,{server_example, start_link, []} %% 进程启动函数：{M,F,A}
      ,permanent %% 重启策略：permanent | transient | temporary
      ,5000 %% 关闭方式：brutal_kill | int()>0 | infinity
      ,worker %% 进程类型：worker 或 supervisor
      ,[server_example] %% 回调模块名称：[Module] | dynamic
     },

    %% {ok, {{RestartStrategy, MaxR, MaxT}, [ChildSpec]}}
    {ok, {{one_for_one, 5, 60}, [BankCenterSpec]}}.
