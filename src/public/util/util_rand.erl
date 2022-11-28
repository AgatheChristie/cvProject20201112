%% coding: latin-1

-module(util_rand).

-include("common.hrl").
-include("app.hrl").

-export([
    seed/0
    , rand/0
    , rand/1
    , rand/2
    , rand_negative/1
    , rand_negative/2
    , rand_from_list/2
    , rand_from_list/3
    , tail_rand_from_list/2
    , tail_rand_from_list/3
    , rand_hundred/1
    , rand_is_succ/1
]).

%% 随机种子
seed() ->
    rand:seed(exrop).

%% 返回1-10000之间的一个数字
rand() ->
    rand(?PROB_FULL).

%% 返回一个随机数util_rand:rand([1,N]),结果为:[1,N]
rand([]) ->
    0;
rand([N]) ->
    N;
rand([N, M]) ->
    rand(N, M);

%% 返回一个随机数,结果为:[0,N]中的随机一个数
rand(0) ->
    0;
rand(N) when N > 0 ->
    rand:uniform(N).

%% 返回两个数之间的随机数util_rand:rand(1,N),结果为:[1,N]中的随机一个数
rand(Min, Min) when Min >= 0 ->
    Min;
rand(Min, Max) when Min >= 0 andalso Max > Min ->
    util_rand:rand(Max - Min + 1) + Min - 1.

%% 支持负数到正数范围随机
rand_negative([Min, Max]) ->
    rand_negative(Min, Max).
rand_negative(Min, Max) when Min < 0 andalso Max >= 0 ->
    util_rand:rand(0, Max - Min) + Min;
rand_negative(Min, Max) when Min < 0 andalso Max < 0 andalso Min =< Max ->
    util_rand:rand(0, Max - Min) + Min;
rand_negative(Min, Max) ->
    util_rand:rand(Min, Max).

%% 从列表中随机N个
rand_from_list(Num, List) ->
    rand_from_list(Num, List, []).

rand_from_list(0, _List, Ret) ->
    Ret;
rand_from_list(_Num, [], Ret) ->
    Ret;
rand_from_list(Num, List, Ret) ->
    Len = length(List),
    N = rand(Len),
    Obj = lists:nth(N, List),
    rand_from_list(Num - 1, lists:delete(Obj, List), [Obj | Ret]).

%% 从列表中随机N个
tail_rand_from_list(Num, List) ->
    tail_rand_from_list(Num, List, []).

tail_rand_from_list(0, List, Ret) ->
    {Ret, List};
tail_rand_from_list(_Num, [], Ret) ->
    {Ret, []};
tail_rand_from_list(Num, List, Ret) ->
    Len = length(List),
    N = rand(Len),
    Obj = lists:nth(N, List),
    tail_rand_from_list(Num - 1, lists:delete(Obj, List), [Obj | Ret]).

%% 判断百分比随机
rand_hundred(Ratio) when Ratio >= ?ONE_HUNDRED ->
    ?SYS_TRUE;
rand_hundred(Ratio) ->
    ?IF(rand(?ONE_HUNDRED) =< Ratio, ?SYS_TRUE, ?SYS_FALSE).

%% 判断万分比成功率
rand_is_succ(Rate) ->
    Random = rand(?TEN_THOUSAND),
    ?IF(Rate >= Random, ?SYS_TRUE, ?SYS_FALSE).