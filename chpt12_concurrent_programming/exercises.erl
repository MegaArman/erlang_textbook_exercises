-module(exercises).
-export([start/2, ring/2]).

% ex 1
start(AnAtom, Fun) ->
  register(AnAtom, spawn(Fun)).

% ex3 
% to acheive a ring, we need processes to send messages like so (supposing 3 processes):  A->B->C->A ...
% for that to work we must have a means for A to give B reference to C 
for(N, N, F) -> [F()];
for(I, N, F) -> [F() | for(I+1, N, F)].

% spawn a process which waits for a PID to send a message too
wait() ->
  receive 
    %5 case for last element on the last cycle
    {_From, PIDs, [], M, M} ->
      % io:fwrite("I (~p) got a message from ~p and now we are completely done! ~n", [self(), From]),
    {_, Time1} = statistics(runtime),
    {_, Time2} = statistics(wall_clock),

    U1 = Time1 * 1000,
    U2 = Time2 * 1000,
    io:format("Time to cycle ~p processes ~p times = ~p (~p) microseconds ~n", [length(PIDs), M, U1, U2]);
   %4 case for non last elements when on the last cycle 
    {_From, PIDs, [To | Others], M, M} ->
      %io:fwrite("I (~p) got a message from ~p and will send my pid to ~p then DIE  ~n", [self(), From, To]),
      To ! {self(), PIDs, Others, M, M};
   %3 case for last element in nonlast cycle
   {_From, PIDs, [], I, M} ->
      FirstPID = hd(PIDs),
     % io:fwrite("I (~p) got a message from ~p and will send my pid to ~p, as I am the LAST PROCESS IN CYCLE ~n", 
     %   [self(), From, FirstPID]),
      FirstPID ! {self(), PIDs, tl(PIDs), I + 1, M},
      wait();
    %2 case for non last elements in non last cycle...PIDs is all the original PIDs,
    %Others- starts two ahead from the current
    {_From, PIDs, [To | Others], I, M} -> 
      %io:fwrite("I (~p) got a message from ~p and will send my pid to ~p ~n", [self(), From, To]),
      To ! {self(), PIDs, Others, I, M},
      wait()
    end.

% starting the cycle
start_cycle(PIDs, [H|T], M) ->
  H ! {self(), PIDs, T, 1, M}.

ring(N, M) ->
  Max = erlang:system_info(process_limit),
  io:format("Maximum # allowed proccesses:~p ~n", [Max]),
  statistics(runtime), % time spent running code 
  statistics(wall_clock), % human time passed

  % spawn N processes and store their pids in a list
  PIDs = for(1, N, fun() -> spawn(fun() -> wait() end) end), 
  start_cycle(PIDs,PIDs, M). 
