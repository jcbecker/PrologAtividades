/*
	Alunos: Joao Carlos Bercker,
			Marco Aurelio Alves Puton

	Para rodar o programa, chame buscalargura(Inicio, L).
	Inicio e o ponto de inicio da busca. Ex.: 'A'
	L e o retorno da chamada, contendo a resposta no formato: (Caminho, Custo)
	No termino da execucao, antes de exibir a solucao, e mostrado como ficou a
	arvore de solucao antes de selecionar a resposta com menor custo.
*/


% BD
distancia('POA', 'FLO', 457).
distancia('POA', 'Ctba', 741).
distancia('POA', 'SP', 1143).
distancia('POA', 'RJ', 1568).
distancia('POA', 'BH', 1721).
distancia('POA', 'Bra', 2166).
distancia('POA', 'Ass', 1106).
distancia('POA', 'Cha', 452).
distancia('FLO', 'Ctba', 301).
distancia('FLO', 'SP', 704).
distancia('FLO', 'RJ', 1129).
distancia('FLO', 'BH', 1277).
distancia('FLO', 'Bra', 1676).
distancia('FLO', 'Ass', 1264).
distancia('FLO', 'Cha', 552).
distancia('Ctba', 'SP', 416).
distancia('Ctba', 'RJ', 842).
distancia('Ctba', 'BH', 990).
distancia('Ctba', 'Bra', 964).
distancia('Ctba', 'Ass', 1264).
distancia('Ctba', 'Cha', 480).
distancia('SP', 'RJ', 434).
distancia('SP', 'BH', 584).
distancia('SP', 'Bra', 1008).
distancia('SP', 'Ass', 1348).
distancia('SP', 'Cha', 885).
distancia('RJ', 'BH', 439).
distancia('RJ', 'Bra', 1167).
distancia('RJ', 'Ass', 1773).
distancia('RJ', 'Cha', 1319).
distancia('BH', 'Bra', 737).
distancia('BH', 'Ass', 1763).
distancia('BH', 'Cha', 1470).
distancia('Bra', 'Ass', 1825).
distancia('Bra', 'Cha', 1755).
distancia('Ass', 'Cha', 771).

%	BD de teste
distancia('A', 'B', 1).
distancia('A', 'C', 2).
distancia('A', 'D', 3).
distancia('A', 'E', 4).
distancia('B', 'C', 5).
distancia('B', 'D', 6).
distancia('B', 'E', 7).
distancia('C', 'D', 8).
distancia('C', 'E', 9).
distancia('D', 'E', 10).

%	Função para imprimir todos os indices de uma lista
write_list([]) :- !.
write_list([H|T]) :- write(H), write_list(T), !.

%	Recebe:	 [1, 2, 3],  [a, b]
%	Retorna: [[1, a, b], [2, a, b], [3, a, b]]
caminhos([],_,[]).
caminhos([X|R], L, [[X|L]|R1]) :- caminhos(R, L, R1), !.


%	Funcao para saber se dois caminhos são equivalentes (anagrama)
equal((X, _), (Y, _)):- isSubset(X, Y),
						isSubset(Y, X), !.

isSubset([], _) :- !.
isSubset([H|T], Y) :- 		member(H, Y),
							select(H, Y, Z),
							isSubset(T,Z), !.

equal2((X, _), (Y, _)) :- equivale(X, Y), !.

equivale([], []) :- !.
equivale([H|T], Y) :- member(H, Y), subtract(Y, [H], Y2), equivale(T, Y2), !.


%	Funcao de poda.
%	Percorre a lista de caminhos, e vai adicionando em uma nova lista
%	os caminhos que não se repetem. Testa se o inicio e o fim são iguais e
%	depois testa se sao anagramas. Quando dois caminhos são equivalentes,
%	deixa na lista o com menor custo.
poda(X, R) :- poda(X, [], R), !.

poda([], L, L) :- !.
poda([H|T], L, R) :- not(inList(H, L, _)), append(L, [H], L1), poda(T, L1, R), !.
poda([H|T], L, R) :- inList(H, L, M), maior(H, M, Maior), substitui(H, M, Maior, L, NL), poda(T, NL, R), !.

