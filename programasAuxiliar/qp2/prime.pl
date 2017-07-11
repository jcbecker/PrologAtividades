%testa se o número x é primo
eh_primo(X) :- L is sqrt(X), eh_primo(2,L,X), !.
eh_primo(I,L,_):- I > L, !.
eh_primo(I,_,X):- Y is X mod I, Y = 0, !, fail.
eh_primo(I,L,X):- I1 is I+1, eh_primo(I1,L,X), !.

%P= próximo numero primo depois de N
prox_primo(N,P):- P is N + 1, eh_primo(P), !.
prox_primo(N,P):- N1 is N + 1, prox_primo(N1,P), !.

%N-ésimo número primo 
nesimo_primo(1,1).
nesimo_primo(N,P):- N1 is N-1, nesimo_primo(N1,P1), prox_primo(P1,P), !.