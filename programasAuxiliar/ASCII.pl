% exercício com flag

ascii :-  flag(contador,_,0), 
	  repeat, 
	    flag(contador,N,N+1), 
	    write(N), write(':'), put(N), 
	    nl, 
	    N=255, !.

