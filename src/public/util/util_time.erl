%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 时间公共函数接口
%%%
%%%----------------------------------------------------------------------
-module(util_time).

-include("common.hrl").
-include("time_engine.hrl").

-export([
    now/0
    , now_sec/0
    , now_sec_local/0
    , now_ms/0
    , now_ms_round/1
    , now_ms_no_cache/0
    , now_sec_no_cache/0
    , days/0
    , local_days/0
    , local_time/0
    , local_date/0
    , local_day/0
    , local_month/0
    , local_dow/0
    , local_week_num/0
    , sec_to_week_num/1
    , week_num_to_sec/2
    , now_sec_to_local_time/1
    , local_utc_diff_sec/0
    , local_time_to_now_sec/1
    , localtime_string_time/0
    , localtime_string_time/1
    , localtime_string/0
    , localtime_string/1
    , localtime_string_date/0
    , localtime_string_date/1
    , localtime_string_min/0
    , localtime_string_min/1
    , localtime_string_ms/0
    , localtime_string_ms/1
    , localtime_string_month/0
    , localtime_string_month/1
    , localtime_string_hour_min/0
    , localtime_string_hour_min/1
    , set_now_sec/1
    , set_now_ms/1
    , is_time_in_one_day/1
    , is_time_in_one_day/2
    , is_time_in_one_day_diff/2
    , is_time_in_one_day_diff/3
    , is_time_in_one_week/1
    , is_time_in_one_week_diff/2
    , is_time_in_one_week/2
    , is_time_in_one_week_diff/3
    , is_time_in_one_month/1
    , is_time_in_one_month/2
    , now_sec_to_week_num/1
    , time_diff_in_days/1
    , time_diff_in_days/2
    , today_zero/0
    , tomorrow_zero/0
    , assign_zero/1
    , assign_tomorrow_zero/1
    , assign_five/1
    , assign_tomorrow_five/1
    , generate_day_sec/1
    , generate_minute_sec/1
    , clear_time_cache/0
    , clear_sec_cache/0
    , clear_ms_cache/0
    , all_set_offset/1
    , all_set_offset2/2
    , set_open_time/1
    , set_open_time2/2
    , is_o_clock/1
    , is_ten_min/1
    , next_refresh_sec/1
    , cvnow_sec/0
    , cvnow/0
    , cvnow_sec_local/0
    , cvnow_ms/0
]).

-define(NOW_SEC_CACHE, now_sec_cache).
-define(NOW_MS_CACHE, now_ms_cache).

%% 当前时间
now() ->
    erlang:timestamp().


%% 当前时间(UTC unixtime second) 先读取进程字典里的cache,如果没有则读取wg_time_cache
now_sec() ->
    case erlang:get(?NOW_SEC_CACHE) of
        undefined ->
            util_time:cvnow_sec();
        NowSec ->
            NowSec
    end.

%% 当前时间(local)
now_sec_local() ->
    util_time:cvnow_sec_local().

%% 当前时间(NowMs) 先读取进程字典里的cache,如果没有则读取wg_time_cache
now_ms() ->
    case erlang:get(?NOW_MS_CACHE) of
        undefined ->
            NowMs = util_time:cvnow_ms(),
            now_ms_round(NowMs);
        NowMs ->
            NowMs
    end.

%% 毫秒取整
now_ms_round(NowMs) ->
    NowMs div ?LOOP_EVENT_MS_TIME * ?LOOP_EVENT_MS_TIME.

%% 不是缓存中的当前时间(ms) 建议别使用
now_ms_no_cache() ->
    {A, B, C} = erlang:timestamp(),
    A * 1000000000 + B * 1000 + C div 1000.

now_sec_no_cache() ->
    {A, B, C} = erlang:timestamp(),
    (A * 1000000000 + B * 1000 + C div 1000) div 1000.

%% 当前的日期 1970年以来经历过的天数 此处是标准时间,注意时区问题
days() ->
    util_time:now_sec() div 86400.

