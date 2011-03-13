%% Simple module to test spawn a process and communicate through message
%% passing. 
-module(pingpong).

-export([run/0, sleep/1]).

run() -> 
    Pid = spawn(fun ping/0),
    pong(Pid).


%% Sleep function borrowed from the Programming Erlang book.
sleep(Millisecs) ->
    receive
    after Millisecs -> true
    end.

ping() ->
    receive
        From ->
            io:format("ping -> "),
            From ! pong,
            ping()
    end.


pong(Pid) ->
    % Send the message to ping.
    Pid ! self(),

    % Recieve a message from any process
    receive
        pong ->
            io:format("pong~n"),
            sleep(1000),
            pong(Pid)
    end.

        
