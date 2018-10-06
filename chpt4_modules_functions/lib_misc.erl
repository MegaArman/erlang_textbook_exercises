-module(lib_misc).
-export([for/3, qsort/1, perms/1, odds_and_evens1/1, odds_and_evens2/1, my_tuple_list/1]).

% erlang knows that if arg 1 and arg 2 are same
% call the first function clause here, so it is like a base case
for(Max, Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I) | for(I+1, Max, F)]. 
% ^ apply the function to the index value for the head, then
% call for again with next index value (RHS of |)
% basically F which the user provides is the body of the loop

% use like lib_misc:for(1,10, fun(I) -> I end). 
% ^ makes a list of numbers from 1 to 10



% base case is empty list
% Pivot is head of each cal
% T is tail of each call
qsort([]) -> [];
qsort([Pivot|T]) ->
  qsort([X || X <- T, X < Pivot]) % find everything less than pivot, then find everything less than the next pivot...
  % eventually everything less than pivot will be in order
  ++ [Pivot] ++  % append pivot
  qsort([X || X <- T, X >= Pivot]).
  % find everything greater than pivot..find everything greater than the next pivot
  % ...eventually everything here is sorted


perms([]) -> [[]];
perms(L) -> [ [H|T] || H <- L, T <- perms(L -- [H])].

% not efficient as it traverses the list twice:
odds_and_evens1(L) ->
  Odds = [X || X <- L, (X rem 2) =:= 1],
  Evens = [X || X <- L, (X rem 2) =:= 0],
  {Odds, Evens}.

% accumulator:
odds_and_evens2(L) ->
  odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
  case (H rem 2) of 
    1 -> odds_and_evens_acc(T, [H | Odds], Evens);
    0 -> odds_and_evens_acc(T, Odds, [H | Evens])
  end;

odds_and_evens_acc([], Odds, Evens) ->
  {Odds, Evens}.


