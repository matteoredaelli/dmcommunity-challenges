:-use_module(library(clpfd)).

/* https://dmcommunity.org/challenge/challenge-june-2021/ */

/*
  sentenceX(Box1,_Box2, Box3)
  values: 0 means empty,
	  1 means gold
*/

sentence1(1,_Box2,_Box3).
not_sentence1(0,_Box2,_Box3).

sentence2(_Box1,0,_Box3).
not_sentence2(_Box1,1,_Box3).

sentence3(0,_Box2,_Box3).
not_sentence3(1,_Box2,_Box3).

true_only_one_sentence(Box1, Box2, Box3):-
	(       sentence1(Box1,Box2,Box3), not_sentence2(Box1,Box2,Box3), not_sentence3(Box1,Box2,Box3) ) ;
	(   not_sentence1(Box1,Box2,Box3),     sentence2(Box1,Box2,Box3), not_sentence3(Box1,Box2,Box3) ) ;
	(   not_sentence1(Box1,Box2,Box3), not_sentence2(Box1,Box2,Box3),     sentence3(Box1,Box2,Box3) ).

solution(Box1, Box2, Box3):-
	Box1 in 0..1, /* 0 empty, 1 gold */
	Box2 in 0..1, /* 0 empty, 1 gold */
	Box3 in 0..1, /* 0 empty, 1 gold */
	Box1 + Box2 + Box3 #= 1, /* only one box contains gold */
	true_only_one_sentence(Box1, Box2, Box3).
