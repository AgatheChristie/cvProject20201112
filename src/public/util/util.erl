%% coding: latin-1
%%%----------------------------------------------------------------------
%%%
%%% @date 2016-07-29
%%% 公共函数接口
%%%
%%%----------------------------------------------------------------------
-module(util).

-include("common.hrl").

-compile(export_all).

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

%% 封装返回码
return_json(Code, CodeMsg) ->
    {json, [{<<"code">>, Code}, {<<"code_msg">>, CodeMsg}]}.
%% 封装ok
return_json_ok() ->
    {json, [{<<"code">>, ?E_OK}]}.
%% 封装错误码
return_json_ecode(Code) ->
    {json, [{<<"code">>, Code}]}.
%% 封装数据
return_json_data(Data) ->
    {json, [{<<"code">>, ?E_OK}, {<<"data">>, Data}]}.
%% 封装返回码
return_json_badarg(Info) when is_binary(Info) ->
    {json, [{<<"code">>, 10000}, {<<"code_msg">>, <<"参数错误:", Info/bytes>>}]}.

%% 数值,原子,字节流 不变
%% 字符转化为字节流
%% 列表,可打印集合处理为字符串,否则为数组, 又想作为数组,则外面加上封装{array, &data}
%% 列表有时跟字节传都打印,如“123”,[97, 98, 99] 结果一样,但是表达意思不一样
preprocess(E) when is_integer(E); is_float(E); is_atom(E); is_binary(E) ->
    E;
preprocess({array, E}) ->
    case io_lib:char_list(E) of
        true ->
            E;
        false ->
            preprocess(E)
    end;
preprocess({struct, E}) ->
    {struct, preprocess(E)};

preprocess(E) ->
    case io_lib:char_list(E) of
        true ->
            list_to_binary(E);
        false ->
            preprocess2(E)
    end.

preprocess2(E) ->
    case E of
        [{_, _} | _] ->
            [{preprocess(K), preprocess(V)} || {K, V} <- E];
        _ ->
            [preprocess(X) || X <- E]
    end.

%% 转化成iodata
any_to_iodata(Any) when is_list(Any) ->
    Any;
any_to_iodata(Any) when is_binary(Any) ->
    Any;
any_to_iodata(Any) when is_atom(Any) ->
    ?A2S(Any);
any_to_iodata(Any) when is_integer(Any) ->
    ?N2S(Any);
any_to_iodata(Any) when is_float(Any) ->
    ?F2S(Any).

%% 将term转化为string
%% 如[1, 2]转化为"[1,2]"
term_to_string(Term) ->
    lists:flatten(io_lib:format("~w", [Term])).

%% 将string转化为term
%% 如"[1,2]"转化成[1,2]
string_to_term(Str) when is_binary(Str) ->
    string_to_term(?B2S(Str));
string_to_term(Str) when is_list(Str) ->
    case erl_scan:string(Str ++ ".") of
        {error, _, _} = Error ->
            Error;
        {ok, Tokens, _} ->
            {ok, Value} = erl_parse:parse_term(Tokens),
            Value
    end.

%% term解码
decode_term(Bin) when is_binary(Bin) ->
    binary_to_term(Bin).

%% term编码
encode_term(Term) ->
    term_to_binary(Term).

%% 转化成小写(如果时binary首先进行unicode转化)
to_lower(S) when is_binary(S) ->
    Str = unicode:characters_to_list(S),
    to_lower(Str);
to_lower(S) when is_list(S) ->
    string:to_lower(S).

%% 转化成大写(如果时binary首先进行unicode转化)
to_upper(S) when is_binary(S) ->
    Str = unicode:characters_to_list(S),
    to_upper(Str);
to_upper(S) when is_list(S) ->
    string:to_upper(S).

%% 向下取整
floor(N) when N > 0 ->
    trunc(N);
floor(N) ->
    N2 = trunc(N),
    case N < N2 of
        true ->
            N2 - 1;
        _ ->
            N2
    end.

