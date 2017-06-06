/*
Alunos: João Becker e Marco Puton
Comando para começar a jogar: start.

Usando tabuleiro como uma lista de 9 posições representado por
(1) | (2) | (3)
(4) | (5) | (6)
(7) | (8) | (9)
*/
:- dynamic
      played/2,
	  start.


start:-
	loadDB,
	printOptions,
	repeat,
		play(player,1,[v,v,v,v,v,v,v,v,v], [player]),
		gameover,
	mWriteDB, !.




%loadDB Predicado que carrega a base de dados
loadDB:-open('playedDB.txt', read, S),repeat, mReadLine(S), close(S), !.
mReadLine(S):-read(S, In),(In=end_of_file | assert(In), fail).

printOptions:-write('Bem vindo ao jogo da velha!\nPara selecionar uma célula de jogada, pressione o número da célula\n'),
	write('Tabuleiro neste formato:'),nl,
	write('(1) | (2) | (3)\n(4) | (5) | (6)\n(7) | (8) | (9)'),nl, nl.


gameover:-
	write('Deseja continuar jogando? Pressione \'s\' para sim, outra letra caso contrário: '), get_single_char(C), put(C), nl,
	char_code(D, C),
    ((D == 's') -> fail; true).

mWriteDB:-write('Escrevendo jogadas na base de dados'), nl,
	open('playedDB.txt', write, S), forall(played(X, Y), (writeq(S,played(X, Y)), write(S, '.'), nl(S))), close(S).

%H: uma lista com o histórico das jogadas, na partida atual
play(J1, N, T, H) :-
	%boardPrint(T),%DEBUG: passa para o makeMove do player, OBS: feito
	makeMove(N,J1,T,P1, H),
	append(H, [P1], H1),
	executa(J1,P1,T,T1),
	(gameOverTest(N, J1, T1, H1) | changeTurn(J1,J2), N1 is N + 1,
	 play(J2,N1,T1, H1)), !.

makeMove(N, player, T, P, _):-
	boardPrint(T),
	repeat, mWriteList(['Jogada ', N, ' - vez do player: ']),
	mReadPosition(P), isFree(1,P,T,v), !.

makeMove(N, computer, T, P, Ahist):-
	repeat, mWriteList(['Jogada ', N, ' - vez do computador: ']),
	fitnessList(T, L, Ahist),
	length(L, U),
	random(0, U, Rnd),
	nth0(Rnd,L,[F, P]),
	write(P), nl,
	isFree(1,P,T,v), 
	!.
	%write(T), !.

%Ahist: histórico de jogadas na partida atual
fitnessList(T, L, Ahist):-fitnessList(T, [], 1, L, Ahist).
fitnessList([], A, _, P, _):- mCutList(A, P) %descomentar a linha de baixo caso queira ver a lista de fitness
	%, nl, write('Sem Corte: '), write(A), nl, write('Com corte: '), write(P), nl
	.
fitnessList([v|R], A, N, L, Ahist):-
	append(Ahist, [N], AhistN),
	fitnessCalc(AhistN, Fit),
	append(A, [[Fit, N]], A1),
	N1 is N+1,
	fitnessList(R, A1, N1, L, Ahist).
fitnessList([_|R], A, N, L, Ahist):-
	append(A, [[-1, N]], A1),
	N1 is N+1,
	fitnessList(R, A1, N1, L, Ahist).


fitnessCalc(L, Fit):-
	%write('Calculando Fit, Hist: '), write(L),nl,
	findall(Y , (played(X, Y), prefix(L, X)), OutList),
	%write('Prefixos: '), write(OutList),
	length(OutList, N), %write(' De comprimento N: '), write(N),
	((N == 0) -> Fit is 0.5; fitness2Calc(OutList, N, Fit)).
	
fitness2Calc(OutList, N, Fit):- mNumCalc(OutList, 0, Num), Fit is Num/N.

mNumCalc([], Na, Na).
mNumCalc([player|R], Na, Num):- mNumCalc(R, Na, Num).%soma 0
mNumCalc([computer|R], Na, Num):- Na1 is Na+2,  mNumCalc(R, Na1, Num).%soma 2
mNumCalc([tie|R], Na, Num):- Na1 is Na+1, mNumCalc(R, Na1, Num).%soma 1

mCutList(L, P):-mMaxList(L, M),
	%mWriteList(['Na lista ', L, ' A maior fitness é: ', M]),
	doCut(L, M, P).


mMaxList(L, N):- mMaxList(L,-5, N).%Predicado que procura a maior fitness na lista de [Fitness, Posição]
mMaxList([], A, A).
mMaxList([[F, _]|R], A, N):- ((F > A) -> mMaxList(R, F, N); mMaxList(R, A, N)).

doCut(L, M, Cuted):- doCut(L, M, Cuted, []).%faz o corte na lista, removendo posições com fitness baixas
doCut([], M, A, A).
doCut([[F, P]|R], M, Cuted, A):- ((F < M) -> append(A, [], A1); append(A, [[F, P]], A1)), doCut(R, M, Cuted, A1).

isFree(N,N,[X|_],X) :- !.%verefica se na posição N do tabuleiro tem X
isFree(N,L,[_|R],X) :- N1 is N + 1, isFree(N1,L,R,X), !.

mReadPosition(P):-
	repeat, get_single_char(C), put(C), nl, number_codes(P,[C]),
	P >= 1, P =< 9, !.

mWriteList([]):-!.
mWriteList([X|R]):- write(X), mWriteList(R), !.

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

gameOverTest(_, J, T, H):- victoryTest(J,T), mWriteList(['Vitória do ', J, '!']), nl,
	boardPrint(T),
	assert(played(H, J)), !.
gameOverTest(9,_,_, H):- victoryTest(J,T), write('Empate !'), nl,
	assert(played(H, tie)),
	!.%DEBUG: isso não faz muito sentido


%victoryTest 
victoryTest(J,[J,J,J,_,_,_,_,_,_]).
victoryTest(J,[_,_,_,J,J,J,_,_,_]).
victoryTest(J,[_,_,_,_,_,_,J,J,J]).
victoryTest(J,[J,_,_,J,_,_,J,_,_]).
victoryTest(J,[_,J,_,_,J,_,_,J,_]).
victoryTest(J,[_,_,J,_,_,J,_,_,J]).
victoryTest(J,[J,_,_,_,J,_,_,_,J]).
victoryTest(J,[_,_,J,_,J,_,J,_,_]).