% Busca em àrvores

% definição da àrvore usando os nodos

nodo(a,b,c).
nodo(b,d,e).
nodo(c,f,g).
nodo(d,h,i).
nodo(e,nil,nil).
nodo(f,nil,nil).
nodo(g,nil,nil).
nodo(h,nil,nil).
nodo(i,nil,nil).

% definição da àrvore usando as arestas

aresta(a,b).
aresta(a,c).
aresta(b,d).
aresta(b,e).
aresta(c,f).
aresta(c,g).


% Busca em profundidade usando nodos
% Parametros : Nó procurado
%              Nó inicial
%              Solução

buscaprof(X,Y,L) :- buscaprofundidade(X,Y,L), !.
buscaprof(X, _, _):- write('Nodo '), write(X),
	write(' não encontrado.'), nl, !.

buscaprofundidade(X, X, [X]):- 
	nodo(X,_,_), 
	write('Nodo '), write(X), write(' encontrado.'), nl, !.
buscaprofundidade(X, N, [N|R]) :- 
	nodo(N,Y,Z), 
	write('Visitou nodo: '), write(N), write('.'), nl, 
	buscaprofundidade(X,Y,R), !.
buscaprofundidade(X, N, [N|R]) :- 
	nodo(N,Y,Z), 
	buscaprofundidade(X,Z,R), !.

% Busca em profundidade usando arestas
% Parametros : Nó procurado
%              Nó inicial
%              Solução

buscaprofa(X,Y,L) :- buscaprofundidadea(X,Y,L), !.
buscaprofa(X, _, _):- write('Nodo '), write(X),
	write(' não encontrado.'), nl, !.

buscaprofundidadea(X, X, [X]):- 
	write('Nodo '), write(X), write(' encontrado.'), nl, !.
buscaprofundidadea(X, N, [N|R]) :- 
	write('Visitou nodo: '), write(N), write('.'), nl, 
	aresta(N,Y), 
	buscaprofundidadea(X,Y,R), !.


% Busca em largura usando nodos
% Parametros : Nó procurado
%              Nó inicial
%              Solução

buscalarg(X,Y,L) :- buscalargura(X,[[Y]], L), !.

buscalargura(X,[],[]) :- 
	write('Nodo '), write(X), write(' não encontrado.'), !.
buscalargura(X, [[X|R]|R1], L) :- 
	nodo(X,_,_), 
	write('Nodo '), write(X), write(' encontrado.'), nl, 
	reverse([X|R],L), !.
buscalargura(X, [[Y|R]|R1], L) :- 
	nodo(Y,F1,F2), 
    write('Visitou nodo: '), write(Y), write('.'), nl,
	caminhos([F1,F2],[Y|R],R2),
    append(R1,R2,R3), 
	buscalargura(X,R3,L), !.
buscalargura(X, [Y|R], L) :- 
	buscalargura(X,R,L), !.

caminhos([],_,[]).
caminhos([X|R], L, [[X|L]|R1]) :- caminhos(R,L,R1), !.

% Busca em largura usando arestas
% Parametros : Nó procurado
%              Nó inicial
%              Solução

buscalarga(X,Y,L) :- buscalarguraa(X,[[Y]], L), !.

buscalarguraa(X,[],[]) :- 
	write('Nodo '), write(X), write(' não encontrado.'), !.
buscalarguraa(X, [[X|R]|R1], L) :- 
	write('Nodo '), write(X), write(' encontrado.'), nl, 
	reverse([X|R],L), !.
buscalarguraa(X, [[Y|R]|R1], L) :- 
    write('Visitou nodo: '), write(Y), write('.'), nl,
	findall(Z, aresta(Y,Z), L1),  
	caminhos(L1,[Y|R],R2),
    append(R1,R2,R3), 
	buscalarguraa(X,R3,L), !.

