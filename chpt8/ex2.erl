-module(ex2).
-import(lists, [map/2, nth/2]).
-export([most_exported_funs/0]).

% finds module with most exported functions
most_exported_funs() ->
  All = code:all_loaded(),
  ModNames = map(fun(Tuple) -> element(1, Tuple) end, All),
  FindAmountExported = fun(ModName) -> 
    length(element(2, nth(2,apply(ModName, module_info, [])))) end,
  IndexOfMax = 
    fun Max([H | T], Index, CurrentMax, PrevModName) -> 
          case (AmountExported = FindAmountExported(H)) > CurrentMax of 
            true -> Max(T, Index + 1, AmountExported, H);
            false -> Max(T, Index + 1, CurrentMax, PrevModName)
          end;
          %io:fwrite("~w exported ~w ~n", [H, AmountExported]) ;
        Max([], _Index, CurrentMax, PrevModName) ->
          io:fwrite("~w exported the most functions: ~w ~n", [PrevModName, CurrentMax])
    end,
  IndexOfMax(ModNames, 0, 1, nothing).
  %io:fwrite("~w ~n",  AmountsExported).
  
%most_common_function_name() ->
%   All = code:all_loaded(),
%   ModNames = lists:map(fun(Tuple) -> element(1, Tuple) end, All),
%   lists:mapelement(2, nth(2,apply(ModName, module_info, [])))
