:-use_module(library(clpz)).

/*
Challange Dec 2020 from
  https://dmcommunity.org/challenge/challenge-dec-2020/

Three world champions Fischer, Kasparov, and Karpov played in a virtual chess tournament. Each player played 7 games against two other opponents. Each player received 2 points for a victory, 1 for a draw, and 0 for a loss. We know that Kasparov, known as the most aggressive player, won the most games. Karpov, known as the best defensive player, lost the least games. And Fischer, of course, won the tournament.
*/

player(fisher, 1).
player(kasparov, 2).
player(karpov, 3).

tot_games(14).
tot_games_two_players(7).

match_two_players(Wins1, Draws, Wins2):-
	%% constraint: 7 games agains each player
	tot_games_two_players(TotGames),
	Wins1 in 0..TotGames,
	Draws in 0..TotGames,
	Wins2 in 0..TotGames,
	Wins1 + Draws + Wins2 #= TotGames.

tournment([[Score1, Wins1, Draws1, Loses1],
	   [Score2, Wins2, Draws2, Loses2],
	   [Score3, Wins3, Draws3, Loses3]
	  ]):-
	tot_games(TotGames),
	match_two_players(Wins12, Draws12, Wins21),
	match_two_players(Wins13, Draws13, Wins31),
	match_two_players(Wins23, Draws23, Wins32),
	Wins1 #= Wins12 + Wins13,
	Wins2 #= Wins21 + Wins23,
	Wins3 #= Wins31 + Wins32,
	Loses1 #= Wins21 + Wins31,
	Loses2 #= Wins12 + Wins32,
	Loses3 #= Wins13 + Wins23,
	Draws1 #= Draws12 + Draws13,
	Draws2 #= Draws12 + Draws23,
	Draws3 #= Draws13 + Draws23,
	Wins1 + Draws1 + Loses1 #= TotGames,
	Wins2 + Draws2 + Loses2 #= TotGames,
	Wins3 + Draws3 + Loses3 #= TotGames,
	Score1 #= Wins1 * 2 + Draws1,
	Score2 #= Wins2 * 2 + Draws2,
	Score3 #= Wins3 * 2 + Draws3,
	%% constraint: Fischer (1) is the winner
	Score1 #> Score2,
	Score1 #> Score3,
	%% constraint: Kasparov (2) is the most aggressive
	Wins2 #> Wins1,
	Wins2 #> Wins3,
	%% constraint: Karpov (3) is teh best defensive player
	Loses1 #> Loses3,
	Loses2 #> Loses3.

solution([[Score1,Wins1,Draws1,Loses1],
	  [Score2,Wins2,Draws2,Loses2],
	  [Score3,Wins3,Draws3,Loses3]]):-
	tournment([[Score1,Wins1,Draws1,Loses1],
	       [Score2,Wins2,Draws2,Loses2],
	       [Score3,Wins3,Draws3,Loses3]]),
	label([Score1, Score2, Score3,
	       Wins1,Wins2,Wins3,
	       Draws1,Draws2,Draws3,
	       Loses1,Loses2,Loses3]).
