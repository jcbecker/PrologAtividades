%% 3.7
conta(P, X, N) :- conta(P, X, 0, N).
conta(_, [], N, N).
conta(P, [P|Y], N, N2) :- N1 is N + 1, conta(P, Y, N1, N2).
conta(P, [X|Y], N, N2) :- conta(P, Y, N, N2).


%% 3.9
getindex(I, L, R) :- getindex(I, L, 0, R).
getindex(I, [X|Y], I, X).
getindex(I, [X|Y], ID, R) :- ID2 is ID+1 ,getindex(I, Y, ID2, R).


%% 3.10
subset([], L2).
subset([X|Y], L2) :- inset(X, L2), subset(Y, L2).
inset(A, [A|Y]).
inset(A, [B|Y]) :- inset(A, Y).


%% 3.11
subset2([], L2, B, L2, B).
subset2([X|Y], L2, LISTA, SUB) :- inset2(X, L2), subset2(Y, L2, SUB, LISTA, [X|Y]).
subset2([X|Y], L2, SUB, LISTA, [Z|W]) :- inset2(X, L2), subset2(Y, L2, SUB, LISTA, [Z|W]).
inset2(A, [A|Y]).
inset2(A, [B|Y]) :- inset2(A, Y).


%% 3.12.0 inserir no inicio
appendStart(L, X, [X|L]).
%% 3.12.1
append(X, [H|T], [H|R]):- append(X, T, R).
append(X, [], [X]).

%% 3.13
catenate([H1|L1], L2, [H1|R2]):- catenate(L1, L2, R2).
catenate([], [H2|L2], [H2|R2]):- catenate([], L2, R2).
catenate([], [], []).

%% 3.14
deletf([I|L1], I, R2):-deletf(L1, I, R2).
deletf([H1|L1], I, [H1|R2]):- deletf(L1, I, R2).
deletf([], I, []).


subless(L1, [H1|L2], R):-deletf(L1, H1, R2), subless(R2, L2, R).
subless([H1|L1], [], [H1|L1]).
