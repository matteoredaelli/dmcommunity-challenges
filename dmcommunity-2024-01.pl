:-use_module(library(clpfd)).

%% https://dmcommunity.org/challenge/challenge-january-2024/

%% Let’s assume that Rene and Leo are both heads of household, and, what a coincidence, both families include three girls and three boys.
%% The youngest child in Leo’s family is a girl, and in Rene’s family, a little girl has just arrived.
%% In other words, there is a girl in Rene’s family whose age is less than one year.
%% Neither family includes any twins, nor any children closer in  age than a year.
%% All the children are under age ten. In each family, the sum of the ages of the girls is equal to the sum of the ages of the boys;
%% in fact, the sum of the squares of the ages of the girls is equal to the sum of the squares of the ages of the boys.
%% The sum of the ages of all these children is 60.

%% SOLUTION (without permutations

%%%   ?- findall([LeoBoys,LeoGirls,ReneBoys,ReneGirls], sol([LeoBoys,LeoGirls,ReneBoys,ReneGirls]), Solutions), length(Solutions, Tot).
%%%   Solutions = [[[4, 5, 9], [3, 7, 8], [1, 3, 8], [0, 5, 7]]],
%%%   Tot = 1.

max_age(9).
sum_age(60).
count_same_sex(3).

constraints_family_same_sex(L):-
    max_age(MaxAge),
    count_same_sex(N),
    %% both families include three girls and three boys.
    length(L, N),
    %% All the children are under age ten
    L ins 0..MaxAge,
    %% ages in sorted order 
    ordered_list(L).

constraints_family(Boys, Girls):-
    sum_list(Boys, Sum),
    sum_list(Girls, Sum),
    sum_square_list(Boys, SumS),
    sum_square_list(Girls, SumS).

sum_list([E|L], Sum):-
    sum_list(L, SumL),
    Sum #= E + SumL.
sum_list([], 0).

sum_square_list([E|L], Sum):-
    sum_square_list(L, SumL),
    Sum #= E ^ 2 + SumL.
sum_square_list([], 0).

ordered_list([E1,E2|L]):-
    E1 #=< E2,
    ordered_list([E2|L]).
ordered_list([_E]).
ordered_list([]).

sol([LeoBoys, LeoGirls, ReneBoys, ReneGirls]):-    
    %% All the children are under age ten
    %% both families include three girls and three boys.
    constraints_family_same_sex(LeoBoys),
    constraints_family_same_sex(LeoGirls),
    constraints_family_same_sex(ReneBoys),
    constraints_family_same_sex(ReneGirls),

    %% in Rene’s family, a little girl has just arrived
    ReneGirls = [0|_],

    %% The youngest child in Leo’s family is a girl
    LeoBoys = [LB1|_RestLeoBoys],
    LeoGirls = [LG1|_RestLeoGirls],
    LG1 #< LB1,

    append(LeoBoys, LeoGirls, LeoList),
    append(ReneBoys, ReneGirls, ReneList),
    append(LeoList, ReneList, AllChildren),
    
    %% Neither family includes any twins, nor any children closer in age than a year
    all_distinct(LeoList),
    all_distinct(ReneList),
    
    %% The sum of the ages of all these children is 60.
    sum_age(SumAge),
    sum_list(AllChildren, SumAge),


    %% In each family, the sum of the ages of the girls is equal to the sum of the ages of the boys
    constraints_family(LeoBoys, LeoGirls),
    constraints_family(ReneBoys, ReneGirls),
    
    label(AllChildren).