%% 向上取整
ceil(N) when N > 0 ->
    N2 = trunc(N),
    case N > N2 of
        true ->
            N2 + 1;
        _ ->
            N2
    end;
ceil(N) ->
    trunc(N).

%% 四舍五入
round(N) ->
    erlang:round(N).

%% 是否在区间范围
is_in_section(0, MaxSectionId, SelfSectionId) ->
    SelfSectionId < MaxSectionId;
is_in_section(MinSectionId, 0, SelfSectionId) ->
    SelfSectionId >= MinSectionId;
is_in_section(MinSectionId, MaxSectionId, SelfSectionId) ->
    SelfSectionId >= MinSectionId andalso SelfSectionId < MaxSectionId.

%% 嵌套的解析erlang term文件
consult_nested(File) ->
    case catch consult_nested(File, [], []) of
        {error, _} = Ret ->
            Ret;
        {Terms, _} ->
            {ok, Terms}
    end.
consult_nested(FileName, Terms, Already) ->
    Config =
        case file:consult(FileName) of
            {ok, L} ->
                L;
            Error ->
                ?ERROR("the ~w file format error!", [FileName]),
                throw(Error)
        end,
    Already2 = [FileName | Already],
    %% 解析每一项
    {Terms2, Already3} =
        lists:mapfoldl(
            fun
                ({include, Val}, Acc) ->
                    %% 子配置文件列表
                    Files = do_expand_files(FileName, Val, Acc),
                    lists:mapfoldl(
                        fun(F, AccIn) ->
                            consult_nested(F, [], AccIn)
                        end, Already2, Files);
                (_Other, Acc) ->
                    {_Other, Acc}
            end, Already2, Config),
    {lists:flatten([Terms | Terms2]), Already3}.

%% 获取子配置文件
do_expand_files(Filename, Val0, Already) ->
    DirName = filename:dirname(Filename),
    Val = filename:join([DirName, Val0]),
    case lists:member($*, Val) of
        true ->
            lists:foldl(
                fun(F, Acc) ->
                    case lists:member(F, Already) of
                        true ->
                            Acc;
                        false ->
                            [F | Acc]
                    end
                end, [], filelib:wildcard(Val));
        false ->
            case lists:member(Val, Already) of
                true ->
                    [];
                false ->
                    [Val]
            end
    end.

%% 取绝对值
abs(Value) ->
    erlang:abs(Value).

%% 取正数
positive(Value) ->
    ?IF(Value >= 0, Value, 0).

%% 取中间值
middle(NumA, NumB) ->
    if
        NumA =:= NumB ->
            util:floor(NumA);
        NumA < NumB ->
            util:floor(NumA + (NumB - NumA) / 2);
        true ->
            util:floor(NumB + (NumA - NumB) / 2)
    end.

%% 端口是否被使用
%% 不再判断端口是否被占用
%% 如果被占用直接让进程起不来，方便查看问题
port_is_use(_Port) ->
%%    Cmd = lists:concat(["netstat -anp|grep ", Port]),
%%    Cmd = lists:concat(["netstat -tunlp|grep ", Port]),
%%    CmdResult = os:cmd(Cmd),
%%    CmdResult =/= [].
    false.

%% 文件是否存在
file_is_exist(Path, FileName) ->
    FileName = filename:join([Path, FileName]),
    filelib:is_file(FileName).

%% 本地异步
local_send(Pid, Msg) when is_pid(Pid) ->
    catch erlang:send(Pid, Msg, [noconnect]);
local_send(PidName, Msg) ->
    Pid = erlang:whereis(PidName),
    case is_pid(Pid) of
        true ->
            catch erlang:send(Pid, Msg, [noconnect]);
        false ->
            next
    end.

