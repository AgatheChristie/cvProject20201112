%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 打印日志
%%%  
%%%----------------------------------------------------------------------
-module(util_error_msg).

-include("common.hrl").
-include("log.hrl").

-export([
     write_error_log/2
    , write_error_log/1
    , write_error_log_test/1
]).

%% 写日志
write_error_log(Name, LogDataList) ->
    NowDate = calendar:now_to_local_time(util_time:now()),
    {ok, CurrentDirectory} = file:get_cwd(),
    RunLogDir = CurrentDirectory ++ "/cvSelfLogs",
    case true of
        true ->
            AllTime = "all",
            AllName2 = lists:concat([Name, '_', AllTime, '.', log]),
            AllRunLogFile = filename:join([RunLogDir, AllName2]),
            ok = file:write_file(AllRunLogFile, LogDataList, [append, delayed_write]);
        false ->
            next
    end,
    Time = util_time:localtime_string_date(NowDate),
    Name2 = lists:concat([Name, '_', Time, '.', log]),
    RunLogFile = filename:join([RunLogDir, Name2]),
    ok = file:write_file(RunLogFile, LogDataList, [append, delayed_write]),
    ok.

%% 写入报错 log,在每一个打印的时候调用
write_error_log({_Type, _GroupLeader, {_Pid, Format, Args}}) ->
    LogData = io_lib:format(Format, Args),
    NowSec = calendar:now_to_local_time(util_time:now()),
    LogFile = ?COMMON_ERROR_FILE,
    case false of
        true ->
            LogDataList = ["[", util_time:localtime_string_time(NowSec), "]", "[", ?A2S(node()), "] ", LogData],
            util_error_msg:write_error_log(LogFile, LogDataList);
        false ->
            LogDataList = ["[", util_time:localtime_string_time(NowSec), "]", LogData],
            util_error_msg:write_error_log(LogFile, LogDataList)
    end.

%% 写入报错 log,在每一个打印的时候调用
write_error_log_test({_Type, _GroupLeader, {_Pid, Format, Args}}) ->
    LogData = io_lib:format(Format, Args),
    NowSec = calendar:now_to_local_time(util_time:now()),
    LogFile = ?COMMON_ERROR_TEST_FILE,
    LogDataList =
        case false of
            true ->
                ["[", util_time:localtime_string_time(NowSec), "]", "[", ?A2S(node()), "] ", LogData];
            false ->
                ["[", util_time:localtime_string_time(NowSec), "]", LogData]
        end,
    util_error_msg:write_error_log(LogFile, LogDataList).
