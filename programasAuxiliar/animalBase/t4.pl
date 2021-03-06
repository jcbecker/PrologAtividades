/*
Nome: João Carlos Becker
Para começar a jogar use o comando start.
Observação: start. só pode ser usado uma vez
Para ter uma noção de como ficou a arvore de resultado após terminar o jogo pode usar o comando listing(tnode).
Com base de dados em arquivo
*/


ask(animal(X)):- write('Seu animal é um(a) '), ask(mreadyw(X)).
ask(feature(X)):- write('Seu animal '), ask(mreadyw(X)).
ask(mreadyw(X)):-write(X), write('? Digite s. para sim e n. para não'), nl.
    
    
gameover:-write('Deseja continuar jogando? Digite s. para sim e n. para não'), nl,
    read(R), ((R == sim ; R == s) -> fail; true).

win:-write('HAHAHA! Ganhei sou muito bom'), nl, gameover.
lost(ID):-write('Droga, você ganhou dessa vez'), nl,mysolve(ID), gameover.

mysolve(ID):- tnode(ID, animal(X), nil, nil),
    write('Digite o animal em que estava pensando, entre aspas simples'), nl, 
    read(NewX), 
    write('Digite algo que '), write(NewX), write(' tem ou é. E '), write(X), write(' não. Entre aspas simples.'), nl,
    read(Diff),
    generateId(N),
    generateId(Y),
    assert(tnode(ID, feature(Diff), N, Y)),
    assert(tnode(N, animal(X), nil, nil)),
    assert(tnode(Y, animal(NewX), nil, nil)),
    retract(tnode(ID, animal(X), nil, nil)).


%Base de dados inicial, para iniciar apenas com gorila excuir tnodes abaixo e escrever tnode(0, animal('gorila'), nil, nil).
%tnode(ID, Info, NoChild, Yeschild).


rtree(nil):-write('Fim de arvore! Algo deu errado'), nl.
rtree(ID):-tnode(ID, feature(X), N, Y), ask(feature(X)), read(R), ((R == sim ; R == s) -> rtree(Y); rtree(N)).
rtree(ID):-tnode(ID, animal(X), _, _), ask(animal(X)), read(R), ((R == sim ; R == s) -> win; lost(ID)).


start:-
    carregar,
    set_flag(my_id, 15),%Observação quando mudar a base de dados inicial, precisamos atualizar este valor
    repeat,
        play,
    escreverBase,
    write('Você não pode usar o comando start. novamente, precisa sair do swipl e começar outro jogo com uma nova base de dados!'), nl, !.
    
play:-rtree(0).

carregar:-open('animalBase.txt', read, S),repeat, leituraLinha(S), close(S), !.
leituraLinha(S):-read(S, In),(In=end_of_file | assert(In), fail).

escreverBase:-open('animalBase.txt', write, S), forall(tnode(ID, Info, N, Y), (writeq(S,tnode(ID, Info, N, Y)), write(S, '.'), nl(S))), close(S).

generateId(Id):-flag(my_id, Id, Id+1).