%% 远程异步
%% 任何大量的对某些远端结点的send,call操作都要小心。如果机器会出现长时间宕机，都会可能造成本结点对对方结点的访问出现阻塞式的访问。
%% 设置noconnect之后erlang发送到远端的消息就不需要等待对方连接建立而是直接在对方结点不存在的时候返回noconnect
remote_send(RePid, _ReNode, Msg) when is_pid(RePid) ->
    catch erlang:send(RePid, Msg, [noconnect]);
remote_send(RePidName, ReNode, Msg) ->
    catch erlang:send({RePidName, ReNode}, Msg, [noconnect]).

%% rpc发送
rpc_send(RePidName, ReNode, Msg) ->
    case ReNode =:= node() of
        true ->
            local_send(RePidName, Msg);
        false ->
            remote_send(RePidName, ReNode, Msg)
    end.

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

%% list列表去重不排序
filter_duplicate(List) ->
    loop_filter_duplicate(List, []).

loop_filter_duplicate([], List) ->
    lists:reverse(List);
loop_filter_duplicate([H | Rest], List) ->
    case lists:member(H, List) of
        true ->
            loop_filter_duplicate(Rest, List);
        false ->
            loop_filter_duplicate(Rest, [H | List])
    end.

%% explode(Str, Sign) -> [list()]
%% Str = list() | binary()
%% Glue = list() | binary()
%% 根据分隔符拆分（等价于string:tokens/2，没有空字符
explode(Str, Sign) when is_binary(Str) ->
    explode(?B2S(Str), Sign);
explode(Str, Sign) when is_binary(Sign) ->
    explode(Str, ?B2S(Sign));
explode(Str, Sign) ->
    string:tokens(Str, Sign).

%% cn([230,149,176,230,141,174,229,188,130,229,184,184],[])
cn(Str, Args) ->
    io:format("~ts", [iolist_to_binary(io_lib:format(Str, Args))]).

%% implode(StrList, Sign) -> string()
%% StrList = [list()]
%% Sign = list()
%% 加入分隔符
implode(StrList, Sign) ->
    string:join(StrList, Sign).


%% 依据权重从列表中选择N个
%% IsDelDup标志是否去重复
weight_from_list([], _Pos, _Num, _IsDelDup) ->
    [];
weight_from_list(_List, _Pos, 0, _IsDelDup) ->
    [];
weight_from_list([I], _Pos, 1, _IsDelDup) ->
    [I];
weight_from_list(List, Pos, Num, IsDelDup) ->
    Sum = lists:sum([element(Pos, I) || I <- List]),
    weight_from_list(List, Pos, Sum, Num, IsDelDup, []).

weight_from_list([], _Pos, _Sum, _Num, _IsDelDup, Result) ->
    Result;
weight_from_list(_List, _Pos, _Sum, Num, _IsDelDup, Result) when Num =< 0 ->
    Result;
weight_from_list(List, Pos, Sum, Num, IsDelDup, Result) ->
    Seed = util_rand:rand(Sum),
    case do_weight_from_list(List, Pos, Seed, Sum) of
        {NewList, Get, NewSum} when IsDelDup ->
            weight_from_list(NewList, Pos, NewSum, Num - 1, IsDelDup, [Get | Result]);
        {_NewList, Get, _NewSum} ->
            weight_from_list(List, Pos, Sum, Num - 1, IsDelDup, [Get | Result]);
        {false, Reason} ->
            ?ERROR("随机数据发生错误，数据内容为:~w", [Reason]),
            weight_from_list(List, Pos, Sum, Num - 1, IsDelDup, Result)
    end.

do_weight_from_list(List, Pos, Seed, Sum) ->
    do_weight_from_list(List, Pos, Seed, Sum, 0, []).

do_weight_from_list([], _Pos, _Seed, _Sum, _Range, Ret) ->
    {false, Ret};
do_weight_from_list([L | T], Pos, Seed, Sum, Range, Ret) ->
    Ratio = element(Pos, L),
    case Seed =< (Ratio + Range) of
        true ->
            {T ++ Ret, L, Sum - Ratio};
        false ->
            do_weight_from_list(T, Pos, Seed, Sum, Range + Ratio, [L | Ret])
    end.

