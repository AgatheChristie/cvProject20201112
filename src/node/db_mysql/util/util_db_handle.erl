%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.11.16
%%% 数据库操作接口(不能直接调用这些函数,都要通过db文件夹中的db_*模块来调用)
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(util_db_handle).
-include("db.hrl").
-include("common.hrl").
-include("mysql.hrl").

-export([
    fetch/2
    , fetch/3
    , prepare/2
    , unprepare/1
    , transaction/2
    , transaction/3
    , execute/2
    , execute/3
    , execute/4
    , select/3
    , select/4
    , select/5
    , select/6
    , do_select/6
    , select_limit/6
    , insert/3
    , insert/4
    , insert_next/3
    , insert_next/4
    , insert_on_duplicate/6
    , insert_multi/3
    , replace/3
    , replace/4
    , update/4
    , update_with_add/5
    , update/5
    , do_update/6
    , delete/3
    , delete/2
    , delete_db/2
    , handle_result/1
    , handle_transaction/1
    , field_join/2
    , val_join/1
    , str_join/2
]).

-import(mysql, [get_result_field_info/1, get_result_rows/1, get_result_affected_rows/1, get_result_reason/1]).

%% 执行一条sql语句(可以事务内部也可以外部）,
%% 返回{selected, Fields, Rows} 
%% | {error, Reason}
%% | {updated, AffectedRows, InsertId}
fetch(PoolId, Query) ->
    fetch(PoolId, Query, ?MYSQL_TIMEOUT).

%% 执行一条sql
fetch(PoolId, Query, Timeout) ->
    handle_result(?TRY_CATCH(mysql:fetch(PoolId, Query, Timeout))).

%% 注册一个名为Name的语句,方便调用
prepare(Name, Query) ->
    mysql:prepare(Name, Query).

%% 取消注册
unprepare(Name) ->
    mysql:unprepare(Name).

%% 执行事务
%% 返回{atomic, Result}
%% | {error, Reason)
%% | {rollback, Reason, Res}.
transaction(PoolId, Fun) ->
    handle_transaction(?TRY_CATCH(mysql:transaction(PoolId, Fun))).

%% 同上
transaction(PoolId, Fun, Timeout) ->
    handle_transaction(?TRY_CATCH(mysql:transaction(PoolId, Fun, Timeout))).

%% 执行prepare注册的请求
execute(PoolId, Name) ->
    handle_result(?TRY_CATCH(mysql:execute(PoolId, Name))).
execute(PoolId, Name, Timeout) ->
    handle_result(?TRY_CATCH(mysql:execute(PoolId, Name, Timeout))).
execute(PoolId, Name, Params, Timeout) ->
    handle_result(?TRY_CATCH(mysql:execute(PoolId, Name, Params, Timeout))).

%% 查询请求
select(PoolId, Table, Fields) ->
    select(PoolId, Table, Fields, "").

%% 查询请求(字段没有添加``)
%% select * from tab where id = 1;
%% select("tab", "*", "id=1")
select(PoolId, Table, Fields, Where) ->
    select(PoolId, Table, Fields, Where, "").

select(PoolId, Table, Fields, Where, Other) ->
    do_select(PoolId, Table, "", field_join(Fields, false), Where, Other).

select(PoolId, Table, Fields, Index, Where, Other) ->
    do_select(PoolId, Table, Index, field_join(Fields, false), Where, Other).

%% 执行查询
do_select(PoolId, Table, Index, Fields, Where, Other)
    when is_list(Fields), is_list(Where), is_list(Other) ->
    Sql = [<<"select ">>,
        Fields,
        <<" from ">>, Table, Index,
        begin
            if
                length(Where) > 0 ->
                    [<<" where ">>, Where];
                true ->
                    <<>>
            end
        end,
        " ",
        Other
    ],
    fetch(PoolId, Sql).

%% 查询请求
select_limit(PoolId, Table, Fields, Where, Start, Count) ->
    select(PoolId, Table, Fields, [Where, " limit ", util_db:encode(Start), ", ", util_db:encode(Count)]).

%% 插入请求
%% insert into table values(v1, v2)
insert(PoolId, Table, Vals) ->
    Sql =
        [<<"insert into ">>, Table, <<" values (">>, val_join(Vals), <<");">>],
    fetch(PoolId, Sql).

%% 插入请求
%% insert into table(f1, f2) values(v1, v2)
insert(PoolId, Table, [H | _] = Fields, Vals) when is_list(H) ->
    Sql =
        [<<"insert into ">>, Table, <<"(">>, field_join(Fields, true), <<") values (">>, val_join(Vals), <<");">>],
    fetch(PoolId, Sql).

%% 插入请求
%% insert into table values(v1, v2)
insert_next(PoolId, Table, Vals) ->
    Sql =
        [<<"insert next into ">>, Table, <<" values (">>, val_join(Vals), <<");">>],
    fetch(PoolId, Sql).

%% 插入请求
%% insert into table(f1, f2) values(v1, v2)
insert_next(PoolId, Table, [H | _] = Fields, Vals) when is_list(H) ->
    Sql =
        [<<"insert next into ">>, Table, <<"(">>, field_join(Fields, true), <<") values (">>, val_join(Vals), <<");">>],
    fetch(PoolId, Sql).

%% 插入数据,当重复时更新数据
insert_on_duplicate(PoolId, Table, Key, Val, Fields, Vals) ->
    Sql =
        [<<"insert into ">>, Table, <<"(">>, field_join([Key | Fields], true),
            <<") values (">>, val_join([Val | Vals]), <<") ON DUPLICATE KEY UPDATE ">>,
            str_join(lists:zipwith(fun(F, V) -> [$`, F, $`, "=", util_db:encode(V)] end, Fields, Vals), $,)],
    fetch(PoolId, Sql).

%% 插入多条数据
insert_multi(_PoolId, _Table, []) ->
    ok;
insert_multi(PoolId, Table, ValsList) when is_list(ValsList) ->
    ValsStrList =
        [begin
             [<<"(">>, val_join(Vals), <<")">>]
         end || Vals <- ValsList],
    Sql =
        [<<"insert into ">>, Table, <<" values ">>, str_join(ValsStrList, $,), <<";">>],
    fetch(PoolId, Sql).

%% 插入请求
%% replace into table values(v1, v2)
replace(PoolId, Table, Vals) ->
    Sql =
        [<<"replace into ">>, Table, <<" values (">>, val_join(Vals), <<");">>],
    fetch(PoolId, Sql).

%% 插入请求
%% replace into table(f1, f2) values(v1, v2)
replace(PoolId, Table, [H | _] = Fields, Vals) when is_list(H) ->
    Sql =
        [<<"replace into ">>, Table, <<"(">>, field_join(Fields, true), <<") values (">>, val_join(Vals), <<");">>],
    fetch(PoolId, Sql).

%% 更新数据
update(PoolId, Table, Fields, Vals) ->
    do_update(PoolId, Table, Fields, Vals, "", false).

%% 更新数据,采用+=
update_with_add(PoolId, Table, Fields, Vals, Where) ->
    do_update(PoolId, Table, Fields, Vals, Where, true).

%% 更新数据
update(PoolId, Table, Fields, Vals, Where) ->
    do_update(PoolId, Table, Fields, Vals, Where, false).

do_update(PoolId, Table, [H | _] = Fields, Vals, Where, WithAdd) when is_list(H) ->
    UPairs =
        lists:zipwith(
            fun(_A, '_') ->
                '_';
                (A, B) ->
                    ?IF(WithAdd,
                        ?FIELD_QUOTE(A) ++ "=" ++ ?FIELD_QUOTE(A) ++ "+" ++ util_db:encode(B),
                        ?FIELD_QUOTE(A) ++ "=" ++ util_db:encode(B))
            end,
            Fields, Vals),
    Sql =
        [<<"update ">>, Table, <<" set ">>,
            str_join(UPairs, $,),
            <<" where ">>, Where, <<";">>],
    fetch(PoolId, Sql).

%% 删除数据
delete(PoolId, Table, Where) when is_list(Where) ->
    Sql =
        [<<"delete from ">>, Table,
            begin
                if
                    length(Where) > 0 ->
                        [<<" where ">>, Where];
                    true ->
                        <<>>
                end
            end],
    fetch(PoolId, Sql).

%% 删除所有数据
delete(PoolId, Table) ->
    Sql =
        [<<"delete  from ">>, Table],
    fetch(PoolId, Sql).

%% 删除数据库
delete_db(PoolId, Db) ->
    Sql =
        [<<"delete  database ">>, Db],
    fetch(PoolId, Sql).

%% 对结果进行处理
handle_result({data, Result}) ->
    {selected, get_result_field_info(Result), get_result_rows(Result)};
handle_result({updated, Result}) ->
    {updated, get_result_affected_rows(Result)};
handle_result({error, Result}) when is_record(Result, mysql_result) ->
    Reason = get_result_reason(Result),
    ?ERROR("mysql_result error:~p", [Reason]),
    {error, Reason};
handle_result({error, Result}) ->
    ?ERROR("mysql error:~w", [Result]),
    {error, Result};
handle_result({'EXIT', {Reason, _}}) ->
    ?ERROR("mysql exit error:~w", [Reason]),
    {error, Reason}.

%% 对事务结果进行处理
handle_transaction(Result) ->
    case Result of
        {atomic, Res} ->
            {atomic, Res};
        {aborted, {Err, {rollback_result, Res}}} ->
            {rollback, Err, Res};
        {error, Reason} ->
            {error, Reason};
        {'EXIT', Reason} ->
            {error, Reason}
    end.

%% 生成字段列表
field_join([], _) ->
    [];
field_join([H | T], true) ->
    [$`, H, $`] ++ [[$,, $`, X, $`] || X <- T];
field_join([H | T], false) ->
    [H] ++ [[$,, X] || X <- T].

%% 生成值列表
val_join([]) ->
    [];
val_join([H | T]) ->
    [util_db:encode(H)] ++ [[$,, util_db:encode(X)] || X <- T].

%% 字符串join(生成iodata)
str_join([], _Sep) ->
    [];
str_join(['_' | T], Sep) ->
    str_join(T, Sep);
str_join([H | T], Sep) ->
    [H] ++ [[Sep, X] || X <- T, X /= '_'].
