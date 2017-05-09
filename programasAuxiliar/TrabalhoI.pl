
%Ex 3.7 
membro_n(X,L,N):- membro_n(0,X,L,N).
membro_n(N,_,[],N).
membro_n(N0,X,[X|R],N1):- N2 is N0 + 1, membro_n(N2,X,R,N1).
membro_n(N0,X,[_|R],N1):- membro_n(N0,X,R,N1).

%Ex 3.9 
membro_p(P,L,X):- membro_p(1,P,L,X).
membro_p(_,_,[],nil).
membro_p(P,P,[X|R],X).
membro_p(P0,P1,[_|R],X):- P2 is P0 + 1, membro_p(P2,P1,R,X).

%Ex 3.10 
membro(X,[X|R]).
membro(X,[_|R]):- membro(X,R).

pertence([],L2).
pertence([X|R],L2):- membro(X,L2), pertence(R,L2).

%Ex 3.11 
pertence_s(L1,L2,L2,L1):- pertence(L1,L2).
pertence_s(L1,L2,L1,L2):- pertence(L2,L1).

%Ex 3.13 
concatena([],[],[]).
concatena([],[X|R1],[X|R2]):- concatena([],R1,R2).
concatena([X|R1],L,[X|R2]):- concatena(R1,L,R2).

%Ex 3.14 
subtrai_e(_,[],[]).
subtrai_e(X,[X|R],R).
subtrai_e(X,[Y|R1],[Y|R2]):- subtrai_e(X,R1,R2).

subtrai([],_,[]).
subtrai(L,[],L).
subtrai(L1,[X|R],L2):- subtrai_e(X,L1,L3), subtrai(L3,R,L2).

subtrai_e2(_,[],[]).
subtrai_e2(X,[X|R1],L2):- subtrai_e2(X,R1,L2).
R],R).
subtrai_e2(X,[X|R1],L2):- subtrai_e2(X,R1,L2).
R],R).
subtrai_e2(X,[Y|R1],[Y|R2]):- subtrai_e2(X,R1,R2).

subtrai2([],_,[]).
subtrai2(L,[],L).
subtrai2(L1,[X|R],L2):- subtrai_e2(X,L1,L3), subtrai2(L3,R,L2).


teste:- teste1, fail.
teste:- teste2, fail.
teste:- teste3, fail.
teste:- teste4, fail.
teste:- teste5, fail.
teste:- teste6, fail.
teste.

teste1 :- write("Teste do Exercício 3.7:"), nl,
	    X = c, L = [a,c,g,h,5,c,b,2,u],
	    write(">> X = "), write(X), write(' >> Lista = '),
         writeq(L), nl, membro_n(c,L,N), write("Resposta :"),
         write(N), nl, nl, !.

teste2 :- write("Teste do Exercício 3.9:"), nl,
	    P = 3, L = [a,c,g,h,5,c,b,2,u],
	    write(">> P = "), write(P), write(' >> Lista = '),
         writeq(L), nl, membro_p(P,L,X), write("Resposta :"),
         write(X), nl, nl, !.

teste3 :- write("Teste do Exercício 3.10:"), nl,
	    L1 = [2,5,c], L2= [a,c,g,h,5,c,b,2,u], 
	    write(">> L1 = "), write(L1), write(' >> L2 = '),
         writeq(L2), nl, (pertence(L1,L2), write(true) | 		    write(false)), nl, write(">> L1 = "), write(L2),           	    write(' >> L2 = '), writeq(L1), nl, (pertence(L2,L1), 	    write(true) | write(false)), nl, nl, !.

teste4 :- write("Teste do Exercício 3.11:"), nl,
	    L1 = [2,5,c], L2= [a,c,g,h,5,c,b,2,u], 
	    write(">> L1 = "), write(L1), write(' >> L2 = '),
         writeq(L2), nl, ( pertence_s(L1,L2,L3,L4), 		  	   write("Resposta :"), writeq(L4), write(" pertence a "), 	   writeq(L3) |  write(false)), nl, nl, 
	   L5 = [2,5,t], 
	    write(">> L1 = "), write(L5), write(' >> L2 = '),
         writeq(L2), nl, ( pertence_s(L5,L2,L6,L7), 		  	   write("Resposta :"), writeq(L7), write(" pertence a "), 	   writeq(L6) |  write(false)), nl, nl, !.


teste5 :- write("Teste do Exercício 3.13:"), nl,
	    L1 = [2,5,c], L2= [a,c,g,h,5,c,b,2,u], 
	    write(">> L1 = "), write(L1), write(' >> L2 = '),
         writeq(L2), nl, concatena(L1,L2,L3), 		  	    	   write("Resposta :"), writeq(L3), nl, nl, !.

teste6 :- write("Teste do Exercício 3.14:"), nl,
	    L1= [a,c,g,h,5,c,b,2,u],  L2 = [2,5,c], 
	    write(">> L1 = "), write(L1), write(' >> L2 = '),
         writeq(L2), nl, subtrai(L1,L2,L3), 		  	    	   write("Resposta :"), writeq(L3), nl, nl, 
	   write("Outra solução do Exercício 3.14:"), nl,
	    L1= [a,c,g,h,5,c,b,2,u],  L2 = [2,5,c], 
	    write(">> L1 = "), write(L1), write(' >> L2 = '),
         writeq(L2), nl, subtrai2(L1,L2,L4), 		  	    	   write("Resposta :"), writeq(L4), nl, nl, !.