%% 万分之x
prop_of_ten_thousand(0) ->
    ?FALSE;
prop_of_ten_thousand(Prop) ->
    Prop >= rand:uniform(?TEN_THOUSAND).

%% md5Hex
md5_hex(S) ->
    Md5_bin = erlang:md5(S),
    Md5_list = binary_to_list(Md5_bin),
    lists:flatten(list_to_hex(Md5_list)).

list_to_hex(L) ->
    lists:map(fun(X) -> int_to_hex(X) end, L).

int_to_hex(N) when N < 256 ->
    [hex(N div 16), hex(N rem 16)].

hex(N) when N < 10 ->
    $0 + N;
hex(N) when N >= 10, N < 16 ->
    $a + (N - 10).

%% 转换成万分比
million_to_percent(Molecule) ->
    Molecule / ?TEN_THOUSAND.

%% 万分比转换成整数
percent_to_million(Percent) ->
    Percent * ?TEN_THOUSAND.

%% 转换成百分比
to_percent(Value) ->
    Value / ?ONE_HUNDRED.

%% 百分比转换成整数
percent_to_int(Percent) ->
    Percent * ?ONE_HUNDRED.

%% 多键值排序
%% list_util:mkeysort([2,1], [{1,2,3}, {2, 1, 3}, {2, 2, 2}]).
%% [{2, 1, 3}, {1, 2, 3}, {2, 2, 2}]
mkeysort(_Keys, []) ->
    [];
mkeysort(_Keys, [F]) ->
    [F];
mkeysort([], TupleList) when is_list(TupleList) ->
    TupleList;
mkeysort([Key], TupleList) when is_list(TupleList) ->
    lists:keysort(Key, TupleList);
mkeysort([Key | Keys], TupleList) when is_list(TupleList) ->
    [F | T] = lists:keysort(Key, TupleList),
    mkeysort_fun(T, Key, Keys, element(Key, F), [F], []).

mkeysort_fun([], _Key, Keys, _Val, Group, Res) ->
    NewGroup = mkeysort(Keys, Group),
    Res ++ NewGroup;
mkeysort_fun([F | T], Key, Keys, Val, Group, Res) ->
    case element(Key, F) of
        Val ->
            mkeysort_fun(T, Key, Keys, Val, [F | Group], Res);
        Val2 ->
            NewGroup = mkeysort(Keys, Group),
            mkeysort_fun(T, Key, Keys, Val2, [F], Res ++ NewGroup)
    end.

%% 多键值反排序
mkeyresort(Keys, L) ->
    lists:reverse(mkeysort(Keys, L)).

%% 支持正反逻辑多键值排序
%% list:mkeysort_fix([{sort,2}, {resort,1}], [{1,2,3}, {2, 1, 3}, {2, 2, 2}]).
%% [{2, 1, 3}, {2, 2, 2}, {1, 2, 3}]
mkeysort_fix(_Keys, []) ->
    [];
mkeysort_fix(_Keys, [F]) ->
    [F];
mkeysort_fix([], TupleList) when is_list(TupleList) ->
    TupleList;
mkeysort_fix([Key], TupleList) when is_list(TupleList) ->
    mkeysort_fix_fun3(Key, TupleList);
mkeysort_fix([Key | Keys], TupleList) when is_list(TupleList) ->
    {_, Key2} = Key,
    [F | T] = mkeysort_fix_fun3(Key, TupleList),
    mkeysort_fun2(T, Key, Keys, element(Key2, F), [F], []).

mkeysort_fun2([], _Key, Keys, _Val, Group, Res) ->
    NewGroup = mkeysort_fix(Keys, Group),
    Res ++ NewGroup;
mkeysort_fun2([F | T], {_, Key2} = Key, Keys, Val, Group, Res) ->
    case element(Key2, F) of
        Val ->
            mkeysort_fun2(T, Key, Keys, Val, [F | Group], Res);
        Val2 ->
            NewGroup = mkeysort_fix(Keys, Group),
            mkeysort_fun2(T, Key, Keys, Val2, [F], Res ++ NewGroup)
    end.

