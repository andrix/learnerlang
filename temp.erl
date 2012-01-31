%% Excercise from:
%%  http://www.erlang.org/course/exercises.html

-module(temp).
-export([convert/1]).

convert({c, C}) -> {f, 9/5*C + 32};
convert({f, F}) -> {c, 5*(F - 32)/9}.

