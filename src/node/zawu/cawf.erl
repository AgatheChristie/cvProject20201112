-module(cawf).

-export([
    dawff/1
    , cvto_upper/1
    , get_equipid/2
    , term_to_string/1
    ]).

-include("user_info.hrl").
-include("goods_info.hrl").
-include("common.hrl").

%%mnesia:create_schema([node()]).
%%cawf:dawff(1000).
dawff(ItemCoin1) ->
    A = lists:duplicate(5, "Elem"),

    {awf, A, ItemCoin1}.


%%cawf:cvto_upper("common").
cvto_upper(Str) ->
    string:to_upper(Str).


%%cawf:get_equipid(56,1).
get_equipid(MaxSectionId, _SectionId) ->

    MaxSectionId.



%%cawf:term_to_string([49]).
%% 将term转化为string
%% 如[1, 2]转化为"[1,2]"
term_to_string(Term) ->
    lists:flatten(io_lib:format("~w", [Term])).









