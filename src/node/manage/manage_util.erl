%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.06.14
%%% 游戏启动模块接口
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(manage_util).

-include("common.hrl").
-include("app.hrl").

-export([
	stop_server/1
	, only_stop_server/1
	, do_stop_server/0
]).

%% 同步停止,立刻停止
stop_server(true) ->
	manage:stop(),
	{ok, ?STATUS_SUCCESS};
%% 异步通知 倒计时1分钟后停止服务器
stop_server(false) ->
	timer:apply_after(60 * 1000, ?MODULE, stop_server, [true]),
	{ok, ?STATUS_SUCCESS}.

%% 单独停止,立刻停止
only_stop_server(true) ->
	manage:only_stop(),
	{ok, ?STATUS_SUCCESS};
%% 异步通知 倒计时1分钟后停止服务器
only_stop_server(false) ->
	timer:apply_after(60 * 1000, ?MODULE, stop_server, [true]),
	{ok, ?STATUS_SUCCESS}.

%% 停止游戏
do_stop_server() ->
	%% 被动结束进程,simple_one_for_one启动的进程并不能完成执行terminate
	%% 系统停止时(init:stop erlang:halt),会依次停止所有的进程
	%% 如果一个进程是监控树,则该监控树会先依次停止所有的子进程,然后结束自己
	%% 对于子进程也是同样的处理方法。
	init:stop().

%% %% 设置版本信息,写入文件
%% set_version_info() ->
%%     try
%%         {ok, DbVersion} = util_db:db_version(),
%%         Str = ["db:", DbVersion, "\n", "code:", util_game:get_server_code_version(), "\n"],
%%         VersionFile = util_path:run_log_file("version.txt"),
%%         ok = file:write_file(VersionFile, Str)
%%     catch
%%         _T:_R ->
%%             ?ERROR(?_U("写入version.txt失败 ~w:~w"), [_T, _R])
%%     end.