%% 分正反排序
mkeysort_fix_fun3({sort, Key}, Tuplelist) ->
    lists:keysort(Key, Tuplelist);
mkeysort_fix_fun3({resort, Key}, Tuplelist) ->
    lists:reverse(lists:keysort(Key, Tuplelist));
mkeysort_fix_fun3(SortFlag, Tuplelist) ->
    ?ERROR("出错的排序类型:~w", [SortFlag]),
    Tuplelist.

%% 判断L1中元素是否全部在L2中存在
%% member(L1 :: [term], L2 :: [term]) -> true|false
member([], _) ->
    false;
member(List1, List2) ->
    member1(List1, List2).

member1([], _) ->
    true;
member1([H | T], List) ->
    case lists:member(H, List) of
        true ->
            member1(T, List);
        false ->
            false
    end.

%% 自有字母和数字
only_number_letter(Content) ->
    ReStr = "^[\\x{4e00}-\\x{9fa5}a-zA-Z0-9_]+\$",
    case re:run(unicode:characters_to_binary(Content), ReStr, [unicode, notempty]) of
        nomatch ->
            false;
        _ ->
            true
    end.

%% 文本内容是否合法
%% UTF-8编码：一个英文字符等于一个字节，一个中文（含繁体）等于三个字节。中文标点占三个字节，英文标点占一个字节
%% ASCII码：一个英文字母（不分大小写）占一个字节的空间，一个中文汉字占两个字节的空间。
%% Unicode编码：一个英文等于两个字节，一个中文（含繁体）等于两个字节。
%% Content要求是字符串
is_text_valid(Content, MinLen, MaxLen) ->
    {AsciiNum, Utf8Num} = utf8_len(Content),
    CLen = AsciiNum + Utf8Num div 3 * 2,
    CLen >= MinLen andalso CLen =< MaxLen.

%% utf8_len2(Str) -> {AsciiNum, Utf8Num}
%% Str = list() | binary()
%% AsciiNum = int()
%% Utf8Num = int()
%% utf8字符长度,分两部分返回ASCII和utf8
utf8_len(Str) ->
    BinStr = unicode:characters_to_binary(Str, utf8),
    utf8_len2(BinStr, 0, 0).

utf8_len2(<<>>, AsciiNum, Utf8Num) ->
    {AsciiNum, Utf8Num};
utf8_len2(<<H:8, Rest/binary>>, AsciiNum, Utf8Num) when H =< 127 ->
    utf8_len2(Rest, AsciiNum + 1, Utf8Num);     %% ASCII
utf8_len2(<<H:8, _B:1/binary, Rest/binary>>, AsciiNum, Utf8Num) when H >= 192, H =< 223 ->
    utf8_len2(Rest, AsciiNum, Utf8Num + 1);   %% 2位
utf8_len2(<<H:8, _B:2/binary, Rest/binary>>, AsciiNum, Utf8Num) when H >= 224, H =< 239 ->
    utf8_len2(Rest, AsciiNum, Utf8Num + 1);   %% 3位
utf8_len2(<<H:8, _B:3/binary, Rest/binary>>, AsciiNum, Utf8Num) when H >= 240, H =< 247 ->
    utf8_len2(Rest, AsciiNum, Utf8Num + 1);   %% 4位
utf8_len2(<<H:8, _B:4/binary, Rest/binary>>, AsciiNum, Utf8Num) when H >= 248, H =< 251 ->
    utf8_len2(Rest, AsciiNum, Utf8Num + 1);   %% 5位
utf8_len2(<<H:8, _B:5/binary, Rest/binary>>, AsciiNum, Utf8Num) when H >= 252, H =< 253 ->
    utf8_len2(Rest, AsciiNum, Utf8Num + 1);   %% 6位
