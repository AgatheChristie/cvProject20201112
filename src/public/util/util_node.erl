%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 节点操作公共接口
%%%
%%%----------------------------------------------------------------------

-module(util_node).

-include("common.hrl").
-include("db_mnesia.hrl").
-include("node.hrl").

-compile(export_all).

%% 节点类型转换
convert_node_type(NodeType) ->
    case util_config:many_node() of
        true ->
            NodeType;
        false ->
            NodeType
    end.