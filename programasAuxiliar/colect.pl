
expressoes([4 = 1 + 1, 4 = 2 * 2, 2 = 3 - 1, 8 = 2 * 2 * 2]).
expressoesok([4 = 3 + 1, 4 = 2 * 2, 2 = 3 - 1, 8 = 2 * 2 * 2]).

pai(joao,paulo).
pai(paulo, carlos).
pai(paulo,maria).
pai(carlos, janice).

imprime_filho(X):- write(X), write(':'), fail.
imprime_filho(X):- pai(X,Y), write(Y), write(' '), fail.
imprime_filho(_):- nl.


testes :- teste1,
	  teste2,
	  teste3,
	  teste4,
	  teste5,
	  teste6,
	  teste7, 
       teste8.

%  forall

teste1 :- expressoes(L), 
          write('Testando forall para: forall(member(R = E, '), write(L), 
          write('), R =:= E)'), nl, write('Resultado : '),
	  forall(member(R = E, L), R =:= E),
	  write('Todas as operações estão corretas'), nl, nl, !.
teste1 :- write('Pelo menos uma operação incorreta'), nl, nl, !.

teste2 :- expressoesok(L), 
          write('Testando forall para: forall(member(R = E, '), write(L), 
          write('), R =:= E)'), nl, write('Resultado : '),
 	  forall(member(R = E, L), R =:= E),
	  write('Todas as operações estão corretas'), nl, nl, !.
teste2 :- write('Pelo menos uma operação incorreta'), nl, nl, !.

teste3 :- write('Testando forall para: forall(pai(A,B), imprime_filho(A))'), nl, write('Resultado : '), nl,
 	  forall(pai(A,B), imprime_filho(A)), nl, nl, !.
teste3 :- write('Falhatestes.'), nl, nl, !.


%  findall

membro_ok(R, E, L) :- member(R = E, L), R =:= E.

teste4 :- write('Testando findall para: findall(X, pai(X,Y),Lok)'), nl, write('Lok : '),
 	  findall(X, pai(X,Y),Lok), write(Lok), nl, nl, !.

%  bagof

teste5 :- write('Testando bagof para: bagof(Y, pai(X,Y),Lok)'), nl, write('Lok : '),
 	  bagof(Y, pai(X,Y),Lok), write(Lok),  fail.
teste5:- nl, nl, !.

teste6 :- write('Testando bagof para: bagof(Y, X^pai(X,Y),Lok)'), nl, write('Lok : '),
 	  bagof(Y, X^pai(X,Y),Lok), write(Lok), fail.
teste6 :-  nl, nl, !.


%  setof

teste7 :- write('Testando setof para: setof(Y, pai(X,Y),Lok)'), nl, write('Lok : '),
 	  setof(Y, pai(X,Y),Lok), write(Lok), fail.
teste7:-  nl, nl, !.

teste8 :- write('Testando setof para: setof(X, X^pai(X,Y),Lok)'), nl, write('Lok : '),
 	  setof(Y, X^pai(X,Y),Lok), write(Lok), fail.
teste8 :- nl, nl, !.