utf8_len2(<<_H:8, Rest/binary>>, AsciiNum, Utf8Num) ->
    utf8_len2(Rest, AsciiNum + 1, Utf8Num).   %% 正常的utf8字符是不会来的这里的

%% 获取utf8字符
utf8_world(<<H:8, Rest/binary>>) when H =< 127 ->
    {<<H>>, Rest};  %% ASCII
utf8_world(<<H:8, B:1/binary, Rest/binary>>) when H >= 192, H =< 223 ->
    {<<H:8, B/binary>>, Rest};   %% 2位
utf8_world(<<H:8, B:2/binary, Rest/binary>>) when H >= 224, H =< 239 ->
    {<<H:8, B/binary>>, Rest};   %% 3位
utf8_world(<<H:8, B:3/binary, Rest/binary>>) when H >= 240, H =< 247 ->
    {<<H:8, B/binary>>, Rest};   %% 4位
utf8_world(<<H:8, B:4/binary, Rest/binary>>) when H >= 248, H =< 251 ->
    {<<H:8, B/binary>>, Rest};   %% 5位
utf8_world(<<H:8, B:5/binary, Rest/binary>>) when H >= 252, H =< 253 ->
    {<<H:8, B/binary>>, Rest};   %% 6位
utf8_world(<<H:8, Rest/binary>>) ->
    {<<H>>, Rest}.

%% 分页
split_pages(_PageSize, _PageNum, []) ->
    {0, 0, []};
split_pages(PageSize, PageNum, Datas) ->
    MaxPageNum = util:ceil(length(Datas) / PageSize),
    if
        PageNum =< 0 ->
            {1, MaxPageNum, []};
        PageNum > MaxPageNum ->
            {PageNum, MaxPageNum, []};
        true ->
            Start = (PageNum - 1) * PageSize + 1,
            Pages = lists:sublist(Datas, Start, PageSize),
            {PageNum, MaxPageNum, Pages}
    end.

%% 第一页加剩余
split_tail(_PageSize, []) ->
    {0, 0, []};
split_tail(PageSize, Datas) ->
    TotalLen = length(Datas),
    MaxPageNum = util:ceil(TotalLen / PageSize),
    case TotalLen =< PageSize of
        true ->
            {1, 1, Datas, []};
        false ->
            {Pages, TailDatas} = lists:split(PageSize, Datas),
            {1, MaxPageNum, Pages, TailDatas}
    end.

%% tuple_list 某个位置的值求和
keysum(N, TupleList) ->
    keysum(N, TupleList, 0).

keysum(_N, [], Sum) ->
    Sum;
keysum(N, [Tuple | T], Sum) ->
    keysum(N, T, element(N, Tuple) + Sum).

%% tuple_list 某个位置的值取最大并返回tuple
keymax([H | T], N) ->
    keymax(T, element(N, H), H, N).

keymax([H | T], Max, Tuple, N) ->
    Elem = element(N, H),
    case Elem > Max of
        true ->
            keymax(T, Elem, H, N);
        false ->
            keymax(T, Max, Tuple, N)
    end;
keymax([], _Max, Tuple, _N) ->
    Tuple.

%% tuple_list 某个位置的值取最小并返回tuple
keymin([H | T], N) ->
    keymin(T, element(N, H), H, N).

keymin([H | T], Max, Tpl, N) ->
    Elem = element(N, H),
    case Elem < Max of
        true ->
            keymin(T, Elem, H, N);
        false ->
            keymin(T, Max, Tpl, N)
    end;
keymin([], _Max, Tuple, _N) ->
    Tuple.

%% 列表中的交集
list_mix([], _ListB, Result) ->
    Result;
list_mix([A | TListA], ListB, Result) ->
    Result2 =
        case lists:member(A, ListB) of
            true ->
                [A | Result];
            false ->
                Result
        end,
    list_mix(TListA, ListB, Result2).

%% 列表中的差集
list_not_mix([], _ListB, Result) ->
    Result;
