-module(cawf).

-compile(export_all).

-include("user_info.hrl").
-include("goods_info.hrl").
-include("tab.hrl").
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
            ?ERROR("quanfu boss begin error:~w end", [Code]),
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


%% 同步保存游戏结算信息
replace(GameWinInfo) ->
    #game_win_info{id = _Id} = GameWinInfo,

    util_db:assign_write_sync(db_game_win, replace, GameWinInfo, ?DB_GAME_POOL).

%% 异步保存游戏结算数据
save(GameWinInfo) ->
    #game_win_info{id = _Id} = GameWinInfo,

    util_db:assign_write_sync(db_game_win, update, GameWinInfo, ?DB_GAME_POOL).

%% 同步保存游戏结算数据
save_once(GameWinInfo) ->
    #game_win_info{id = _Id} = GameWinInfo,

    util_db:assign_write_sync(db_game_win, update, GameWinInfo, ?DB_GAME_POOL).

%% 同步增加游戏结算数据
add_once(GameWinInfo) ->
    #game_win_info{id = _Id} = GameWinInfo,

    util_db:assign_write_sync(db_game_win, add, GameWinInfo, ?DB_GAME_POOL).

%% 同步增加游戏结算数据
cvadd_once(Id) ->
    GameWinInfo = #game_win_info{
        id = Id,
        icon_id = 3,
        win_flag = 646,
        game_win_status = 1456,
        touch_sec = 346
    },
    util_db:assign_write_sync(db_game_win, add, GameWinInfo, ?DB_GAME_POOL).

%% 同步删除游戏结算数据
del_once(Id) ->

    util_db:assign_delete_sync(db_game_win, delete, [Id], ?DB_GAME_POOL).

%% 查找游戏结算
select(Id) ->

    util_db:assign_select_sync(db_game_win, select, [Id], ?DB_GAME_POOL).

%% 查找所有游戏结算
list() ->
    util_db:select_sync(db_game_win, list, []).

%% 查询最大id
select_max_id() ->
    util_db:select_sync(db_game_win, select_max_id, []).



%% 指定同步写入操作
awdwrite_sync(DbNode) ->
    DbNode2 = node(),
    ?DB_GAME_POOL = 1,
    {NodeType, _DDbNode} = util_db:assign_db_mysql_info(),
    MysqlServName = util_db_mysql_serv:db_mysql_serv_name(?DB_GAME_POOL),
    CallMsg = {aawrite_sync},
    case catch util:gen_rpc_call(DbNode2, MysqlServName, CallMsg, 10000) of
        ok ->
            util_db:delete_db_node_info(NodeType, DbNode),
            ok;
        _Reason ->
            ?ERROR("aawf:~w ~w", [qwd, _Reason]),
            util_db:delete_db_node_info(NodeType, DbNode),
            _Reason
    end.


