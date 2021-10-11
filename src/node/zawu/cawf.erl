-module(cawf).

-export([
    dawff/1
    , cvto_upper/1
    , get_equipid/2
    , term_to_string/1
    , check_enter_scene_key2/5
    , check_enter_scene_key/0]).

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

check_enter_scene_key() ->
    SceneKey = cvSceneKey,
    SArvgIds = cvSArvgIds,
    CArvgIds = cvCArvgIds,
    SceneNode = erlang:node(),
    FatherKey = {0, 0},
    case catch check_enter_scene_key2(SceneKey, SArvgIds, CArvgIds, SceneNode, FatherKey) of
        {ok, NewSceneKey} ->
            {ok, NewSceneKey};
        {error, Code} ->
            ?CVI("quanfu boss begin error:~w end", [Code]),
            {ok, cddd}
    end.

check_enter_scene_key2(SceneKey, SArvgIds, CArvgIds, SceneNode, FatherKey) ->
    CallMsg = {enter_scene_key, SceneKey, SArvgIds, CArvgIds, erlang:node(), FatherKey},
    Result = util:gen_rpc_call(SceneNode, serv_db_mysql_mgr, CallMsg),
    case Result of
        {ok, NewSceneKey} ->
            {ok, NewSceneKey};
        {error, Code} ->
            ?C2SERR(Code);
        _ ->
            ?C2SERR(aE_REQ_TIMEOUT)
    end.






