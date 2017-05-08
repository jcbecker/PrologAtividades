
%% Testa se um elemento é membro de uma lista dada

membro(_, []):- fail.
membro(X, [X|_]).
membro(X,[_|R]) :- membro(X,R).

%% Imprime uma lista dada

imprime([]).
imprime([X|R]) :- write(X), write(' '), imprime(R).

%% Retorna o primeiro elemento de uma lista dada

primeiro([X|_],X).

%% Retorna o ultimo elemento de uma lista dada

ultimo([X|[]],X).
ultimo([X|R],Y) :- ultimo(R,Y).

%% Remove o ultimo elemento de uma lista dada e
%% retorna a lista sem o ultimo elemento

remove_ultimo([X|[]],[]).
remove_ultimo([X|R1],[X|R2]) :- remove_ultimo(R1,R2).

%% Remove o ultimo elemento de uma lista dada e
%% retorna a lista sem o ultimo elemento e o ultimo elemento

remove_ultimo([X|[]],[], X).
remove_ultimo([X|R1],[X|R2], Y) :- remove_ultimo(R1,R2,Y).

%% Inverte uma lista dada eretorna a lista invertida

inverte([],[]).
inverte(L,[X|R]):- remove_ultimo(L,L1,X), inverte(L1,R).

%% Conta o número de elementos é de uma lista dada

conta(X,[],X).
conta(X,[_|R], Y) :- Z is X + 1, conta(Z,R,Y).
