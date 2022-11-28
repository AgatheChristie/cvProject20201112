%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date  2010.12.22
%%% 使用进程内辞典的列表操作
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(proc_list).

-export([
    get_list/1
    , set_list/2
    , erase_list/1
    , add/2
    , add_if_not_exist/2
    , add_tail/2
    , delete/2
    , keydelete/3
    , keyfind/3
    , keyupdate/4
    , keystore/4
    , sort/2
    , member/2
]).



%% 获取list
get_list(Type) ->
    case erlang:get(Type) of
        undefined ->
            [];
        L ->
            L
    end.

%% 设置list数据
set_list(Type, List) when is_list(List) ->
    erlang:put(Type, List),
    ok.

%% 清除list,返回原有数据
erase_list(Type) ->
    case erlang:erase(Type) of
        undefined ->
            [];
        L ->
            L
    end.

%% list中增加一项
add(Type, Elem) ->
    set_list(Type, [Elem | get_list(Type)]),
    ok.

%% 当不存在时首部添加元素
add_if_not_exist(Type, Elem) ->
    ok = delete(Type, Elem),
    add(Type, Elem).

%% list中增加一项从尾部添加
add_tail(Type, Elem) ->
    set_list(Type, lists:append(get_list(Type), [Elem])).

%% list中删除一项(非key方式)
delete(Type, Elem) ->
    List2 = lists:delete(Elem, get_list(Type)),
    set_list(Type, List2),
    ok.

%% list中删除一项
keydelete(Type, Key, Pos) ->
    case lists:keytake(Key, Pos, get_list(Type)) of
        {value, V, List2} ->
            set_list(Type, List2),
            V;
        false ->
            false
    end.

%% 排序
sort(Type, Fun) ->
    set_list(Type, lists:sort(Fun, get_list(Type))),
    ok.

%% 元素是否存在
member(Type, Elem) ->
    lists:member(Elem, get_list(Type)).

%% list中查找一项
keyfind(Type, Key, Pos) ->
    lists:keyfind(Key, Pos, get_list(Type)).

%% list中更新
keyupdate(Type, Key, Pos, NewVal) ->
    List2 = lists:keyreplace(Key, Pos, get_list(Type), NewVal),
    set_list(Type, List2).

%% list中存储,参考lists:keystore/3
keystore(Type, Key, Pos, NewVal) ->
    List2 = lists:keystore(Key, Pos, get_list(Type), NewVal),
    set_list(Type, List2).
