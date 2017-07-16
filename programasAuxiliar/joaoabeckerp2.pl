%Nome: João Carlos Becker
%Matrícula: 1411100040


%Questão 1)a) charmar somaMatriz(M, X). M= matriz, X=variavel livre para por a soma
somaMatriz(M, X):- somaMatriz(M, [], X).
somaMatriz([], Ls, X):- somaLista(Ls, X).
somaMatriz([Mi|R], Ls, X):- somaLista(Mi, Soma), myAppend(Soma, Ls, Ls1), somaMatriz(R, Ls1, X).


somaLista(L, X):- somaLista(L, 0, X).
somaLista([], S, S).
somaLista([L|R], S, X):-S1 is S+L, somaLista(R, S1, X).

myAppend(X, [H|T], [H|R]):- myAppend(X, T, R), !.
myAppend(X, [], [X]).

%Questão 1)b)chamar ehQuadrada(M) para a matriz M
ehQuadrada(M):- conta(I, M), ehQuadrada(I, M).
ehQuadrada(I, [M|R]):- conta(J, M), ehQuadrada(I, J, [M|R]).
ehQuadrada(I, I, _).

conta(X, L):- conta(X, L, 0).
conta(X, [], X).
conta(X, [_|R], S):- S1 is S+1, conta(X, R, S1).

%Questão 2)b) chamar listaFolhas(L), L vai ser a lista de folhas
raiz(a).
nodo(a, b, c).
nodo(b, d, nil).
nodo(d, nil, nil).
nodo(c, e, f).
nodo(e, g, h).
nodo(f, nil, nil).
nodo(g, nil, nil).
nodo(h, nil, nil).
nodo(i, j, nil).
nodo(j, nil, nil).

listaFolhas(L):- raiz(X),  listaFolhas(X, [], L), !.
listaFolhas(X, L, L1):-nodo(X, nil, nil), myAppend(X, L, L1).
listaFolhas(X, L, L1):- nodo(X, A, B), listaFolhas(A, L, Lx), listaFolhas(B, L, Ly), append(Lx, Ly, L1).
listaFolhas(nil, L, L).

%Questão 2)a)Não fiz ainda

aresta(a, b).
aresta(a, d).
aresta(b, c).
aresta(b, f).
aresta(d, e).
aresta(e, a).
aresta(f, g).
aresta(g, d).

%cicloSaida(X):- findall()

%Questão 3)a) chamar criaBC para abrir um banco de dados chamado joaobeckerbd.txt
%e adicionar todas as clausulas do arquivo
:- dynamic
      professor/2,
      aluno/2.

criaBC:-carregar.
carregar:-open('joaobeckerbd.txt', read, S),repeat, leituraLinha(S), close(S), !.
leituraLinha(S):-read(S, In),(In=end_of_file | assert(In), fail).

testaBC:-forall(professor(N, L), (write('Nome: '),write(N), write('  :   '), write(L)                        )),
    forall(aluno(N, L), (write('Nome: '),write(N), write('  :   '), write(L)                        )).


%Questão 3)b) chamar escreverBase para escrever no arquivo 'joaobeckerbd.txt'
%as clausulas professor e aluno 
escreverBase:-open('joaobeckerbd.txt', write, S), forall(aluno(N, L), (writeq(S,aluno(N, L)), write(S, '.'), nl(S))),
    forall(professor(N, L), (writeq(S,professor(N, L)), write(S, '.'), nl(S))),
    close(S).

%Questão 3)c)Não terminei
comunAP(A, P):- aluno(A, Da), professor(P, Dp), intersection([Da], [Dp], X), write('As disciplinas em comun entre '), write(A), write(' e '), write(P), write(':  '), write(X). 