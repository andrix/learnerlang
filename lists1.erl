%% Excercise from:
%%  http://www.erlang.org/course/exercises.html

-module(lists1).
-export([min/1, max/1]).

min([H]) -> H;
min([H|T]) -> min1(T, H).

min1([], Min) -> Min;
min1([H|T], Min) when H < Min -> min1(T, H);
min1([_|T], Min) -> min1(T, Min).

max([H]) -> H;
max([H|T]) -> max1(T, H).

max1([], Max) -> Max;
max1([H|T], Max) when H > Max -> max1(T, H);
max1([_|T], Max) -> max1(T, Max).

%% easy function consuming 2 time the list
min_max(L) -> {min(L), max(L)}.

