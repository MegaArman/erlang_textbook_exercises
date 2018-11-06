-module(ex1).
-export([pythagorean/1]).


% type legs() :: {float(), float()}.

%pythagorean({Opp, Adj}) ->
%  math:sqrt(Opp * Opp + Adj * Adj).


% ex 1: I just made it pass for practice
-type legs() :: {float(), float()}.
-spec pythagorean(legs()) -> integer().

pythagorean({Opp, Adj}) ->
  math:sqrt(Opp * Opp + Adj * Adj).



