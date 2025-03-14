%% Challenge: https://dmcommunity.org/challenge/challenge-feb-2025/
%% https://insideopt.com/blogs/news/puzzle-mr-bates-vs-the-post-office
									     
%% The Post Office in DS City has come up with a new measure to limit packages that can be sent under a new flat rate, regardless of weight or volume. The "strap measure" of a box is the length of the longest side plus two times the sum of the two shorter sides. For the new flat rate for sending a packet, the strap measure may not exceed 100 inches.

%% Your e-commerce client Mr. Bates sells large comforters of 9,000 cubic inches in volume and wants to make use of this new flat rate if possible. What should the measurements of the packaging box be to maximize the volume of the package? Can you design a box that will be large enough to hold these comforters and that can be sent at the flat rate price?

%% Run with

%% swipl dm-commumity-2025-02.pl
%% ?- findall([X,Y,Z], sol(X,Y,Z), Sol).
%% Sol = [[30, 20, 15], [40, 15, 15]].

:-use_module(library(clpfd)).

sol(X,Y,Z):-
    X #>= 1,
    Y #>= 1,
    Z #>= 1,
    9000 #= X * Y * Z,
    X #>= Y,
    Y #>= Z,
    100 #>= X + 2 * (Y + Z),
    label([X,Y,Z]).
    



