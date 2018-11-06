-module(ex4_person_lab).
-export([makePerson/2]).
-export_type([person/0]).

% type legs() :: {float(), float()}.

%pythagorean({Opp, Adj}) ->
%  math:sqrt(Opp * Opp + Adj * Adj).


% ex 1: I just made it pass for practice

-opaque person() :: {person, Name::[], Age:: 0..100}.

-spec makePerson(integer(), float()) -> person().
% -spec makeYoungerClone(person()) -> person().

makePerson(Name, Age) -> {person, Name, Age}.

% a younger, lighter clone
% makeYoungerClone({person, Name, Age}) -> {person, Name,  Age - 10}.
  
