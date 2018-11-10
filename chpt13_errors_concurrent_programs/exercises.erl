-module(exercises).
-export([f/0, test_my_spawn/0, test_keep_alive/0, test_keep_multiple_alive/0, test_keep_link_set_alive/0]).

% ex1, ex2, and ex, Piu3
% plan: make the process and another who monitors it and prints the error and time it lived
on_exit(Pid, Fun, Time) -> 
  spawn(fun() -> 
    Ref = monitor(process, Pid),
    receive
      {'DOWN', Ref, process, Pid, Why} ->
        Fun(Why)
    after 
      Time ->
        io:fwrite("time is up for ~p ~n", [Pid]),
        exit(Pid, "time is up"),
        io:fwrite("didn't killmyself woohoo ~n")
    end
  end).

% Time to let the process live after being spawned
my_spawn(Mod, Func, Args, Time) ->
  statistics(runtime),
  statistics(wall_clock),
  Pid = spawn(Mod, Func, Args),
  on_exit(Pid, 
    fun(Why) ->
      {_, Time1} = statistics(runtime),
      {_, Time2} = statistics(wall_clock),

      U1 = Time1 * 1000,
      U2 = Time2 * 1000,
      io:format("~p died with:~p. It lived for ~p (~p) microseconds ~n", [Pid, Why, U1, U2]) 
    end,
    Time).

f() ->
  io:fwrite("spawned f: I (~p) exit after 5 seconds ~n", [self()]),
  timer:sleep(5000),
  exit("normal behavior").

% ?MODULE means this module
test_my_spawn() ->
  % test ex1 and 2
  my_spawn(?MODULE, f, [], 6000),
  % test ex 3
  my_spawn(?MODULE, f, [], 4000).


%ex 4--------------------------------------------
running() -> 
    timer:sleep(5000),
    io:format("I'm (~p) still running ~n", [self()]),
    running().

g() -> 
  Running = fun() -> running() end,
  Pid = spawn(Running),
  register(ex4, Pid),
  Pid.

% keeps an existing process alive by restarting it if it dies
keep_alive(Fun, Pid) ->
  on_exit(Pid, 
    fun(Why) ->
      io:format("will restart due to: ~p", [Why]),
      NewPid = Fun(),
      keep_alive(Fun, NewPid) 
    end, infinity).
  
% test ex 4
test_keep_alive() -> 
  G = fun() -> g() end, % need inner func to avoid exporting
  Pid = G(),
  keep_alive(G, Pid),
  timer:sleep(6000),
  exit(Pid, "to see if it is restarted").  

% ex5
keep_multiple_alive(Fs) ->
SpawnMonitor = 
  fun(F) -> 
    Pid = spawn(F),
    keep_alive(F, Pid)
  end,
spawn(
  fun() ->     
    [SpawnMonitor(F) || F <- Fs]
  end).

test_keep_multiple_alive() ->
  R = fun() -> running() end, 
  Fs = [R, R],
  keep_multiple_alive(Fs).

% ex 6: strategy, make a process which spawn_links and monitor this process 
% with another process: master -> monitor -> process maker -> child processes 
keep_link_set_alive(Fs) ->
  StartLinkSet = fun() -> 
    spawn(
      fun() ->     
        [spawn_link(F) || F <- Fs],
        receive 
          after 
            infinity -> true
        end
      end)
  end,
  Pid = StartLinkSet(),
  io:format("the pid of the spawner process is ~p ~n", [Pid]),
  keep_alive(StartLinkSet, Pid).

test_keep_link_set_alive() ->
  R = fun() -> running() end, 
  Fs = [R, R],
  keep_link_set_alive(Fs).
