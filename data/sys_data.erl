%% coding: latin-1

-module(sys_data).
-include("common.hrl").
-include("goods_info.hrl").
-export([get/1, get/2, is_has/1, list/0]).

get(1) -> {sys_data,1};
get(_Id) -> ?ERROR("data not exist:~p", [_Id]), throw({error, 20}).
get(ML,Id) -> case catch sys_angle_group:get(Id) of #goods{} = T -> T; _ ->?ERROR("function data info:~w ~p", [ML,Id]),throw({error, 20}) end.
is_has(Id) -> case lists:member(Id, list()) of true -> sys_angle_group:get(Id); false -> false end.
list() -> [1].
