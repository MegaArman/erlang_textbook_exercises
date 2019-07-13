-module(exercises_test).
-import(exercises, [isProperSubset/2]).
-export([test/0]).

test() ->
  M1 = #{"a" => 1, "b" => 2}, % Map 1
  M2 = #{"a" => 1, "b" => 2, "c" => 3}, 
  M3 = #{"a" => 2, "b" => 2},
  true = isProperSubset(M1, M2),
  false = isProperSubset(M2, M1),
  false = isProperSubset(M1, M3),
  false = isProperSubset(M1, M1), % proper subset must not be of same size 
  passed.
