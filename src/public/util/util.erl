%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 公共函数接口
%%%
%%%----------------------------------------------------------------------
-module(util).

-include("common.hrl").


-export([
    peer_str/1
    , peer/1
    , get_nonlo_if/0
    , ip_ntoa/1
    , get_ip/0
    , get_ip_wan/0
    , get_ip_lan/0
    , md5_string_lowercase/1
    , md5_string_uppercase/1
    , prefix_n/2
    , sprefix_n/2
    , sprefix_n2/2
    , sprefix_n3/2
    , rpc_call/4
    , gen_rpc_call/3]).

%% 获取socket peer的ip
peer_str(Sock) when is_port(Sock) ->
    inet_parse:ntoa(peer(Sock)).

%% 获取socket peer的ip
peer(Sock) when is_port(Sock) ->
    case inet:peername(Sock) of
        {ok, {Addr, _Port}} ->
            Addr;
        {error, Error} ->
            throw({error, Error})
    end.

%% 选择非lo接口
get_nonlo_if() ->
    {ok, List} = inet:getif(),
    Set =
        lists:foldl(
            fun
                ({{127, _, _, _}, _, _}, Acc) ->
                    Acc;
                ({Ip, _, _}, Acc) ->
                    sets:add_element(Ip, Acc)
            end, sets:new(), List),
    sets:to_list(Set).

%% ip tuple转换成string
ip_ntoa(Ip) ->
    inet_parse:ntoa(Ip).

%% 获取本级的所有ip列表
get_ip() ->
    {ok, L} = inet:getif(),
    [Ip || {Ip, _, _} <- L, Ip =/= {127, 0, 0, 1}].

%% 获取外网ip
get_ip_wan() ->
    [Ip || {A, B, _, _} = Ip <- get_ip(),
        Ip =/= {127, 0, 0, 1}, (A =/= 192 andalso B =/= 168)].

%% 获取内网ip
get_ip_lan() ->
    [Ip || {192, 168, _, _} = Ip <- get_ip()].

%% 生成md5 16进制字符串(小写)
md5_string_lowercase(IoData) ->
    <<N:128>> = erlang:md5(IoData),
    lists:flatten(io_lib:format("~32.16.0b", [N])).

%% 生成md5 16进制字符串(大写)
md5_string_uppercase(IoData) ->
    <<N:128>> = erlang:md5(IoData),
    lists:flatten(io_lib:format("~32.16.0B", [N])).

%% 组合某个前缀和数字,返回值为atom
prefix_n(Prefix, PreFixValues) ->
    ?S2A(sprefix_n(Prefix, PreFixValues)).

%% 组合某个前缀和数字,返回值为list
sprefix_n(Prefix, PreFixValues) ->
    sprefix_n2(PreFixValues, Prefix).

sprefix_n2([], Prefix) ->
    Prefix;
sprefix_n2([PreFixValue | TPreFixValues], Prefix) ->
    Prefix2 = sprefix_n3(Prefix, PreFixValue),
    sprefix_n2(TPreFixValues, Prefix2).

sprefix_n3(Prefix, PreFixValue) when is_integer(PreFixValue) ->
    Prefix ++ "_" ++ ?N2S(PreFixValue);
sprefix_n3(Prefix, PreFixValue) when is_list(PreFixValue) ->
    Prefix ++ "_" ++ PreFixValue;
sprefix_n3(Prefix, PreFixValue) when is_atom(PreFixValue) ->
    Prefix ++ "_" ++ ?A2S(PreFixValue).


%% 远程同步调用
rpc_call(ReNode, Mod, Method, Arvgs) ->
    rpc_call(ReNode, Mod, Method, Arvgs, ?CALL_TIMEOUT).
rpc_call(ReNode, Mod, Method, Arvgs, Timeout) ->
    rpc:call(ReNode, Mod, Method, Arvgs, Timeout).

%% 远程同步调用
%% 避免使用rpc:call 尽量使用 gen_server:call({Pid,Node}, Request, Timeout)来代替rpc:call(M,F,A)
gen_rpc_call(ReNode, RePidName, Msg) ->
    gen_rpc_call(ReNode, RePidName, Msg, ?CALL_TIMEOUT).
gen_rpc_call(ReNode, RePidName, Msg, Timeout) ->
    catch gen_server:call({RePidName, ReNode}, Msg, Timeout).