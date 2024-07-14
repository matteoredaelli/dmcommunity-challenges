%% https://dmcommunity.org/challenge/challenge-july-2024/

:- use_module(library(simplex)).

%% sol(S), variable_value(S, x1, QuantityABC), variable_value(S, x2, QuantityXYZ), variable_value(S, x3, QuantityTTT), variable_value(S, x4, QuantityLMN).

sol(S) :-
        gen_state(S0),
        my_constraints(S0, S1),
        maximize([35*x1, 60*x2, 125*x3, 40*x4], S1, S).

my_constraints -->
    constraint([25*x1] >= 1000),
    constraint([25*x1] =< 5000),
    constraint([50*x2] >= 1000),
    constraint([50*x2] =< 5000),
    constraint([100*x3] >= 1000),
    constraint([100*x3] =< 5000),
    constraint([25*x4] >= 1000),
    constraint([25*x4] =< 5000),
    constraint([25*x1, 50*x2, 100*x3, 25*x4] =< 10000),
    constraint([x1] >= 0),
    constraint([x2] >= 0),
    constraint([x3] >= 0),
    constraint([x4] >= 0).

