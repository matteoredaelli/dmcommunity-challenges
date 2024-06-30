%% https://dmcommunity.org/challenge/challenge-june-2024/

%% This file is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
%%
%% This file is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License along with Foobar. If not, see <https://www.gnu.org/licenses/>. 

%% Author matteo.redaelli@gmail.com

%% solution
%% findall(M, (sol(S), marriages(S, M)), L), maplist(writeln, L).

:-use_module(library(clpfd)).

dim(6).

husbands_ranks([[1,2,4,5,6,3],
		[4,2,5,3,1,6],
		[2,5,4,6,3,1],
		[3,4,2,6,5,1],
		[6,3,2,1,5,4],
		[4,6,3,2,1,5]
	       ]).

wifes_ranks([[5,2,6,3,1,4],
	     [6,5,1,2,4,3],
	     [3,2,1,4,5,6],
	     [2,4,1,3,5,6],
	     [3,5,4,2,1,6],
	     [5,1,6,4,2,3]
	    ]).

rank(Person1, Person2, Ranks, Rank):-
    nth1(Person1, Ranks, PersonRanks),
    nth1(Person2, PersonRanks, Rank).

/*
Wifes is a list of integer
First element is the wife of men 1
Second element is the wife of men 2
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

%% needed to convert numbers to first names

husbands_names(['Adam','Bob','Charlie','Dave','Edgar', 'Fred']).
wifes_names(['Alice','Barbara','Claire','Doris','Elsie', 'Fiona']).

wife_index_name(Index, Name):-
    wifes_names(WifesNames),
    nth1(Index, WifesNames, Name).

wifes_index_name([], []).
wifes_index_name([Index|Indexes], [Name|Names]):-
    wife_index_name(Index, Name),
    wifes_index_name(Indexes, Names).
    
marriages(Wifes, Marriages):-
    husbands_names(HusbandsNames), 
    wifes_index_name(Wifes, WifesNames),
    pairs_keys_values(Marriages, HusbandsNames, WifesNames).

marriages(Wifes, Marriages, SumRanks):-
    marriages(Wifes, Marriages),
    marriages_stats(Wifes, SumRanks).

marriage_stats(Husband, Wife, HusbandRanks, WifeRanks, SumRanks):-
    rank(Husband, Wife, HusbandRanks, MRank),
    rank(Wife, Husband, WifeRanks, FRank),
    SumRanks #= MRank + FRank.

marriages_stats(_, [], _HusbandRanks, _WifeRank, 0).
marriages_stats(H, [W|Wifes], HusbandRanks, WifeRanks, SumRanks):-
    marriage_stats(H, W, HusbandRanks, WifeRanks, SumRanks1),
    NextHusband #= H + 1,
    marriages_stats(NextHusband, Wifes, HusbandRanks, WifeRanks, OtherSumRanks),
    SumRanks #= SumRanks1 + OtherSumRanks.

marriages_stats(Wifes, SumRanks):-
    husbands_ranks(HusbandRanks),
    wifes_ranks(WifeRanks),
    marriages_stats(1, Wifes, HusbandRanks, WifeRanks, SumRanks).