%% 获取本地时间的日期 从公元0年开始经历过的天数
local_days() ->
    {Date, _} = local_time(),
    calendar:date_to_gregorian_days(Date).

%% 获取当前本地时间
local_time() ->
    now_sec_to_local_time(util_time:now_sec()).

%% 当前本地日期
local_date() ->
    {D, _} = local_time(),
    D.

%% 今天几日(1-31天)
local_day() ->
    {_Y, _M, D} = local_date(),
    D.

local_month() ->
    {_Y, M, _D} = local_date(),
    M.

%% 今天周几（1-7）
local_dow() ->
    calendar:day_of_the_week(local_date()).

%% now_sec转化成周数
local_week_num() ->
    {_, Num} = calendar:iso_week_number(local_date()),
    Num.

%% 周几(1-7)
sec_to_week_num(Seconds) ->
    {D, _} = now_sec_to_local_time(Seconds),
    calendar:day_of_the_week(D).

%% 转换成周几
week_num_to_sec(Seconds, N) ->
    D1 = sec_to_week_num(Seconds),
    Diff = D1 - N,
    Seconds2 = Seconds - Diff * 86400,
    Seconds2.

%% now_sec转化成local time
now_sec_to_local_time(T) when is_integer(T) ->
    T2 = {T div 1000000, T rem 1000000, 0},
    calendar:now_to_local_time(T2).

%% 计算时区差
local_utc_diff_sec() ->
    L = calendar:local_time(),
    U = calendar:universal_time(),
    %% 计算时区差
    LSecond = calendar:datetime_to_gregorian_seconds(L),
    USecond = calendar:datetime_to_gregorian_seconds(U),
    LSecond - USecond.

%% 日期转化为时间戳
local_time_to_now_sec([Y, M, D, H, MI, S]) ->
    local_time_to_now_sec({{Y, M, D}, {H, MI, S}});
local_time_to_now_sec({_, _} = DateTime) ->
    UtcTime = {{1970, 1, 1}, {0, 0, 0}},
    DateUtcTime = calendar:universal_time_to_local_time(UtcTime),
    Seconds = calendar:datetime_to_gregorian_seconds(DateTime),
    UtcSeconds = calendar:datetime_to_gregorian_seconds(DateUtcTime),
    Seconds - UtcSeconds.

%% 当前时间字符串,时间格式
localtime_string_time() ->
    {Date, Time} = local_time(),
    localtime_string_time({Date, Time}).
localtime_string_time({{Y, Mon, Day}, {H, M, S}}) ->
    io_lib:format(<<"~w-~2..0w-~2..0w ~2..0w:~2..0w:~2..0w">>, [Y, Mon, Day, H, M, S]).

%% 当前时间字符串(写日志调用)
localtime_string() ->
    {Date, Time} = local_time(),
    localtime_string({Date, Time}).
localtime_string({{Year, Month, Day}, {Hour, Min, Sec}}) ->
    lists:flatten(io_lib:format(<<"~w~2..0w~2..0w_~2..0w~2..0w~2..0w">>, [Year, Month, Day, Hour, Min, Sec])).

%% 当前时间字符串(写日志调用)
localtime_string_date() ->
    {Date, Time} = local_time(),
    localtime_string_date({Date, Time}).
localtime_string_date({{Year, Month, Day}, _}) ->
    lists:flatten(io_lib:format(<<"~w~2..0w~2..0w">>, [Year, Month, Day])).

%% 当前时间字符串
localtime_string_min() ->
    {Date, Time} = local_time(),
    localtime_string_min({Date, Time}).
localtime_string_min({{Year, Month, Day}, {Hour, Min, _Sec}}) ->
    lists:flatten(io_lib:format(<<"~w~2..0w~2..0w_~2..0w~2..0w">>, [Year, Month, Day, Hour, Min])).

%% 当前时间字符串
localtime_string_ms() ->
    {Date, Time} = local_time(),
    NowMs = util_time:now_ms() - util_time:now_sec() * 1000,
    localtime_string_ms({Date, Time, NowMs}).