list_not_mix([A | TListA], ListB, Result) ->
    Result2 =
        case lists:member(A, ListB) of
            true ->
                Result;
            false ->
                [A | Result]
        end,
    list_not_mix(TListA, ListB, Result2).

%% 字段拼接
field_splice(Fields, SpliceKey) ->
    SpliceFields = lists:foldr(
        fun({K, V}, Acc) ->
            [lists:concat([K, "=", V]) | Acc]
        end, [], Fields),
    string:join(SpliceFields, SpliceKey).

%% 只允许使用汉字(不含标点符号)、字母、数字和下划线
%% {4E00}-{9FA5} 中日韩统一汉字
name_valid(Text) ->
    StrKey = "[^a-zA-Z0-9\\x{4E00}-\\x{9FA5}_\\x{306E}\\x{2116}\\x{706c}\\x{4e36}\\x{4e28}\\x{4e3f}\\x{2573}\\x{256c}\\x{5350}\\x{2103}\\x{0021}\\x{002E}]",
    case re:run(Text, StrKey, [{capture, none}, caseless, unicode]) of
        match ->
            false;
        nomatch ->
            true
    end.

%% 检查内容
check_text([]) ->
    false;
check_text(Note) ->
    NewNote = ?IF(is_list(Note), ?L2B(Note), Note),
    StrKey = "[^a-zA-Z0-9\\x{4E00}-\\x{9FA5}_\\x{306E}\\x{2116}\\x{706c}\\x{4e36}\\x{4e28}\\x{4e3f}\\x{2573}\\x{256c}\\x{5350}\\x{2103}\\x{0021}\\x{002E}\\x{0020}-\\x{007E}\\x{FF01}-\\x{FF65}\\x{2026}\\x{3001}\\x{3002}\\x{000A}]",
    case re:run(NewNote, StrKey, [{capture, none}, caseless, unicode]) of
        match ->
            false;
        nomatch ->
            true
    end.

%% 随机值
rand_num([]) ->
    0;
rand_num([Num]) ->
    Num;
rand_num([Num1, Num2]) ->
    util_rand:rand(Num1, Num2);
rand_num([Num1, Num2 | _]) ->
    util_rand:rand(Num1, Num2).

%% 统计时间
do_http_summary(Cmd, NowMs) ->
    NowMs2 = util_time:now_ms_no_cache(),
    DiffMs = NowMs2 - NowMs,
    ?INFO("请求cmd:~p的时长:~w ms", [Cmd, DiffMs]),
    ok.

%% 统计时间
do_http_summary2(Cmd, NowMs) ->
    NowMs2 = util_time:now_ms_no_cache(),
    DiffMs = NowMs2 - NowMs,
    ?INFO("请求cmd:~p的时长:~w ms", [Cmd, DiffMs]),
    ok.

%% 删除列表的最后一个元素
droplast([]) ->
    [];
droplast([_T]) ->
    [];
droplast([H | T]) ->
    [H | droplast(T)].


%% 设备标识长度
device_desc(DeviceDesc) ->
    lists:sublist(DeviceDesc, 50).

%% 其他标识长度
other_desc(OtherDesc) ->
    lists:sublist(OtherDesc, 50).

int_to_bool(?SYS_TRUE) ->
    ?TRUE;
int_to_bool(?SYS_FALSE) ->
    ?FALSE.

bool_to_int(?TRUE) ->
    ?SYS_TRUE;
bool_to_int(?FALSE) ->
    ?SYS_FALSE.

%% 计算小数
calc_decimal(DecimalFloat, Times, NowPerDecimal) ->
    %% 整数部分
    AddDecimal = util:floor(DecimalFloat),
    %% 小数部分
    Decimal = DecimalFloat - AddDecimal,
    {Decimal2, DecimalNum} = calc_decimal_times(Decimal, Times),
    {AddDecimalNum, TailPerDecimal} = calc_decimal2(Decimal2, NowPerDecimal),
    AddItemNum3 = (AddDecimal * Times) + AddDecimalNum + DecimalNum,
    TailPerDecimal2 = util:floor(TailPerDecimal),
    {AddItemNum3, TailPerDecimal2}.

