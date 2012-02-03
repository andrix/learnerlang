-module(process_ring).
-export([test_ring/3, forward/1, sr_forward/2]).


test_ring(N, Msg, M) ->
    InitPid = ring(N),
    InitPid ! {msg, Msg, M}.

ring(N) ->
    Head = spawn(?MODULE, forward, [N]),
    Tail = make_ring(N-1, Head),
    Tail ! {gpid, Head},
    Head.

make_ring(0, TailPid) -> TailPid;
make_ring(K, InitPid) ->
    Pid = spawn(?MODULE, forward, [K]),
    InitPid ! {gpid, Pid},
    make_ring(K - 1, Pid).

forward(Id) ->
    io:format("Init forward: ~p~n", [Id]),
    receive 
        {gpid, From} -> 
            io:format("[~p] get pid: ~p~n", [Id, From]),
            sr_forward(Id, From)
    end.

sr_forward(Id, Next) ->
    receive
        {msg, Msg, M} when M > 0 ->
            io:format("[~p] get msg '~p' and M = ~p~n", [Id, Msg, M]),
            Next ! {msg, Msg, M -1},
            sr_forward(Id, Next);
        {msg, Msg, 0} ->
            io:format("[~p] get msg '~p' and M = ~p~n", [Id, Msg, 0]),
            io:format("[~p] send stop~n", [Id]),
            Next ! stop,
            sr_forward(Id, Next);
        stop -> 
            Next ! stop,
            io:format("[~p] stop recieved. bye~n", [Id]),
            true
    end.


            

        
