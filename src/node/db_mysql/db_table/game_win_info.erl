%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @author: taiqi
%%% @doc: （自动生成,请勿编辑!)
%%%
%%%----------------------------------------------------------------------
-module(game_win_info).

-export([
    fields/0
    , to_term/1
    , to_binary/1
    , to_row/1
    , to_row/2
    , to_rec/1
    , to_rec_list/1
    , to_rec_t/1
    , to_rec_list_t/1
    , insert/3
    , insert_next/3
    , delete/3
    , select/2
    , select/3
    , select/4
    , select/5
    , select/6
    , select/7
    , update/3
    , update/4
    , update/5
    , replace/3
    , first_tab/0
    , assign_tab/2
]).

fields() -> 
    ["id", "icon_id", "win_flag", "game_win_status", "touch_sec"].

to_term(<<>>) -> none; to_term(Binary) -> binary_to_term(Binary).

to_binary(none) -> <<>>; to_binary('_') -> '_'; to_binary(['_' | _T]) -> '_'; to_binary(Term) -> term_to_binary(Term).

to_row(Val) -> 
    to_row(Val, false).
to_row({game_win_info, ID, ICON_ID, WIN_FLAG, GAME_WIN_STATUS, TOUCH_SEC}, _Loop) -> 
    [ID, ICON_ID, WIN_FLAG, GAME_WIN_STATUS, TOUCH_SEC];
to_row('_', _Loop) -> 
    ['_', '_', '_', '_', '_'];
to_row(none, false) -> 
    [0, 0, 0, 0, 0];
to_row(none, true) -> 
    none;
to_row(L, Loop) when erlang:is_list(L) -> [ to_row(R, Loop) || R <- L ].

to_rec([0, 0, 0, 0, 0]) -> 
	 {game_win_info, 0, 0, 0, 0, 0};
to_rec([ID, ICON_ID, WIN_FLAG, GAME_WIN_STATUS, TOUCH_SEC]) -> 
    {game_win_info, ID, ICON_ID, WIN_FLAG, GAME_WIN_STATUS, TOUCH_SEC}.

to_rec_list(none) -> [];
to_rec_list(LL) -> [ to_rec(L) || L <- LL ].

to_rec_t([0, 0, 0, 0, 0]) -> 
	   {game_win_info, 0, 0, 0, 0, 0};
to_rec_t([ID, ICON_ID, WIN_FLAG, GAME_WIN_STATUS, TOUCH_SEC]) -> 
    {game_win_info, ID, ICON_ID, WIN_FLAG, GAME_WIN_STATUS, TOUCH_SEC}.

to_rec_list_t(none) -> [];
to_rec_list_t(LL) -> [ to_rec_t(L) || L <- LL ].

insert(PoolId, Tab, Rec) when erlang:is_tuple(Rec) ->
    case util_db_handle:insert(PoolId, Tab, fields(), to_row(Rec)) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

insert_next(PoolId, Tab, Rec) when erlang:is_tuple(Rec) ->
    case util_db_handle:insert_next(PoolId, Tab, fields(), to_row(Rec)) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

delete(PoolId, Tab, Id) when erlang:is_integer(Id) ->
    delete(PoolId, Tab, ["Id=", mysql:encode(Id)]);
delete(PoolId, Tab, Where) ->
    case util_db_handle:delete(PoolId, Tab, Where) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

select(PoolId, Tab) ->
    select(PoolId, Tab, fields(), "", true).
select(PoolId, Tab, Id) when erlang:is_integer(Id) ->
    select(PoolId, Tab, ["id=", mysql:encode(Id)]);
select(PoolId, Tab, Where) ->
    select(PoolId, Tab, fields(), Where, true).
select(PoolId, Tab, Fields, Where) ->
    select(PoolId, Tab, Fields, Where, false).
select(PoolId, Tab, Fields, Where, Convert) ->
    case util_db_handle:select(PoolId, Tab, Fields, Where) of
        {selected, _, Ret} when Convert ->
            Ret2 = [to_rec(Row) || Row <- Ret],
            {ok, Ret2};
        {selected, _, Ret} ->
            {ok, Ret};
        Ret ->
            Ret
    end.
select(PoolId, Tab, Fields, Where, Convert, Other) ->
    case util_db_handle:select(PoolId, Tab, Fields, Where, Other) of
        {selected, _, Ret} when Convert ->
            Ret2 = [to_rec(Row) || Row <- Ret],
            {ok, Ret2};
        {selected, _, Ret} ->
            {ok, Ret};
        Ret ->
            Ret
    end.
select(PoolId, Tab, Fields, Index, Where, Convert, Other) ->
    case util_db_handle:select(PoolId, Tab, Fields, Index, Where, Other) of
        {selected, _, Ret} when Convert ->
            Ret2 = [to_rec(Row) || Row <- Ret],
            {ok, Ret2};
        {selected, _, Ret} ->
            {ok, Ret};
        Ret ->
            Ret
    end.

update(PoolId, Tab, Rec) ->
    Id = erlang:element(2, Rec),
    update(PoolId, Tab, Rec, ["id=", mysql:encode(Id)]).
update(PoolId, Tab, Rec, Where) ->
    [_ | Fields] = fields(),
    [_ | Values] = to_row(Rec),
    update(PoolId, Tab, Fields, Values, Where).
update(PoolId, Tab, Fields, Values, Where) ->
    case util_db_handle:update(PoolId, Tab, Fields, Values, Where) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

replace(PoolId, Tab, Rec) when erlang:is_tuple(Rec) ->
    case util_db_handle:replace(PoolId, Tab, fields(), to_row(Rec)) of
        {updated, _} ->
            ok;
        Ret ->
            Ret
    end.

first_tab() ->
     "game_win_info".

assign_tab(_Id, _TabNum) ->
     "game_win_info".

