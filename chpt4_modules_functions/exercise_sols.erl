-module(exercise_sols).
-export([area/1, perim/1, my_tuple_list/1, big_factorial/0, my_time_func/1, my_date_string/0, even/1, odd/1, filter/2, split/1]).

% chpt 4 exercises
% # 1
area({circle, R}) -> math:pi() * R * R;
area({right_triangle, B, H}) -> 1/2 * B * H.

perim({square, Side}) -> Side * 4.
% # 2 
my_tuple_list(Tuple) ->
  my_tuple_list_acc(Tuple, tuple_size(Tuple), [], 1).
  
my_tuple_list_acc(Tuple, Tuple_Size, List, Index) ->
% io:fwrite("inside"),
if 
  Index =< Tuple_Size  ->
    my_tuple_list_acc(Tuple, Tuple_Size, [element(Index, Tuple) | List], Index+1);
  true ->
    lists:reverse(List)
  end.

% #3
big_factorial() ->
 MyFactorial = fun 
    Factorial(N) when N > 0 ->
      N * Factorial(N - 1);
    Factorial(0) ->
      1
 end,
 MyFactorial(100).

my_time_func(F) -> % calcs the time it takes to execute a function
  T1 = erlang:timestamp(),
  F(),
  T2 = erlang:timestamp(),
  element(3, T1) - element(3, T2).
%invoked from shell like:
%1> c(exercise_sols).
%{ok,exercise_sols}
%2> exercise_sols:my_time_func(fun exercise_sols:big_factorial/0).
%-75
%3> 

my_date_string() ->
  Time = time(),
  Hour = element(1, Time),
  Minute = element(2, Time),
  Date = date(),
  Year = element(1, Date),
  Month = element(2, Date),
  Day = element(3, Date),
  io:fwrite("The time is ~w:~w and the date is ~w/~w/~w ~n", [Hour, Minute, Year, Month, Day]).

% 4 - not needed

% 5 
even(N) ->
   N rem 2 =:= 0.

odd(N) ->
   N rem 2 =:= 1.

% 6 
filter(F, L) ->
  [X || X <- L, F(X)].

% 7
  %without accumulator O(2N)
%split(L) ->
  %IsEven = fun(X) -> X rem 2 =:= 0 end,
  %IsOdd = fun(X) -> X rem 2 =:= 1 end, 
  %{filter(IsEven, L), filter(IsOdd, L)}.

% with accumulator O(N), though result is in reverse order
split(L) ->
  split_acc(L, [], []).

split_acc([H|T], Odds, Evens) ->
  case (H rem 2) of 
    1 -> split_acc(T, [H | Odds], Evens);
    0 -> split_acc(T, Odds, [H | Evens])
  end;
split_acc([], Odds, Evens) ->
 {Odds, Evens}. 
