/*Nome: João Carlos Becker  Trabalho3 tópicos em inteligência artificial


Fazer um banco de dados que modele a estrutura de uma faculdade com professores,
alunos, e disciplinas com seus respectivos horários.

Faça predicados para responder a perguntas sobre este banco de dados:
* Quais disciplinas um professor/aluno leciona/assiste
* Quais são os horários livres de um professor/aluno
* Quais são os horários comuns entre um professor e um aluno
* Quais são os horários comuns entre um professor e um aluno
* Quantas desciplinas são ministradas na parte da manhã
* Invente 3 outras perguntas interessantes

Faça um predicado que teste os predicados criados.
Observação: Os predicados de coleta de soluções devem ser usados, embora em
alguns casos outros predicados serão necessários também

*/


%Banco de dados-----------------------------------------------------------------
%aluno(Matricula, 'Nome')
aluno(1411100040, 'jcb').
aluno(1411100015, 'Leonardo Bianchini').
aluno(1411100022, 'Marco Aurélio').
aluno(1411100001, 'Vladimir Belinski').
aluno(1, 'Fulano').
aluno(2, 'Beltrano').
aluno(3, 'Ciclano').
aluno(4, 'Pedrinho').
aluno(5, 'Joãozinho').
aluno(6, 'Mariazinha').
aluno(666, 'Xuxa').

%professor(SIAP, nome).
professor(1, 'Emilio').
professor(2, 'Bins').
professor(3, 'Marco').
professor(4, 'Padilha').
professor(5, 'Andressa').
professor(6, 'Guilherme').
professor(7, 'Ricardo').
professor(8, 'Zatesko').
professor(9, 'Caimi').
professor(10, 'Neri').
professor(11, 'Bráulio').


/*
Horarios seguindo a lógica de grade usado no travalho de inteligencia artificial
     S     T    Q    Q    S
----------------------------
M    0     2    4    6    8
     1     3    5    7    9
----------------------------
V    10   12   14   16   18
     11   13   15   17   19
----------------------------
N    20   22   24   26   28
     21   23   25   27   29
*/
hr(0). hr(1). hr(2). hr(3). hr(4). hr(5). hr(6). hr(7). hr(8). hr(9).
hr(10). hr(11). hr(12). hr(13). hr(14). hr(15). hr(16). hr(17). hr(18). hr(19).
hr(20). hr(21). hr(22). hr(23). hr(24). hr(25). hr(26). hr(27). hr(28). hr(29).


%disciplina('Disciplina', Professor(SIAP), [A1, A2, ..., AN](Alunos), [H1, H2]).
disciplina('Comp. Dist.', 1, [1411100040, 1411100022, 1411100001],[0, 5]).
disciplina('IA', 2, [1411100040, 1411100022, 1411100001, 1411100015],[1, 8]).
disciplina('OptII', 4, [1, 2, 3, 1411100001],[2, 3]).
disciplina('OptI', 5, [3, 1411100001, 1411100040, 1411100022],[4, 9]).
disciplina('TCC', 3, [1, 1411100001, 1411100040, 1411100022, 666],[10, 11]).
disciplina('OptIII', 2, [1, 5, 6, 1411100001, 1411100040, 1411100022],[22, 23]).

%Fim do banco de dados----------------------------------------------------------

%Testa tudo---------------------------------------------------------------------
testall:-write('Imprimindo todos alunos e suas respectivas disciplinas:'), nl, printallalunos,nl, nl,
    write('Imprimindo todos professores e suas respectivas disciplinas:'), nl, printprofessores, nl, nl,
    write('Os horários disponíveis de cada professor são: '),nl,  printProfessoresLivres, nl, nl.




printallalunos:-forall(aluno(A, _), alunoassiste(A)).

printprofessores:-forall(professor(A, _), professorleciona(A)).

printProfessoresLivres:- forall(professor(P, Nome), (write('Professor '),write(Nome), write(' Tem livre os horários :'),freehp(P, L), write(L), nl)).

%Quais disciplinas um professor/aluno leciona/assiste
alunoassiste(X):- aluno(X, Nome), write(Nome), write(' assiste as disciplinas: '), forall(disciplina(Disc, _, As, _), alunoassiste(Disc, X, As)), nl.
alunoassiste(Disc, X, As):-member(X, As), write(Disc), write(', ').
alunoassiste(_, _, _).

professorleciona(X):- professor(X, Nome), write(Nome), write(' leciona as disciplinas: '), forall(disciplina(Disc, P, _, _), professorleciona(Disc, X, P)), nl.
professorleciona(Disc,X, X):-write(Disc), write(', ').
professorleciona(_, _, _).


%Horarios livres de um professor P, freehp(P, FreeList).
freehp(P, O):-hrdoprofessor(P, L), freehorarios(L, O).
hrdoprofessor(P, L):- findall(Hr, disciplina(_, P, _, Hr), Ca), flatten(Ca, L).
freehorarios(Lin, Lout):-findall(A , hr(A), L), subtract(L, Lin, Lout).

