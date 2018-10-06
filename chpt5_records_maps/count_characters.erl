-module(count_characters).
-export([count_characters/1]).

% counts unique chars in a string
% this code is from the erlang mailing list, not the book
% the book was not up to date with the language standard
count_characters(Str) ->
  count_characters(Str, #{}).

% Char is the head, Rest is tail, Counts is a map
count_characters([Char | Rest], Counts) ->
  Count = maps:get(Char, Counts, 0), % 0 is a default if the key doesn't exist yet
  count_characters(Rest, maps:put(Char, Count + 1, Counts));
count_characters([], Counts) ->
  Counts.

