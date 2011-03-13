-module(pingpong).

-export([run/0, sleep/1]).

run() -> 
    Pid = spawn(fun ping/0),
    pong(Pid).

sleep(Millisecs) ->
    receive
    after Millisecs -> true
    end.

pong(Pid) ->
    Pid ! self(),
    receive
        pong -> 
            io:format("pong~n"),
            sleep(1000),
            pong(Pid)
    end.

ping() ->
    receive
        From -> 
            io:format("ping -> "),
            From ! pong,
            ping()
    end.

        
