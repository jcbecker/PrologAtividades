%Nome: João Carlos Becker

filial('POA', [2345, 2346, 2347]).
filial('Curitiba', [3567, 3568, 3569, 3570]).

cliente(2345, 'Carlos', 45, 'Médico', [bem(c, 'Mercedes', 80000)]).
cliente(2346, 'Rogério', 23, 'Estudante', [bem(m, 'Kawasaki 1000', 24000)]).
cliente(2347, 'Marcelo', 52, 'Advogado', [bem(c, 'Audi A4', 57000), bem(c, 'Ford Focus', 25000)]).
cliente(3567, 'Ana', 35, 'Modelo', [bem(c, 'BMW Serie 3', 42000)]).
cliente(3568, 'Marcos', 20, 'Operário', [bem(c, 'Fiat Uno', 20000)]).
cliente(3569, 'Josés', 45, 'Professor', [bem(c, 'Fiat Pálio 1.6', 30000)]).
cliente(3570, 'João Carlos', 38, 'Médico', [bem(c, 'Ford Fox', 35000), bem(m, 'CB 450', 15000)]).

% 1 - chamar listaclientes()
listbycode([]).
listbycode([H|T]) :- cliente(H, NOME, IDADE, PROFISSAO, BEM), write(NOME), nl, listbycode(T).
listaclientes(FILIAL) :- filial(FILIAL, CODES), listbycode(CODES).
    
% 2
listatodos() :- filial(X, Y), write("Na filial "),write(X), nl, listaclientes(X), nl, fail.

% 3
profissoes() :- cliente(CODIGO, NOME, IDADE, PROFISSAO, BEM), write(NOME), write(": "), write(PROFISSAO), nl, fail.

% 4 - chamar printbens(NOME)

bem(A, B, C):-write(A),write(" "), write(B),write(" "), write(C),nl.
checkbens([]).
checkbens([H|T]) :- call(H), checkbens(T).
printbens(NOME) :- write(NOME), nl, cliente(CODIGO, NOME, IDADE, PROFISSAO, BENS), checkbens(BENS).

% 5
nclientes(X) :- findall(N, cliente(CODIGO, NOME, IDADE, PROFISSAO, BEM), Ns), length(Ns, X).
