-module(exercises).
-export([map_search_pred/2, isProperSubset/2]).

% #2
% returns first element {Key, Value} in the map for which Pred(Key, Value) is true 
map_search_pred(Map, Pred) ->
  Keys = maps:keys(Map),
  map_search_pred(Keys, Map, Pred).

map_search_pred([FirstKey|OtherKeys], Map, Pred) ->
  Value = maps:get(FirstKey, Map),
  KeyValueValidity = Pred(FirstKey, Value),
  if
      KeyValueValidity == true ->
        {FirstKey, Value};
      KeyValueValidity == false ->
       map_search_pred(OtherKeys, Map, Pred)
  end; 
map_search_pred([], _, _) ->
  [].

% #3 ruby has the method "<" which returns true
% if a hash is a (proper) subset of another..we shall do this in erlang!
isProperSubset(M1, M2) -> 
  Pred = fun(Key) -> 
    maps:is_key(Key, M2) andalso (maps:get(Key, M1) == maps:get(Key, M2))
    end,
  Both = lists:filter(Pred, maps:keys(M1)), % keys which exist and have same vals in both
  (maps:keys(M1) ==  Both) and (M1 < M2).
