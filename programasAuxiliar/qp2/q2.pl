%imprime por ordem decrescente de idade, mas está fazendo o oposto, só mudar o sinal na linha 11
imp_por_idade(L):- arruma_lista(L,L1), ordena(L1,[],L2), imp_nome(L2), !.

arruma_lista([],[]).
arruma_lista([(N,D/M/A)|R1],[(A/M/D,N)|R2]):- arruma_lista(R1,R2), !.

ordena([], L, L).
ordena([X|R], L, L1):- insere(X,L,L2), ordena(R,L2,L1), !.

insere(X,[],[X]).
insere(X, [Y|R], [Y|R1]):- X@< Y, insere(X, R,R1).
insere(X, [Y|R], [X,Y|R]).

imp_nome([]).
imp_nome([(_,N)|R]):- write(N), nl, imp_nome(R).