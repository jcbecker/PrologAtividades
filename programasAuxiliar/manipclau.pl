% manipulando clausulas

cria_bd(Nome/Arg,N) :- 
	insere_clausulas(1,N, Nome/Arg), !.

insere_clausulas(N1,N, Nome/Arg) :- N1 > N, !.
insere_clausulas(N1,N, Nome/Arg) :-
	     write('Clausula '), write(N1), write(' : '),
        	pega_arg(0, Arg, L),
        	monta_clausula(L,Nome,T),
        	assertz(T), N2 is N1 + 1, insere_clausulas(N2,N, Nome/Arg), !.

pega_arg(N,N,[]) :- !. 
pega_arg(N,L,[Arg1|Lista]) :- 
	N1 is N + 1,
        write('Argumento '), write(N1), write(': '),
        le_string(Arg1),
        pega_arg(N1,L,Lista), !.

monta_clausula(L,N,T) :- lista_string(L,S1), 	  	  			atom_string(N,S2), 
         string_concat(S2,"(",S3),string_concat(S3,S1,S4), 
         string_concat(S4,")",S5), term_string(T,S5), !.

lista_string([],""):- !.
lista_string([X|R],S):- atom_string(X,Y), lista_string(R,Z),      	  (Z = "", S1 = Y | string_concat(Y,",",S1)),  	     	  	  string_concat(S1,Z,S), !.


le_string(S) :- le_lista(L), atom_chars(S,L), !.

le_lista(L) :- get0(C), (C = 10, L = [] | le_lista(L1), L = [C|L1]), !.
        
