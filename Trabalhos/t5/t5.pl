/*
Alunos: João Becker e Marco Puton
Comando para começar a jogar: start.


*/

start:- joga(1,1,[v,v,v,v,v,v,v,v,v]), !.





loadDB:-.%Função que carrega a base de dados

joga(J1, N, T) :-
	imprime_tabuleiro(T),
	le_jog(N,J1,T,P1), executa(J1,P1,T,T1),
	(fim(N, J1, T1) | proximo(J1,J2), N1 is N + 1,
	 joga(J2,N1,T1)), !.

le_jog(N, J, T, P):-
	repeat, write_lista(['Jogada ', N, ' - Jogador ', J,	': ']),
	le_pos(P), membro_nro(1,P,T,v), !.

membro_nro(N,N,[X|R],X) :- !.
membro_nro(N,L,[Y|R],X) :- N1 is N + 1, membro_nro(N1,L,R,X), !.

le_pos(P):-
	repeat, get_single_char(C), put(C), nl, number_codes(P,[C]),
	P >= 1, P =< 9, !.

write_lista([]):-!.
write_lista([X|R]):- write(X), write_lista(R), !.

executa(J,P,T1,T2):- substitui(1,P,J,T1,T2), !.

substitui(N,N,J,[_|R],[J|R]):- !.
substitui(N,L,J,[X|R],[X|R1]):- N1 is N + 1, substitui(N1,L,J,R,R1), !.


proximo(1,2).
proximo(2,1).


imprime_tabuleiro([X,Y,Z]):- imp(X), imp(s),
	imp(Y), imp(s), imp(Z), nl, nl,!.
imprime_tabuleiro([X,Y,Z|R]):- imp(X), imp(s),
	imp(Y), imp(s), imp(Z), nl, imp(l),
	imprime_tabuleiro(R), !.

imp(v):- write(' '), !.
imp(1):- write('X'), !.
imp(2):- write('O'), !.
imp(s):- write(' | '), !.
imp(l):- write('---------'),nl, !.

fim(N,J,T):- victoryTest(J,T), write_lista(['Vitória do Jogador', J, '!']), nl,
	imprime_tabuleiro(T), !.
fim(9,_,_):- victoryTest(J,T), write('Empate !'), !.


%victoryTest 
victoryTest(J,[J,J,J,_,_,_,_,_,_]).
victoryTest(J,[_,_,_,J,J,J,_,_,_]).
victoryTest(J,[_,_,_,_,_,_,J,J,J]).
victoryTest(J,[J,_,_,J,_,_,J,_,_]).
victoryTest(J,[_,J,_,_,J,_,_,J,_]).
victoryTest(J,[_,_,J,_,_,J,_,_,J]).
victoryTest(J,[J,_,_,_,J,_,_,_,J]).
victoryTest(J,[_,_,J,_,J,_,J,_,_]).

