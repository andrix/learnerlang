%% Excercise from:
%%  http://www.erlang.org/course/exercises.html

-module(mathStuff).
-export([perimeter/1]).


perimeter({square, Side}) ->
    Side * Side;
perimeter({circle, Radius}) ->
    2 * Radius * math:pi();
perimeter({triangle, A, B, C}) ->
    A + B + C.
