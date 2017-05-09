for(X,X,_) :- !, fail.
for(X,L,X).
for(X,L,Y) :- X1 is X + 1, for(X1,L,Y).
