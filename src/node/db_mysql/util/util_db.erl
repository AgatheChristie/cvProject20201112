%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2016.08.15
%%% 数据库接口模块
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(util_db).
-include("db.hrl").
-include("common.hrl").
-include("node.hrl").

-compile(export_all).

%% sql需要的条件
where(Id) ->
    ["id=", util_db:encode(Id)].

where(Flag, FlagCheck, FlagValue) ->
    [Flag, FlagCheck, util_db:encode(FlagValue)].

wheres_and([], Result) ->
    Result;
wheres_and([{Flag, FlagCheck, FlagValue} | TFlagInfos], Result) ->
    case Result =:= [] of
        true ->
            Where = where(Flag, FlagCheck, FlagValue),
            NewResult = Result ++ Where,
            wheres_and(TFlagInfos, NewResult);
        false ->
            Where = " and " ++ where(Flag, FlagCheck, FlagValue),
            NewResult = Result ++ Where,
            wheres_and(TFlagInfos, NewResult)
    end.

wheres_or([], Result) ->
    Result;
wheres_or([{Flag, FlagCheck, FlagValue} | TFlagInfos], Result) ->
    case Result =:= [] of
        true ->
            Where = where(Flag, FlagCheck, FlagValue),
            NewResult = Result ++ Where,
            wheres_or(TFlagInfos, NewResult);
        false ->
            Where = " or " ++ where(Flag, FlagCheck, FlagValue),
            NewResult = Result ++ Where,
            wheres_or(TFlagInfos, NewResult)
    end.

%% 其他
other() ->
    "limit 1".

other(Count) ->
    lists:append("limit ", ?N2S(Count)).

%% 同步写入操作
write_sync(Mod, Fun, Rec) ->
    %% 随机取公共的池id
    PoolId = 1,
    assign_write_sync(Mod, Fun, Rec, PoolId).

%% 指定同步写入操作
assign_write_sync(Mod, Fun, Rec, PoolId) ->
    {NodeType, DbNode} = util_db:assign_db_mysql_info(),
    MysqlServName = util_db_mysql_serv:db_mysql_serv_name(PoolId),
    CallMsg = {write_sync, Mod, Fun, [Rec]},
    case catch util:gen_rpc_call(DbNode, MysqlServName, CallMsg, ?MYSQL_TIMEOUT) of
        ok ->
            util_db:delete_db_node_info(NodeType, DbNode),
            ok;
        _Reason ->
            ?ERROR("assign_write_sync err:~w ~w", [Mod, _Reason]),
            util_db:delete_db_node_info(NodeType, DbNode),
            _Reason
    end.

%% 同步查看操作
select_sync(Mod, Fun, Rec) ->
    %% 随机取公共的池id
    PoolId = 1,
    assign_select_sync(Mod, Fun, Rec, PoolId).

%% 指定同步查看操作
assign_select_sync(Mod, Fun, Rec, PoolId) ->
    {NodeType, DbNode} = util_db:assign_db_mysql_info(),
    MysqlServName = util_db_mysql_serv:db_mysql_serv_name(PoolId),
    CallMsg = {select_sync, Mod, Fun, Rec},
    case catch util:gen_rpc_call(DbNode, MysqlServName, CallMsg, ?MYSQL_TIMEOUT) of
        {ok, Result} ->
            util_db:delete_db_node_info(NodeType, DbNode),
            Result;
        _Reason ->
            ?ERROR("assign_select_sync err:~w ~w", [Mod, _Reason]),
            util_db:delete_db_node_info(NodeType, DbNode),
            _Reason
    end.

%% 同步删除操作
delete_sync(Mod, Fun, Rec) ->
    %% 随机取公共的池id
    PoolId = 1,
    assign_delete_sync(Mod, Fun, Rec, PoolId).

%% 指定同步删除操作
assign_delete_sync(Mod, Fun, Rec, PoolId) ->
    {NodeType, DbNode} = util_db:assign_db_mysql_info(),
    MysqlServName = util_db_mysql_serv:db_mysql_serv_name(PoolId),
    CallMsg = {delete_sync, Mod, Fun, Rec},
    case catch util:gen_rpc_call(DbNode, MysqlServName, CallMsg, ?MYSQL_TIMEOUT) of
        ok ->
            util_db:delete_db_node_info(NodeType, DbNode),
            ok;
        _Reason ->
            ?ERROR("assign_delete_sync err:~w ~w", [Mod, _Reason]),
            util_db:delete_db_node_info(NodeType, DbNode),
            _Reason
    end.

%% 编码
encode(V) ->
    mysql:encode(V).

%% 指定数据库信息
assign_db_mysql_info() ->
    DbMysqlNode = node(),
    {?DB_MYSQL_TYPE, DbMysqlNode}.


%% 删除数据库信息
delete_db_node_info(NodeType, _DbNode) ->
    case NodeType =:= ?DB_MYSQL_TYPE of
        true ->
            next;
        false ->
            next
    end.