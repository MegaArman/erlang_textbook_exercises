-module(afile_server).
-export([start/1, loop/1]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
  receive % does pattern matching: see cases!
    {Client, list_dir} -> % case one
      Client ! {self(), file:list_dir(Dir)}; % reply to client with our pid and the file dir
    {Client, {get_file, File}} -> % case two, specific file
      Full = filename:join(Dir, File),
      Client ! {self(), file:read_file(Full)};
    
    % put_file exercise 4
    {Client, {put_file, Filename, Contents}} ->
      Full = filename:join(Dir, Filename),
      Client ! {self(), file:write_file(Full, Contents)}
  
  end,
  loop(Dir).
  %this is an infinite loop, but it's ok as there is the tail-call optimization
  %won't run out of stack space


