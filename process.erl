-module(process).
-export([test/1, echo_server/0, echo_client/2]).


echo_server() ->
    receive 
        {From, Msg} -> 
            io:format("echo_server: get ~p~n", [Msg]),
            From ! {self(), Msg},
            echo_server();
        stop ->
            true
    end.

echo_client(0, Echoserver) 
    -> Echoserver ! stop;
echo_client(M, Echoserver) ->
    Echoserver ! {self(), ping},
    io:format("echo_client: send ping~n"), 
    receive
        {_, _} ->
            io:format("echo_client: receive pong~n")
    end,
    echo_client(M - 1, Echoserver).


test(M) ->
    Echoserver = spawn(fun echo_server/0),
    spawn(?MODULE, echo_client, [M, Echoserver]).



