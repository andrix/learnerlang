%% Excercise from:
%%  http://www.erlang.org/course/exercises.html

-module(time).
-export([swedish_time/0]).

to_str_and_add_zero(Int) when Int < 10 
    -> integer_to_list(0) ++ integer_to_list(Int);
to_str_and_add_zero(Int) 
-> integer_to_list(Int).

swedish_time() -> 
    {Y, M, D} = date(),
    YY = Y rem 100,
    to_str_and_add_zero(YY) ++ to_str_and_add_zero(M) ++ to_str_and_add_zero(D).