localtime_string_ms({{Year, Month, Day}, {Hour, Min, NowSec}, NowMs}) ->
    lists:flatten(io_lib:format(<<"~w~2..0w~2..0w_~2..0w~2..0w~2..0w~3..0w">>, [Year, Month, Day, Hour, Min, NowSec, NowMs])).

%% 当前时间字符串
%% @doc 返回年月格式  "201805"
localtime_string_month() ->
    {Date, _Time} = local_time(),
    localtime_string_month(Date).
localtime_string_month({Year, Month, _Day}) ->
    lists:flatten(io_lib:format(<<"~w~2..0w">>, [Year, Month])).

%% 当前时间字符串
%% @doc 返回格式 "00:00"
localtime_string_hour_min() ->
    {_Date, Time} = local_time(),
    localtime_string_hour_min(Time).
localtime_string_hour_min({Hour, Min, _NowSec}) ->
    lists:flatten(io_lib:format(<<"~2..0w:~2..0w">>, [Hour, Min])).

%% 设置当时时间cache(NowMs)
set_now_sec(NowSec) ->
    erlang:put(?NOW_SEC_CACHE, NowSec).

%% 设置当时时间cache(NowMs)
set_now_ms(NowMs) ->
    erlang:put(?NOW_MS_CACHE, NowMs).

%% 判断两天是否为同一天
is_time_in_one_day(T) ->
    is_time_in_one_day(T, util_time:now_sec()).

%% 判断两个时间是否为同一天
is_time_in_one_day(T1, T2) ->
    {D1, _} = now_sec_to_local_time(T1),
    {D2, _} = now_sec_to_local_time(T2),
    D1 =:= D2.

%% 扣去一段时间,判断两天是否为同一天
is_time_in_one_day_diff(T, DiffSec) ->
    is_time_in_one_day_diff(T, util_time:now_sec(), DiffSec).

%% 扣去一段时间,判断两个时间是否为同一天
is_time_in_one_day_diff(T1, T2, DiffSec) ->
    DT1 = T1 - DiffSec,
    DT2 = T2 - DiffSec,
    TT1 = ?IF(DT1 > 0, DT1, T1),
    TT2 = ?IF(DT2 > 0, DT2, T2),
    {D1, _} = now_sec_to_local_time(TT1),
    {D2, _} = now_sec_to_local_time(TT2),
    D1 =:= D2.

%% 判断两个时间是否为同一周(以周一来判断)
is_time_in_one_week(T) ->
    is_time_in_one_week(T, util_time:now_sec()).

%% 扣去一段时间,判断两个时间是否为同一周(以周一来判断)
is_time_in_one_week_diff(T, DiffSec) ->
    is_time_in_one_week_diff(T, util_time:now_sec(), DiffSec).

is_time_in_one_week(T1, T2) ->
    D1 = now_sec_to_week_num(T1),
    D2 = now_sec_to_week_num(T2),
    D1 =:= D2.

%% 扣去一段时间,判断两个时间是否为同一周(以周一来判断)
is_time_in_one_week_diff(T1, T2, DiffSec) ->
    DT1 = T1 - DiffSec,
    DT2 = T2 - DiffSec,
    TT1 = ?IF(DT1 > 0, DT1, T1),
    TT2 = ?IF(DT2 > 0, DT2, T2),
    D1 = now_sec_to_week_num(TT1),
    D2 = now_sec_to_week_num(TT2),
    D1 =:= D2.

%% 判断两个时间是否在同一月
is_time_in_one_month(T) ->
    is_time_in_one_month(T, util_time:now_sec()).

is_time_in_one_month(T1, T2) ->
    {{Y1, M1, _}, _} = now_sec_to_local_time(T1),
    {{Y2, M2, _}, _} = now_sec_to_local_time(T2),
    {Y1, M1} =:= {Y2, M2}.