%% 计算小数部分乘以次数
calc_decimal_times(Decimal, Times) ->
    FloatDecimal = Decimal * Times,
    %% 整数部分
    AddDecimal = util:floor(FloatDecimal),
    %% 小数部分
    Decimal2 = FloatDecimal - AddDecimal,
    {Decimal2, AddDecimal}.

%% erl运行 1.1112 - 1.
%% 结果为0.11119999999999997
%% erl运行 0.2778 + 0.5556.
%% 结果为0.8333999999999999
calc_decimal2(Decimal, NowPerDecimal) ->
    PerDecimal = util:percent_to_million(Decimal),
    TotalPerDecimal = PerDecimal + NowPerDecimal,
    case TotalPerDecimal >= ?TEN_THOUSAND of
        true ->
            TailPerDecimal = TotalPerDecimal - ?TEN_THOUSAND,
            {1, TailPerDecimal};
        _ ->
            {0, TotalPerDecimal}
    end.

%% 计算下次增长时间
calc_next_growth_sec(NowSec, Interval) ->
    NowSec + Interval.


%% 保留X位小数 四舍五入 X大于0
keep_decimal_places(Number, X) ->
    case is_float(Number) of
        true ->
            keep_decimal_places2(Number, X);
        false ->
            Number
    end.

keep_decimal_places2(Number, X) ->
    Format = string:join(["~", ".", integer_to_list(X), "f"], ""),
    list_to_float((io_lib:format(Format, [Number]))).

%% 分割列表
list_partition(List, Type, Pos) ->
    lists:partition(fun(X) -> element(Pos, X) =:= Type end, List).

%% 输出值
format_value(Format, Values) ->
    lists:flatten(io_lib:format(Format, Values)).

%% ----------------------------------------------------
%% Func: rand_weight (T)
%% Description: 根据奇数位的概率随机求偶数位,如果概率为0则返回该Item
%% Args: 列表如:[50,a,30,b,20,c]
%% Returns:
%% ----------------------------------------------------
rand_weight(WeightList) ->
    case sum_odd(WeightList) of
        0 ->
            rand_weight(0, WeightList, []);
        OtherPerhaps ->
            rand_weight(rand:uniform(OtherPerhaps), WeightList, [])
    end.

%% 碰到0概率直接返回Item,不参与概率计算
rand_weight(_, [], NoPerhaps) ->
    NoPerhaps;
rand_weight(Rand, [0, Value | List], NoPerhaps) ->
    rand_weight(Rand, List, [Value | NoPerhaps]);
%% 根据奇数位的概率随机求偶数位 列表如:[50,3,30,5,20,10]
rand_weight(Rand, [Perhaps, Value | T], NoPerhaps) ->
    if
        Rand =< Perhaps ->
            [Value | NoPerhaps]; %% 返回[随机Value ++ 0概率Value]
        true ->
            rand_weight(Rand - Perhaps, T, NoPerhaps)
    end.

%% ----------------------------------------------------
%% Func: sum_odd (List)
%% Description: 计算奇数位的和
%% Args: [50,3,30,5,20,10]
%% Returns: 100
%% ----------------------------------------------------
sum_odd(List) ->
    sum_odd(List, 0).
sum_odd([], Sum) ->
    Sum;
sum_odd([A, _B | List], Sum) ->
    sum_odd(List, Sum + A).

%% 得到列表里某个值的所有位置,返回一个位置列表
%% 例如:get_value_index(true, [true,false,true,false,true,false,true,true])
%% [1,3,5,7,8]
get_value_index(Value, List) ->
    NumList = lists:seq(1, length(List)),
    F = fun(X, Y) ->
        case lists:nth(X, List) =:= Value of
            true -> [X | Y];
            false -> Y
        end
        end,
    lists:foldr(F, [], NumList).










