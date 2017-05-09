% operadores Booleanos

:- op(1000, xfx, ':=').
:- op(600, yfx, [&, v]).
:- op(500, fy, ~).

eval(true) :- !.
eval(~A) :- not(eval(A)), !.
eval(A v B) :- eval(A) ; eval(B), !.
eval(A & B) :- eval(A), eval(B), !.
eval(A := B) :- eval(B), A = true, !.
eval(A := B) :- A = false, !.


% testar com eval(X := true & ~(false v false))