%% now_sec转化成周数
now_sec_to_week_num(0) ->
    0;
now_sec_to_week_num(T) when is_integer(T) ->
    {Date, _Time} = now_sec_to_local_time(T),
    {_, Num} = calendar:iso_week_number(Date),
    Num.

%% 与当前时间相差的天数
time_diff_in_days(T) ->
    time_diff_in_days(T, util_time:now_sec()).
%% 两个时间相差的天数
time_diff_in_days(T1, T2) ->
    {D1, _} = now_sec_to_local_time(T1),
    {D2, _} = now_sec_to_local_time(T2),
    util:abs(calendar:date_to_gregorian_days(D1) - calendar:date_to_gregorian_days(D2)).

%% 今天0点时间戳
today_zero() ->
    {Date, _Time} = local_time(),
    local_time_to_now_sec({Date, {0, 0, 0}}).

%% 明天零点
tomorrow_zero() ->
    {Date, _Time} = local_time(),
    local_time_to_now_sec({Date, {24, 0, 0}}).

%% 操作时间零点
assign_zero(AssignSec) ->
    {Date, _Time} = util_time:now_sec_to_local_time(AssignSec),
    local_time_to_now_sec({Date, {0, 0, 0}}).

%% 操作时间的明天零点
assign_tomorrow_zero(AssignSec) ->
    {Date, _Time} = util_time:now_sec_to_local_time(AssignSec),
    local_time_to_now_sec({Date, {24, 0, 0}}).

%% 操作时间五点
assign_five(AssignSec) ->
    {Date, _Time} = util_time:now_sec_to_local_time(AssignSec),
    local_time_to_now_sec({Date, {5, 0, 0}}).

%% 操作时间是否整点
is_o_clock(AssignSec) ->
    {Date, {T, _, _}} = util_time:now_sec_to_local_time(AssignSec),
    OClockSec = local_time_to_now_sec({Date, {T, 0, 0}}),
    AssignSec =:= OClockSec.

%% 操作时间是否整10分
is_ten_min(AssignSec) ->
    {_Date, {_, M, _}} = util_time:now_sec_to_local_time(AssignSec),
    M rem 10 =:= 0.

%% 操作时间的明天五点
assign_tomorrow_five(AssignSec) ->
    {Date, _Time} = util_time:now_sec_to_local_time(AssignSec),
    local_time_to_now_sec({Date, {29, 0, 0}}).

%% 生成T天后的时间戳
generate_day_sec(T) ->
    T * 24 * 60 * 60.

%% 生成T分钟后的时间戳
generate_minute_sec(T) ->
    T * 60.


%% 清空时间缓存
clear_time_cache() ->
    clear_sec_cache(),
    clear_ms_cache().

%% 清空单进程秒缓存
clear_sec_cache() ->
    erlang:erase(?NOW_SEC_CACHE).

%% 清空单进程毫秒缓存
clear_ms_cache() ->
    erlang:erase(?NOW_MS_CACHE).


%% 设置时间误差
all_set_offset(Offset) ->
    NodeList = [node()],
    all_set_offset2(NodeList, Offset).

all_set_offset2([], _Offset) ->
    next;
all_set_offset2([Node | TNodes], Offset) ->
    ok = rpc:call(Node, wg_time_cache, set_offset_once, [Offset]),
    all_set_offset2(TNodes, Offset).

%% 设置开服时间
set_open_time(OpenTime) ->
    NodeList = [node()],
    set_open_time2(NodeList, OpenTime).

set_open_time2([], _OpenTime) ->
    next;
set_open_time2([Node | TNodes], OpenTime) ->
    ok = rpc:call(Node, wg_time_cache, update_open_time, [OpenTime]),
    all_set_offset2(TNodes, OpenTime).

%% 根据整点列表获取下次刷新时间
next_refresh_sec(RestoreTime) ->
    NowSec = util_time:now_sec(),
    RestoreSecs = all_restore_secs(RestoreTime),
    next_refresh_sec2(RestoreSecs, NowSec).

