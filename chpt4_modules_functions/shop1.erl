% calculates total of a shop list
-module(shop1).
-export([total/1]).

total([{What, N} | T]) -> shop:cost(What) * N + total(T); 
%^  get the head (a tuple of form {milk, 3}) and use shop module to find cost, multiply by N, 
% call total with the remainder of the list

total([]) -> 0. % base case


