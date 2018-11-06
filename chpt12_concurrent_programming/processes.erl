-module(processes).
-export([max/1]).

%% max(N) 

%% Create N processes then destroy them
%% See how much time this takes

max(N) ->
  Max = erlang:system_info(process_limit),
  io:format("Maximum # allowed proccesses:~p ~n", [Max]),
  statistics(runtime), % time spent running code 
  statistics(wall_clock), % human time passed
  % spawn N processes
  L = for(1, N, fun() -> spawn(fun() -> wait() end) end),
  {_, Time1} = statistics(runtime),
  {_, Time2} = statistics(wall_clock),
  lists:foreach(fun(Pid) -> Pid ! die end, L),
  U1 = Time1 * 1000 / N,
  U2 = Time2 * 1000 / N,
  io:format("Process spawn time = ~p (~p) microseconds ~n", [U1, U2]).

% spawn a process which waits for a die atom then returns void
wait() ->
  receive 
    die -> void
  end.

% when first and second arg are the same (last iteration):
% return a list wtih a single pid
for(N, N, F) -> [F()];

% when first and second arg are different:
% 1st  call: head | tail, 2nd call: head | tail ... until N = N
for(I, N, F) -> [F() | for(I+1, N, F)].
