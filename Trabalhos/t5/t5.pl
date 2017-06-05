/*
Alunos: João Becker e Marco Puton
Comando para começar a jogar: start.

Usando tabuleiro como uma lista de 9 posições representado por
(1) | (2) | (3)
(4) | (5) | (6)
(7) | (8) | (9)
*/

start:-%loadDB,
	printOptions,
	repeat,
		play(player,1,[v,v,v,v,v,v,v,v,v]),
		gameover,
	mWriteDB, !.




%loadDB Predicado que carrega a base de dados
loadDB:-open('animalBase.txt', read, S),repeat, mReadLine(S), close(S), !.%DEBUG:trocar nome do arquivo
mReadLine(S):-read(S, In),(In=end_of_file | assert(In), fail).

printOptions:-write('Bem vindo ao jogo da velha!\nPara selecionar uma célula de jogada, pressione o número da célula\n'),
	write('Tabuleiro neste formato:'),nl,
	write('(1) | (2) | (3)\n(4) | (5) | (6)\n(7) | (8) | (9)'),nl, nl.


gameover:-%DEBUG: aqui preciso salvar no banco de dados o resultado
	write('Deseja continuar jogando? Pressione \'s\' para sim, outra letra caso contrário: '), get_single_char(C), put(C), nl,
	char_code(D, C),
    ((D == 's') -> fail; true).

mWriteDB:-write('Escrevendo jogadas na base de dados'), nl.

play(J1, N, T) :-
	boardPrint(T),
	le_jog(N,J1,T,P1), executa(J1,P1,T,T1),
	(gameOverTest(N, J1, T1) | changeTurn(J1,J2), N1 is N + 1,
	 play(J2,N1,T1)), !.

le_jog(N, player, T, P):-
	repeat, mWriteList(['Jogada ', N, ' - vez do player: ']),
	mReadPosition(P), isFree(1,P,T,v), !.

le_jog(N, computer, T, P):-
	repeat, mWriteList(['Jogada ', N, ' - vez do computador: ']),
	nl, random(1, 10, P), isFree(1,P,T,v), fitnessList(T, L), write(L), nl, nl, !.
	%write(T), !.

fitnessList(T, L):-fitnessList(T, [], L).
fitnessList([], A, A).
fitnessList([v|R], A, L):- write('1 '), write(R), nl, write(A), nl, append(A, 1, A1), fitnessList(R, A1, L).
fitnessList([_|R], A, L):- write('2 '), write(R), nl, write(A), nl, append(A, -1, A1), fitnessList(R, A1, L).


isFree(N,N,[X|_],X) :- !.%verefica se na posição N do tabuleiro tem um 'v'
isFree(N,L,[_|R],X) :- N1 is N + 1, isFree(N1,L,R,X), !.

mReadPosition(P):-
	repeat, get_single_char(C), put(C), nl, number_codes(P,[C]),
	P >= 1, P =< 9, !.

mWriteList([]):-!.
mWriteList([X|R]):- write(X), mWriteList(R), !.

%Aqui vai a jogada do pc



executa(J,P,T1,T2):- substitui(1,P,J,T1,T2), !.

substitui(N,N,J,[_|R],[J|R]):- !.
substitui(N,L,J,[X|R],[X|R1]):- N1 is N + 1, substitui(N1,L,J,R,R1), !.


changeTurn(player, computer).
changeTurn(computer, player).


boardPrint([X,Y,Z]):- cellPrint(X), write(' | '),
	cellPrint(Y), write(' | '), cellPrint(Z), nl, nl,!.
boardPrint([X,Y,Z|R]):- cellPrint(X), write(' | '),
	cellPrint(Y), write(' | '), cellPrint(Z), nl, write('---------'), nl,
	boardPrint(R), !.

cellPrint(v):- write(' '), !.
cellPrint(player):- write('X'), !.
cellPrint(computer):- write('O'), !.

gameOverTest(_,J,T):- victoryTest(J,T), mWriteList(['Vitória do ', J, '!']), nl,
	boardPrint(T), !.
gameOverTest(9,_,_):- victoryTest(J,T), write('Empate !'), nl, !.


%victoryTest 
victoryTest(J,[J,J,J,_,_,_,_,_,_]).
victoryTest(J,[_,_,_,J,J,J,_,_,_]).
victoryTest(J,[_,_,_,_,_,_,J,J,J]).
victoryTest(J,[J,_,_,J,_,_,J,_,_]).
victoryTest(J,[_,J,_,_,J,_,_,J,_]).
victoryTest(J,[_,_,J,_,_,J,_,_,J]).
victoryTest(J,[J,_,_,_,J,_,_,_,J]).
victoryTest(J,[_,_,J,_,J,_,J,_,_]).

