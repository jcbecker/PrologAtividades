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


%horario(DIA, 'Código', 'hora de inicio ~ hora de fim')., código igual turno, M= matutino, V= vespertino, N= noturno, [1, 2, 3, 4, 5] número da aula no turno
horario(_, 'M1', '07:30 ~ 08:20').
horario(_, 'M2', '08:20 ~ 09:10').
horario(_, 'M3', '09:10 ~ 10:00').
horario(_, 'M4', '10:10 ~ 11:00').
horario(_, 'M5', '11:00 ~ 11:50').
horario(_, 'V1', '13:30 ~ 14:20').
horario(_, 'V2', '14:20 ~ 15:10').
horario(_, 'V3', '15:10 ~ 16:00').
horario(_, 'V4', '16:20 ~ 17:10').
horario(_, 'V5', '17:10 ~ 18:00').
horario(_, 'N1', '19:00 ~ 19:50').
horario(_, 'N2', '19:50 ~ 20:40').
horario(_, 'N3', '21:00 ~ 21:50').
horario(_, 'N4', '21:50 ~ 22:40').

%disciplina('Disciplina', Professor(SIAP), [A1, A2, ..., AN](Alunos), [H1, H2, H3, H4, H5]).
disciplina('Comp. Dist.', 1, [1411100040, 1411100022, 1411100001],[horario('segunda', 'M1'), horario('segunda', 'M2'), horario('segunda', 'M3'), horario('quarta', 'M4'), horario('quarta', 'M5')]).
disciplina('IA', 2, [1411100040, 1411100022, 1411100001],[horario('segunda', 'M1'), horario('segunda', 'M2'), horario('segunda', 'M3'), horario('quarta', 'M4'), horario('quarta', 'M5')]).
