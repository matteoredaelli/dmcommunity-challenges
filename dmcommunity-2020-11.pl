/*:- use_module(library(clpz)). */
:- use_module(library(clpfd)).

shortest_path(From, To, Path):-
	From #>= 0,
	shortest_path(From, To, 0, Path).

shortest_path(From, To, MaxDepth, Path):-
	path(From, To, MaxDepth, Path),! .
shortest_path(From, To, MaxDepth, Path):-
	MaxDepth1 #= MaxDepth + 1,
	shortest_path(From, To, MaxDepth1, Path).

path(From, To, _MaxDepth, [[From, Op, To]]):-
	step(From, Op, To).

path(From, To, MaxDepth, [[From, Op, Mid]|Path]):-
	Mid #> From,
	To  #> Mid,
	MaxDepth #> 0,
	Depth1 #= MaxDepth - 1,
	step(From, Op, Mid),
	path(Mid, To, Depth1, Path).


step(N,*, M):-
	M #= N * 10.
step(N,+,M):-
	M #= N + 1.
