-module(geometry). % must be same as file name
-export([area/1, perim/1]). % export area function which has 1 arg

% arguments are called patterns in erlang 
% area function has two clauses 

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side})             -> Side * Side;

% exercises chpt4
%1
area({circle, R}) -> math:pi() * R * R;
area({right_triangle, B, H}) -> 1/2 * B * H.

perim({square, Side}) -> Side * 4.
