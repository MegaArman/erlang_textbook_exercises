-module(exercises).
-export([map_search_pred/2]).

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