next_refresh_sec2([RestoreSec | RestoreSecs], NowSec) ->
    case NowSec > RestoreSec of
        true ->
            next_refresh_sec2(RestoreSecs, NowSec);
        _ ->
            RestoreSec
    end.

all_restore_secs(RestoreTime) ->
    YesterDayZeroSec = util_time:today_zero() - ?ONE_DAY,
    YesterDaySecs = [YesterDayZeroSec + I * ?ONE_HOUR || I <- RestoreTime],

    TodayZeroSec = util_time:today_zero(),
    TodaySecs = [TodayZeroSec + I * ?ONE_HOUR || I <- RestoreTime],

    TomorrowZeroSec = util_time:tomorrow_zero(),
    TomorrowSecs = [TomorrowZeroSec + I * ?ONE_HOUR || I <- RestoreTime],

    YesterDaySecs ++ TodaySecs ++ TomorrowSecs.

%% ==============================================================================
cvnow() ->
    Offset = 0,
    {Mega, Sec, Micro} = os:timestamp(),
    Sec2 = Sec + Offset,
    Now =
        if
            Sec2 >= 10000000 ->
                {Mega + 1, Sec2 - 1000000, Micro};
            Sec2 < 0 ->
                {Mega - 1, Sec2 + 1000000, Micro};
            true ->
                {Mega, Sec2, Micro}
        end,
    NowSec = Mega * 1000000 + Sec + Offset,
    NowMs = NowSec * 1000 + Micro div 1000,
    NowSecLocal = local_time_to_now_sec(NowSec),
    ok = tttqqq(Now, NowSec, NowMs, NowSecLocal),
    Now.

cvnow_sec() ->
    Offset = 0,
    {Mega, Sec, Micro} = os:timestamp(),
    Sec2 = Sec + Offset,
    Now =
        if
            Sec2 >= 10000000 ->
                {Mega + 1, Sec2 - 1000000, Micro};
            Sec2 < 0 ->
                {Mega - 1, Sec2 + 1000000, Micro};
            true ->
                {Mega, Sec2, Micro}
        end,
    NowSec = Mega * 1000000 + Sec + Offset,
    NowMs = NowSec * 1000 + Micro div 1000,
    NowSecLocal = local_time_to_now_sec(NowSec),
    ok = tttqqq(Now, NowSec, NowMs, NowSecLocal),
    NowSec.

cvnow_sec_local() ->
    Offset = 0,
    {Mega, Sec, Micro} = os:timestamp(),
    Sec2 = Sec + Offset,
    Now =
        if
            Sec2 >= 10000000 ->
                {Mega + 1, Sec2 - 1000000, Micro};
            Sec2 < 0 ->
                {Mega - 1, Sec2 + 1000000, Micro};
            true ->
                {Mega, Sec2, Micro}
        end,
    NowSec = Mega * 1000000 + Sec + Offset,
    NowMs = NowSec * 1000 + Micro div 1000,
    NowSecLocal = local_time_to_now_sec(NowSec),
    ok = tttqqq(Now, NowSec, NowMs, NowSecLocal),
    NowSecLocal.

cvnow_ms() ->
    Offset = 0,
    {Mega, Sec, Micro} = os:timestamp(),
    Sec2 = Sec + Offset,
    Now =
        if
            Sec2 >= 10000000 ->
                {Mega + 1, Sec2 - 1000000, Micro};
            Sec2 < 0 ->
                {Mega - 1, Sec2 + 1000000, Micro};
            true ->
                {Mega, Sec2, Micro}
        end,
    NowSec = Mega * 1000000 + Sec + Offset,
    NowMs = NowSec * 1000 + Micro div 1000,
    NowSecLocal = local_time_to_now_sec(NowSec),
    ok = tttqqq(Now, NowSec, NowMs, NowSecLocal),
    NowMs.

tttqqq(_Now, _NowSec, _NowMs, _NowSecLocal) ->
    ok.