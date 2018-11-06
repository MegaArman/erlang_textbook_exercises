-module(ex4_clone_lab).
-export([makeYoungerClone/2]).
-import('ex4_person_lab', [makePerson/2]).

makeYoungerClone(Age, Name) ->
  Original = makePerson(Age, Name),
  element(3, Original) - 10.

% type legs() :: {float(), float()}.

%pythagorean({Opp, Adj}) ->
%  math:sqrt(Opp * Opp + Adj * Adj).


% ex 1: I just made it pass for practice

%-opaque person() :: {person, Name::[], Age:: 0..100}.
%
%-spec makePerson(integer(), float()) -> person().
%-spec makeYoungerClone(person()) -> person().
%
%makePerson(Name, Age) -> {person, Name, Age}.
%
%% a younger, lighter clone
%makeYoungerClone({person, Name, Age}) -> {person, Name,  Age - 10}.
  
