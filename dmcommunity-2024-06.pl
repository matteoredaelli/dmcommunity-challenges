%% https://dmcommunity.org/challenge/challenge-june-2024/

:-use_module(library(clpfd)).

dim(5).

husbands_ranks([
		  [5,1,2,4,3],
		  [4,1,3,2,5],
		  [5,3,2,4,1],
		  [1,5,4,3,2],
		  [4,3,2,1,5]
	      ]).

wifes_ranks([
		    [5,1,2,4,3],
		    [4,1,3,2,5],
		    [5,3,2,4,1],
		    [1,5,4,3,2],
		    [4,3,2,1,5]
		]).

rank(Person1, Person2, Ranks, Rank):-
    nth1(Person1, Ranks, PersonRanks),
    nth1(Person2, PersonRanks, Rank).

/*

Wifes is a list of integer
First element is the wife of men 1
Second element is teh wife of men 2
...
*/
sol(Wifes):-
    dim(N),
    husbands_ranks(HusbandRanks),
    wifes_ranks(WifeRanks),
    %% Wifes is a list of N elements
    length(Wifes, N),
    %% Each element is a wige (1=Alice)
    Wifes ins 1..N,
    all_distinct(Wifes),
    label(Wifes),
    stable_marriages(Wifes, HusbandRanks, WifeRanks).

instable_marriages(Wifes, HusbandRanks, WifeRanks, [Husband1-Wife1, Husband2-Wife2]):-
    %% Husband1 is the index of an element of the list
    %% Wife1 is a element of teh list of 
    nth1(Husband1, Wifes, Wife1),
    rank(Husband1, Wife1, HusbandRanks, MRank11),
    nth1(Husband2, Wifes, Wife2),
    Husband1 #\= Husband2,
    Wife1 #\= Wife2,
    rank(Wife2, Husband2, WifeRanks, FRank22),
    rank(Husband1, Wife2, HusbandRanks, MRank12),   
    rank(Wife2, Husband1, WifeRanks, FRank21),
    MRank12 #> MRank11,
    FRank21 #> FRank22.


stable_marriages(Wifes, HusbandsRanks, WifesRanks):-
    instable_marriages(Wifes, HusbandsRanks, WifesRanks, _) -> false ; true.

husbands_names(['Adam','Bob','Charlie','Dave','Edgar']).
wifes_names(['Alice','Barbara','Claire','Doris','Elsie']).

wife_index_name(Index, Name):-
    wifes_names(WifesNames),
    nth1(Index, WifesNames, Name).

wifes_index_name([], []).
wifes_index_name([Index|Indexes], [Name|Names]):-
    wife_index_name(Index, Name),
    wifes_index_name(Indexes, Names).

marriages(Wifes, Marriagies):-
    husbands_names(HusbandsNames),
    wifes_index_name(Wifes, WifesNames),
    pairs_keys_values(Marriagies, HusbandsNames, WifesNames).
