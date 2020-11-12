%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(m1).
-export([loop/1, run_fun/0, run_fun2/0]).

-include("common.hrl").

-ifdef(DEBUG).
-define(CC(X), io:format("DEBUG ~p:~p ~p~n",[?MODULE, ?LINE, X])).

-else.
-define(CC(X), void).

-endif.
%%m1:my_test().  throw(dawfaf).
loop(0) ->
    done;
loop(N) ->  
    ?CC(N),
    loop(N-1).
run_fun() ->
    ?CVI("11111111").
run_fun2() ->
    ?CVI("2222222222").