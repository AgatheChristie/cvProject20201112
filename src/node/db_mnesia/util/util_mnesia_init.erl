%%%-------------------------------------------------------------------
%%% @author -author("kuffios@163.com").
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 11月 2020 10:33
%%%-------------------------------------------------------------------
-module(util_mnesia_init).
-author("kuffios@163.com").
-vsn('1.0.0').
-behaviour(gen_server).

%% API
-export([start_link/0, init_mnesia/2]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
    code_change/3]).

-define(SERVER, ?MODULE).

-record(util_mnesia_init_state, {}).

%%%===================================================================
%%% API
%%%===================================================================

%% @doc Spawns the server and registers the local name (unique)
-spec(start_link() ->
    {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%% @private
%% @doc Initializes the server
-spec(init(Args :: term()) ->
    {ok, State :: #util_mnesia_init_state{}} | {ok, State :: #util_mnesia_init_state{}, timeout() | hibernate} |
    {stop, Reason :: term()} | ignore).
init([]) ->
    {ok, #util_mnesia_init_state{}}.

%% @private
%% @doc Handling call messages
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
        State :: #util_mnesia_init_state{}) ->
    {reply, Reply :: term(), NewState :: #util_mnesia_init_state{}} |
    {reply, Reply :: term(), NewState :: #util_mnesia_init_state{}, timeout() | hibernate} |
    {noreply, NewState :: #util_mnesia_init_state{}} |
    {noreply, NewState :: #util_mnesia_init_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), Reply :: term(), NewState :: #util_mnesia_init_state{}} |
    {stop, Reason :: term(), NewState :: #util_mnesia_init_state{}}).
handle_call(_Request, _From, State = #util_mnesia_init_state{}) ->
    {reply, ok, State}.

%% @private
%% @doc Handling cast messages
-spec(handle_cast(Request :: term(), State :: #util_mnesia_init_state{}) ->
    {noreply, NewState :: #util_mnesia_init_state{}} |
    {noreply, NewState :: #util_mnesia_init_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), NewState :: #util_mnesia_init_state{}}).
handle_cast(_Request, State = #util_mnesia_init_state{}) ->
    {noreply, State}.

%% @private
%% @doc Handling all non call/cast messages
-spec(handle_info(Info :: timeout() | term(), State :: #util_mnesia_init_state{}) ->
    {noreply, NewState :: #util_mnesia_init_state{}} |
    {noreply, NewState :: #util_mnesia_init_state{}, timeout() | hibernate} |
    {stop, Reason :: term(), NewState :: #util_mnesia_init_state{}}).
handle_info(_Info, State = #util_mnesia_init_state{}) ->
    {noreply, State}.

%% @private
%% @doc This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
        State :: #util_mnesia_init_state{}) -> term()).
terminate(_Reason, _State = #util_mnesia_init_state{}) ->
    ok.

%% @private
%% @doc Convert process state when code is changed
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #util_mnesia_init_state{},
        Extra :: term()) ->
    {ok, NewState :: #util_mnesia_init_state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State = #util_mnesia_init_state{}, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
init_mnesia(_NodeType, _AppMod) ->
%%    mnesia:clear_table(shop),
    mnesia:delete_schema([node()]),
    mnesia:create_schema([node()]),
    mnesia:start(),
%%    mnesia:wait_for_tables([shop,cost,design], 20000),
    util_mnesia:init_mnesia_db().

