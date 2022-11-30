%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(test_mnesia).
-import(lists, [foreach/2]).


%% IMPORTANT: The next line must be included
%%            if we want to call qlc:q(...)

-include_lib("stdlib/include/qlc.hrl").
-include("goods_info.hrl").
-export([do_this_once/0, start/0, demo/1, add_cvshop_item/3, remove_cvshop_item/1, farmer/1, reset_tables/0, add_plans/0, get_plan/1]).



do_this_once() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(cvshop, [{attributes, record_info(fields, cvshop)}]),
    mnesia:create_table(cost, [{attributes, record_info(fields, cost)}]),
    mnesia:create_table(design, [{attributes, record_info(fields, design)}]),
    mnesia:stop().

start() ->
    mnesia:start(),
    mnesia:wait_for_tables([cvshop, cost, design], 20000).

%% SQL equivalent
%%  SELECT * FROM cvshop;

demo(select_cvshop) ->
    do(qlc:q([X || X <- mnesia:table(cvshop)]));


%% SQL equivalent
%%  SELECT item, quantity FROM cvshop;

demo(select_some) ->
    do(qlc:q([{X#cvshop.item, X#cvshop.quantity} || X <- mnesia:table(cvshop)]));


%% SQL equivalent
%%   SELECT cvshop.item FROM cvshop
%%   WHERE  cvshop.quantity < 250;

demo(reorder) ->
    do(qlc:q([
        X#cvshop.item || X <- mnesia:table(cvshop),
        X#cvshop.quantity < 250
    ]));
%% SQL equivalent
%%   SELECT cvshop.item
%%   FROM cvshop, cost 
%%   WHERE cvshop.item = cost.name 
%%     AND cost.price < 2
%%     AND cvshop.quantity < 250

demo(join) ->
    do(qlc:q([
        X#cvshop.item || X <- mnesia:table(cvshop),
        X#cvshop.quantity < 250,
        Y <- mnesia:table(cost),
        X#cvshop.item =:= Y#cost.name,
        Y#cost.price < 2
    ])).

do(Q) ->
    F = fun() ->
        qlc:e(Q)
        end,
    {atomic, Val} = mnesia:transaction(F),
    Val.


example_tables() ->
    [%% The cvshop table
        {cvshop, apple, 20, 2.3},
        {cvshop, orange, 100, 3.8},
        {cvshop, pear, 200, 3.6},
        {cvshop, banana, 420, 4.5},
        {cvshop, potato, 2456, 1.2},
        %% The cost table
        {cost, apple, 1.5},
        {cost, orange, 2.4},
        {cost, pear, 2.2},
        {cost, banana, 1.5},
        {cost, potato, 0.6}
    ].

add_cvshop_item(Name, Quantity, Cost) ->
    Row = #cvshop{item = Name, quantity = Quantity, cost = Cost},
    F = fun() ->
        mnesia:write(Row)
        end,
    mnesia:activity(transaction,F).

remove_cvshop_item(Item) ->
    Oid = {cvshop, Item},
    F = fun() ->
        mnesia:delete(Oid)
        end,
    mnesia:transaction(F).


farmer(Nwant) ->
    %% Nwant = Number of oranges the farmer wants to buy
    F = fun() ->
        %% find the number of apples
        [Apple] = mnesia:read({cvshop, apple}),
        Napples = Apple#cvshop.quantity,
        Apple1 = Apple#cvshop{quantity = Napples + 2 * Nwant},
        %% update the database
        mnesia:write(Apple1),
        %% find the number of oranges
        [Orange] = mnesia:read({cvshop, orange}),
        NOranges = Orange#cvshop.quantity,
        if
            NOranges >= Nwant ->
                N1 = NOranges - Nwant,
                Orange1 = Orange#cvshop{quantity = N1},
                %% update the database
                mnesia:write(Orange1);
            true ->
                %% Oops -- not enough oranges
                mnesia:abort(oranges)
        end
        end,
    mnesia:transaction(F).


reset_tables() ->
    mnesia:clear_table(cvshop),
    mnesia:clear_table(cost),
    F = fun() ->
        foreach(fun mnesia:write/1, example_tables())
        end,
    mnesia:transaction(F).



add_plans() ->
    D1 = #design{id = {joe, 1},
        plan = {circle, 10}},
    D2 = #design{id = fred,
        plan = {rectangle, 10, 5}},
    D3 = #design{id = {jane, {house, 23}},
        plan = {house,
            [{floor, 1,
                [{doors, 3},
                    {windows, 12},
                    {rooms, 5}]},
                {floor, 2,
                    [{doors, 2},
                        {rooms, 4},
                        {windows, 15}]}]}},
    F = fun() ->
        mnesia:write(D1),
        mnesia:write(D2),
        mnesia:write(D3)
        end,
    mnesia:transaction(F).

get_plan(PlanId) ->
    F = fun() -> mnesia:read({design, PlanId}) end,
    mnesia:transaction(F).

