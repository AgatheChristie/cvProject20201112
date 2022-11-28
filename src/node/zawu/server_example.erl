-module(server_example).

-include("user_info.hrl").
-include("goods_info.hrl").
-include("common.hrl").

%% API
-export([start_link/0, userNumber/0, userMatching/0, goodsNumber/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
    code_change/3]).

-define(SERVER, ?MODULE).
-record(server_example_state, {}).


%%%===================================================================
%%% MY FUNC
%%%===================================================================

%server_example:userNumber().
%用户在线人数。
userNumber() ->
    gen_server:call(server_example, {userNumber}).
%server_example:userMatching().
%比武匹配
userMatching() ->
    gen_server:call(server_example, {matching}).

%查询当前物品数量
%server_example:goodsNumber("all").
goodsNumber(GoodsName) ->
    gen_server:call(server_example, {goodsNumber, GoodsName}).



%%%===================================================================
%%% API
%%%===================================================================

%% @doc Spawns the server and registers the local name (unique)
-spec(start_link() ->
    {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).

start_link() ->
    ?ERROR("start start"),
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).



%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
%% @doc Initializes the server
-spec(init(Args :: term()) ->
    {ok, State :: #server_example_state{}} | {ok, State :: #server_example_state{}, timeout() | hibernate} |
    {stop, Reason :: term()} | ignore).


init([]) ->
    ?ERROR("init init"),
    initialize_ets(),
    initialize_ets_goods(),
    start_parallel_server(),
    {ok, ets:new(mysocket, [public, named_table])}.



%% @private
%% @doc Handling call messages
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
        State :: #server_example_state{}) ->
    {reply, Reply :: term(), NewState :: #server_example_state{}} |
    {reply, Reply :: term(), NewState :: #server_example_state{}, timeout() | hibernate} |
    {noreply, NewState :: #server_example_state{}} |
    {noreply, NewState :: #server_example_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), Reply :: term(), NewState :: #server_example_state{}} |
    {stop, Reason :: term(), NewState :: #server_example_state{}}).


%登录的时候添加socket
handle_call({addSocket, UserName, Socket}, _From, Tab) ->
    Reply = case ets:lookup(Tab, UserName) of
                [{UserName, Socket}] ->
                    have_socket;
                [] ->
                    ets:insert(Tab, {UserName, Socket})
            end,

    {reply, Reply, Tab};

%退出的时候，删除socket
handle_call({deleteSocket, UserName, Socket}, _From, Tab) ->
    Reply = case ets:lookup(Tab, UserName) of
                [{UserName, Socket}] ->
                    ets:delete(Tab, UserName);

                [] ->
                    ?ERROR("no exist this  socket ~p~n", [Socket])
            end,

    {reply, Reply, Tab};
%购买物品
handle_call({shop, CvUser, {What, N}}, _From, Tab) ->
    [A1] = ets:lookup(goods, What),
    Price = N * A1#goods.cost,
    Reply = if
                CvUser#user.coin - Price > 0 ->
                    info_update(CvUser#user.name, #user.coin, CvUser#user.coin - Price),
                    goods_update(A1#goods.name, #goods.quantity, A1#goods.quantity - N),
                    "success";
    %%金币不够
                true ->
                    "coinNotEnough"
            end,
    {reply, Reply, Tab};
%用户在线个数
handle_call({userNumber}, _From, Tab) ->
    Socketlist = ets:tab2list(Tab),
    ?ERROR("~p user online~n", [length(Socketlist)]),
    Reply = length(Socketlist),
    {reply, Reply, Tab};
%比武匹配   server_example:userMatching().
handle_call({matching}, _From, Tab) ->
    %找到在线的人，开始匹配
    Socketlist = ets:match_object(test, #user{state = 1, _ = '_'}),
    ListA = lists:keysort(#user.arena_score, Socketlist),
    F = fun(GoodsType) ->
        erlang:element(#user.name, GoodsType)
        end,
    Reply = cvListLast(lists:map(F, ListA)),
    {reply, Reply, Tab};

%查询物品数量
%%server_example:goodsNumber("all").
handle_call({goodsNumber, GoodsName}, _From, Tab) ->
    case GoodsName of
        "all" ->
            Socketlist = ets:tab2list(goods),
            F = fun(GoodsType) ->
%%                ?ERROR("~p left ~p end", [erlang:element(3, GoodsType), erlang:element(4, GoodsType)])
                ?ERROR("~p cvleft ~p end", [GoodsType#goods.name, GoodsType#goods.quantity])
                end,
            lists:foreach(F, Socketlist);
        GoodsName ->
            [A1] = ets:lookup(goods, GoodsName),
            ?ERROR("~p left ~p end", [A1#goods.name, A1#goods.quantity])
    end,
    {reply, ok, Tab};
%广播信息
handle_call({sendAllMessage, Name, Msg}, _From, Tab) ->
    Socketlist = [{UserName, Socket} || {UserName, Socket} <- ets:tab2list(Tab), UserName =/= Name],
    ?ERROR("list ~p~n", [Socketlist]),
    lists:foreach(
        fun({_UserName, Socket}) ->
            N = term_to_binary(Name),
            M = term_to_binary(Msg),
            Packet = <<0010:16, (byte_size(N)):16, N/binary, (byte_size(M)):16, M/binary>>,
            gen_tcp:send(Socket, Packet)
        end,
        Socketlist
    ),

    {reply, [], Tab};



handle_call(_Request, _From, State = #server_example_state{}) ->
    {reply, ok, State}.

%% @private
%% @doc Handling cast messages
-spec(handle_cast(Request :: term(), State :: #server_example_state{}) ->
    {noreply, NewState :: #server_example_state{}} |
    {noreply, NewState :: #server_example_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), NewState :: #server_example_state{}}).
handle_cast(_Request, State = #server_example_state{}) ->
    {noreply, State}.

%% @private
%% @doc Handling all non call/cast messages
-spec(handle_info(Info :: timeout() | term(), State :: #server_example_state{}) ->
    {noreply, NewState :: #server_example_state{}} |
    {noreply, NewState :: #server_example_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), NewState :: #server_example_state{}}).
handle_info(_Info, State = #server_example_state{}) ->
    {noreply, State}.

%% @private
%% @doc This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
        State :: #server_example_state{}) -> term()).
terminate(_Reason, _State = #server_example_state{}) ->
    ok.

%% @private
%% @doc Convert process state when code is changed
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #server_example_state{},
        Extra :: term()) ->
    {ok, NewState :: #server_example_state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State = #server_example_state{}, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================



%开启服务器
start_parallel_server() ->
    {ok, Listen} = gen_tcp:listen(2345, [binary, {packet, 0}, {reuseaddr, true}, {active, true}]),
    spawn(fun() -> per_connect(Listen) end).

%每次绑定一个当前Socket后再分裂一个新的服务端进程，再接收新的请求
per_connect(Listen) ->
    {ok, Socket} = gen_tcp:accept(Listen),
    spawn(fun() -> per_connect(Listen) end),
    loop(Socket).


%从数据库取   这里为方便直接初始化
initialize_ets() ->
    ets:new(test, [set, public, named_table, {keypos, #user.name}]),
    ets:insert(test, #user{id = 01, name = "carlos", passwd = "123", login_times = 0, chat_times = 0, last_login = {}, state = 0, coin = 500.0, arena_score = 2235}),
    ets:insert(test, #user{id = 02, name = "qiqi", passwd = "123", login_times = 0, chat_times = 0, last_login = {}, state = 0, coin = 400.0, arena_score = 6674}),
    ets:insert(test, #user{id = 03, name = "zhuque", passwd = "123", login_times = 0, chat_times = 0, last_login = {}, state = 0, coin = 50.0, arena_score = 9074}),
    ets:insert(test, #user{id = 04, name = "baihu", passwd = "123", login_times = 0, chat_times = 0, last_login = {}, state = 0, coin = 150.0, arena_score = 5552}),
    ets:insert(test, #user{id = 05, name = "cym", passwd = "123", login_times = 0, chat_times = 0, last_login = {}, state = 0, coin = 1000.0, arena_score = 2340}).
%从数据库取   这里为方便直接初始化
initialize_ets_goods() ->
    ets:new(goods, [set, public, named_table, {keypos, #goods.name}]),
    ets:insert(goods, #goods{id = 01, name = "apple", quantity = 20, cost = 1.5}),
    ets:insert(goods, #goods{id = 02, name = "orange", quantity = 100, cost = 2.4}),
    ets:insert(goods, #goods{id = 03, name = "pear", quantity = 200, cost = 2.2}),
    ets:insert(goods, #goods{id = 04, name = "banana", quantity = 420, cost = 1.5}),
    ets:insert(goods, #goods{id = 05, name = "potato", quantity = 2456, cost = 0.6}).

%查询ets
info_lookup(Key) ->
    %返回值是一个元组
    ets:lookup(test, Key).

%修改ets信息
info_update(Key, Pos, Update) ->
    ets:update_element(test, Key, {Pos, Update}).
%修改ets信息
goods_update(Key, Pos, Update) ->
    ets:update_element(goods, Key, {Pos, Update}).

%返回符合题目格式的列表
cvListLast(List) ->
    Bool = length(List) rem 2,
    if
        Bool =:= 0 ->
            cvListLastEven([], List);
        true ->
            Temp1 = lists:last(List),
            cvListLastOdd([{Temp1, "GM"}], lists:droplast(List))
    end.

cvListLastOdd(Acc, []) ->
    Acc;
cvListLastOdd(Acc, [A, B | T]) ->
    cvListLastEven([{A, B} | Acc], T).

cvListLastEven(Acc, []) ->
    Acc;
cvListLastEven(Acc, [A, B | T]) ->
    cvListLastEven([{A, B} | Acc], T).







%接收信息并处理
loop(Socket) ->
    ?ERROR("server loop..... Socket is ~p end", [Socket]),
    receive
        {tcp, Socket, Bin} ->
            ?ERROR("loop receive BinBin Socket is ~p  end", [Socket]),  %这个Socket和前面的Socket一样的，如果不一样就进行下一个模式匹配
            <<State:16, Date/binary>> = Bin,  %State状态码
            <<Size1:16, Date1/binary>> = Date,  %姓名的长度
            <<Str1:Size1/binary, Date2/binary>> = Date1, %Str1 名字
            <<Size2:16, Date3/binary>> = Date2,  %密码的长度
            <<Str2:Size2/binary, _Date4/binary>> = Date3,   %Str2 密码

            case State of
                0000 ->
                    Name = binary_to_term(Str1),
                    ?ERROR("logining  ~p ~n", [Name]), %cym
                    case info_lookup(Name) of
                        [CvUser = #user{}] ->
                            ?ERROR("CvUser is ~p end", [CvUser]),
                            S = term_to_binary("success"),
                            N = term_to_binary(Name),
                            Packet = <<0000:16, (byte_size(S)):16, S/binary, (byte_size(N)):16, N/binary>>,
                            %处理一下业务， 登录次数加1 状态改为 1，登录时间在退出的时候才修改,
                            %mysocket如果还没有添加socket就添加一下socket
                            gen_server:call(server_example, {addSocket, CvUser#user.name, Socket}),
                            info_update(CvUser#user.name, #user.login_times, CvUser#user.login_times + 1),
                            info_update(CvUser#user.name, #user.state, 1),
                            ?ERROR("after logining ~p~n", [info_lookup(CvUser#user.name)]),
                            gen_tcp:send(Socket, Packet),
                            ?ERROR("user ~p have logged~n", [Name]),
                            loop(Socket);

                        [] ->
                            ?ERROR("you haved not registered yet"),
                            F = term_to_binary("failed"),
                            N = term_to_binary(Name),
                            Packet = <<0000:16, (byte_size(F)):16, F/binary, (byte_size(N)):16, N/binary>>,
                            gen_tcp:send(Socket, Packet),
                            loop(Socket)
                    end;

                %接收信息
                0001 ->
                    Name = binary_to_term(Str1),
                    Msg = binary_to_term(Str2),
                    [#user{chat_times = Ccount, state = LoginState}] = info_lookup(Name),
                    %更新聊天次数
                    case LoginState of
                        1 -> info_update(Name, 6, Ccount + 1),
                            N = term_to_binary({"ok", "received"}),
                            Len = byte_size(N),
                            Packet = <<0001:16, Len:16, N/binary>>,
                            ?ERROR("received  the  Msg  ~ts : ~ts~n", [Name, Msg]),
                            %广播信息
                            gen_tcp:send(Socket, Packet),
                            gen_server:call(server_example, {sendAllMessage, Name, Msg}),
                            loop(Socket);  %loop(Pid,Socket);
                        0 ->
                            N = term_to_binary({"failed", "noLogin"}),
                            Len = byte_size(N),
                            Packet = <<0001:16, Len:16, N/binary>>,
                            ?ERROR("user ~p  no login", [Name]),
                            gen_tcp:send(Socket, Packet),
                            loop(Socket)
                    end;
                %购买物品
                0003 ->
                    Name = binary_to_term(Str1),
                    Goods = binary_to_term(Str2),
                    [CvUser = #user{}] = info_lookup(Name),
                    case CvUser#user.state of
                        1 ->
                            Re = gen_server:call(server_example, {shop, CvUser, Goods}),
                            case Re of
                                "success" ->
                                    S = term_to_binary("shopsuccess"),
                                    N = term_to_binary(Name),
                                    Packet = <<0003:16, (byte_size(S)):16, S/binary, (byte_size(N)):16, N/binary>>,
                                    gen_tcp:send(Socket, Packet);
                                "coinNotEnough" ->
                                    S = term_to_binary("coinNotEnough"),
                                    N = term_to_binary(Name),
                                    Packet = <<0003:16, (byte_size(S)):16, S/binary, (byte_size(N)):16, N/binary>>,
                                    gen_tcp:send(Socket, Packet)
                            end,
                            loop(Socket);
                        0 ->
                            N = term_to_binary({"failed", "noLogin"}),
                            Len = byte_size(N),
                            Packet = <<0003:16, Len:16, N/binary>>,
                            ?ERROR("user ~p  no login", [Name]),
                            gen_tcp:send(Socket, Packet),
                            loop(Socket)
                    end;


                0002 ->
                    Name = binary_to_term(Str2),
                    ?ERROR("see ~p: ~p~n", [Name, info_lookup(Name)]),
                    [#user{login_times = _Log, last_login = _LastLo}] = info_lookup(Name),
                    Last = calendar:now_to_local_time(erlang:timestamp()), % 4.格式化时间
                    % mysocket里，去除这个socket。
                    gen_server:call(server_example, {deleteSocket, Name, Socket}),
                    N = term_to_binary("ok"),
                    Packet = <<0002:16, (byte_size(N)):16, N/binary>>,
                    gen_tcp:send(Socket, Packet),
                    %修改最后登录时间
                    info_update(Name, 7, Last),
                    info_update(Name, 8, 0),
                    ?ERROR("after logout ~p", [info_lookup(Name)]),
                    loop(Socket)

            end;

        {tcp_closed, Socket} ->  %此时不再循环loop这个服务器分裂的进程结束
            ?ERROR("Server socket is ~p closed", [Socket]),
            NN = case ets:match(mysocket, {'$1', Socket}) of
                     [[Name2]] ->

                         ?ERROR("user:~p  close client", [Name2]),
                         Name2;

                     F ->
                         ?ERROR("yijing logout le is ~p end", [F]),
                         "ddd"
                 end,
            case NN of
                "ddd" ->
                    ?ERROR("yijing logout le");

                Name ->
                    [#user{login_times = _Log, last_login = _LastLo}] = info_lookup(Name),
                    Last = calendar:now_to_local_time(erlang:timestamp()),
                    gen_server:call(server_example, {deleteSocket, Name, Socket}),
                    info_update(Name, 7, Last),
                    info_update(Name, 8, 0),
                    ?ERROR("after logout ~p", [info_lookup(Name)])

            end

    end.











