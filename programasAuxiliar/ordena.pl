% Ordenação de listas

bubblesort(L,S) :- troca(L,L1), !, bubblesort(L1,S).
bubblesort(S,S).

troca([X,Y|R], [Y,X|R]) :- X > Y, !.
troca([X|R], [X|R1]) :- troca(R,R1).




insertsort1([], L, L).
insertsort1([X|R], L, L1):- insere(X,L,L2), insertsort1(R,L2,L1), !.

insere(X,[],[X]).
insere(X, [Y|R], [Y|R1]):- X > Y, insere(X, R,R1).
insere(X, [Y|R], [X,Y|R]).


insertsort([],[]).
insertsort([X|R], S) :- insertsort(R,S1), insere(X,S1,S), !.



quicksort([],[]).
quicksort([X|R], S) :- divide(X,R,Me,Ma), quicksort(Me,S1),
 	quicksort(Ma,S2), concatena(S1,X,S2,S), !.

divide(X,[], [], []).
divide(X,[Y|R], [Y|R1], Ma) :- Y < X, divide(X, R, R1, Ma), !.
divide(X,[Y|R], Me, [Y|R1]) :- divide(X, R, Me,R1), !.

concatena([],Y,L,[Y|L]).
concatena([X|R], Y, L, [X|R2]) :- concatena(R,Y,L,R2), !.


ordenada(_,[]).
ordenada(_,[_]).
ordenada(a,[X,Y|R]):- X =< Y, ordenada(a,[Y|R]).
ordenada(d,[X,Y|R]):- X >= Y, ordenada(d,[Y|R]).