%	Substitui o caminho da lista quando equivalentes.
%	Se o da nova lista tiver custo maior (1), troca pelo novo
substitui(H, M, 1, L, NL) :- subtract(L, [M], L2), append(L2, [H], NL), !.
%	Se o caminho da lista e o menor (2), deixa como esta.
substitui(_, _, 2, L, L) :- !.

%	Retorna 1 quando o caminho da lista maior que o caminho novo, e 2 caso contrario
maior((_, C1), (_, C2), 1) :- C1 < C2, !.
maior((_, _), (_, _), 2) :- !.

%	Testa se o caminho ja esta na lista (Caminho equivalente). Testa para todos
%	os indices da lista nova.
inList(([Head|Tail], _), [([Head2|Tail2], W)|_], ([Head2|Tail2], W)) :- Head = Head2,
																		last(Tail, Last1),
																		last(Tail2, Last2),
																		Last1 = Last2,
																		equal(([Head|Tail], _), ([Head2|Tail2], W)), !.
inList(I, [_|T], M) :- inList(I, T, M), !.




%   Retorna uma lista com as cidades com aresta com I
todas_cidades(I,L) :-   findall(X, distancia(I, X, _), L1),
                        findall(X, distancia(X, I, _), L2),
                        append(L1, L2, L), !.


%					retorna a distancia entre duas cidades
acha_dist(A, B, C) :- distancia(A, B, C), !.
acha_dist(A, B, C) :- distancia(B, A, C), !.


%	Retorna a expansão de um nodo. Retorna uma lista com todos os filhos do nodo.
expande([], _, []).
expande([H|T], L2, L) :- expande([H|T], L2, L, []).

%	Como vai para diferentes nodos, precisa calcular os novos custos aqui.
expande([], _, In, In) :- !.
expande([H|T], ([H2|T2], C), L, In) :-	append([H], [H2|T2], NL),
										acha_dist(H, H2, Custo),
										C2 is C + Custo,
										poe_fim(In, (NL, C2), R),
										expande(T, ([H2|T2], C), L, R), !.


% Busca em largura usando arestas.
% Inicio: Nodo de inicio da busca.
% L: Onde retorna a resposta.
%	O ultimo valor comeca valendo qualquer coisa, porque precisa da lista não vazia.
buscalargura(Inicio, L) :- buscalarguraa(Inicio, [([Inicio], 0)], L, [a]), !.


buscalarguraa(_, RES, Resposta, []) :- menor(RES, Resposta), !.

%	Expande o topo e insere no final, faz a poda e continua pro resto da lista.
buscalarguraa(Inicio, [([H|T], Custo)|Resto], L, _) :-		todas_cidades(H, Todas),
															subtract(Todas, T, Disponivel),
															%	Se Disponivel esta vazio, acabou
															(Disponivel = [] ->
																buscalarguraa(Inicio, [([H|T], Custo)|Resto], L, []), !

															% Se disponivel não esta vazio, não terminou
															;
																expande(Disponivel, ([H|T], Custo), Retorno),
																append(Resto, Retorno, Expandido),
																%write_list(["Antes da poda: ", Expandido, "\n"]),
																poda(Expandido, Nivel),
																%write_list(["Depois da poda: ", Nivel, "\n\n"]),
																buscalarguraa(Inicio, Nivel, L, Retorno), !
															), !.


%   Insere no finals
poe_fim([],C,[C]) :- !.
poe_fim([X|R1],C,[X|R2]) :- poe_fim(R1,C,R2), !.

%	Recebe uma lista de caminhos e retorna o com menor custo.
menor([H|T], R) :- menor(T, H, R), !.
menor([], H, H) :- !.
menor([(L, C)|T], (_, CM), R) :- C < CM, menor(T, (L, C), R), !.
menor([(_, _)|T], (LM, CM), R) :- menor(T, (LM, CM), R), !.
