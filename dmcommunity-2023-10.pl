:- use_module(library(clpfd)).

sol(TOT, [C1, C2, C5, C10, C20, C50, C100]) :-
    C1   in 0..100,
    C2   in 0..50,
    C5   in 0..20,
    C10  in 0..10,
    C20  in 0..5,
    C50  in 0..2,
    C100 in 0..1,
    TOT #= C1*1 + C2*2 + C5*5 + C10*10 + C20*20 + C50*50 + C100*100,
    label([C1, C2, C5, C10, C20, C50, C100]).

%%  findall(S, sol(100, S), All), maplist(writeln, All).

%% ...

%% ...
