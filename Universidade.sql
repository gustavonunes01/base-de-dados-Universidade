-- EXERCICIO 2 Crie uma base de dados Universidade com as tabelas a seguir:
--Alunos (MAT, nome, endereço, cidade)
--Disciplinas (COD_DISC, nome_disc, carga_hor)
--Professores (COD_PROF, nome, endereço, cidade)
--Turma (COD_DISC, COD_TURMA, COD_PROF, ANO, horário)
-- COD_DISC referencia Disciplinas
-- COD_PROF referencia Professores
--Histórico (MAT, COD_DISC, COD_TURMA, COD_PROF, ANO, frequência, nota)
-- MAT referencia Alunos
-- COD_DISC, COD_TURMA, COD_PROF, ANO referencia Turma

--2 - 

create database Universidade;
	use Universidade;

create table alunos(
	MAT varchar(15) not null,
	nome varchar(100),
	rua varchar(30),
	local varchar(15),
	cidade varchar(60),
	primary key(MAT));

create table disciplinas(
	COD_DISC varchar(10) not null,
	nome varchar(60),
	carga_hor time,
	primary key(COD_DISC));

create table professores(
	COD_PROF varchar(10) not null,
	nome varchar(100),
	rua varchar(30),
	cidade varchar(60),
	primary key(COD_PROF));

create table turma(
	COD_DISC varchar(10) not null,
	COD_TURMA integer not null,
	COD_PROF varchar(10) not null,
	ANO integer not null,
	horario varchar(20),
	primary key(COD_DISC, COD_TURMA, COD_PROF, ANO),
	foreign key(COD_DISC) references disciplinas(COD_DISC),
	foreign key(COD_PROF) references professores(COD_PROF));

create table historico(
	MAT varchar(15) not null,
	COD_DISC varchar(10) not null,
	COD_TURMA integer not null,
	COD_PROF varchar(10) not null,
	ANO integer not null,
	frequencia integer not null,
	nota float,
	primary key(MAT, COD_DISC, COD_TURMA, COD_PROF, ANO),
	foreign key(COD_DISC, COD_TURMA, COD_PROF, ANO) references turma(COD_DISC, COD_TURMA, COD_PROF, ANO),
	foreign key(MAT) references alunos(MAT));

-- Insert registros:

insert into alunos values(2015010101, 'JOSE DE ALENCAR', 'RUA DAS ALMAS',  'NATAL');
insert into alunos values(2015010102, 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA');
insert into alunos values(2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE');
insert into alunos values(2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA');
insert into alunos values(2015010105, 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');
insert into alunos values(2015010106, 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');


insert into disciplinas values('BD', 'BANCO DE DADOS', '100:00:00');
insert into disciplinas values('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', '100:00:00');
insert into disciplinas values('WEB', 'AUTORIA WEB', '50:00:00');
insert into disciplinas values('ENG', 'ENGENHARIA DE SOFTWARE', '80:00:00');


insert into professores values(212131, 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA');
insert into professores values(122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL');
insert into professores values(192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');


insert into turma values('BD', 1, 212131, 2015, '11H-12H');
insert into turma values('BD', 2, 212131, 2015, '13H-14H');
insert into turma values('POO', 1, 192011, 2015, '08H-09H');
insert into turma values('WEB', 1, 192011, 2015, '07H-08H');
insert into turma values('ENG', 1, 122135, 2015, '10H-11H');



insert into historico values(2015010101, 'BD', 1, 212131, 2015, 10, 5.74);
insert into historico values(2015010102, 'POO', 1, 192011, 2015, 4, 10);
insert into historico values(2015010103, 'WEB', 1, 192011, 2015, 5, 5);
insert into historico values(2015010104, 'ENG',1, 122135, 2015, 5, 6.2);
insert into historico values(2015010105, 'BD', 2, 212131, 2015, 4, 4.5);
insert into historico values(2015010106, 'WEB', 1, 192011, 2015, 8, 5.5);





a)Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD =
código da disciplinas).

r: select A.MAT as Matricula, A.nome from alunos A join historico H on H.MAT=A.MAT
where H.COD_DISC='BD' and H.nota < 5;

b) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO
em 2015.

r: select A.MAT as Matricula, A.nome, AVG(H.nota) from alunos A join historico H on H.MAT=A.MAT
where H.COD_DISC='POO';

c) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO
em 2015 e que esta média seja superior a 6.

r: select A.MAT as Matricula, A.nome, H.nota from alunos A join historico H on H.MAT=A.MAT
where H.COD_DISC='POO' GROUP BY H.nota HAVING AVG(H.nota) > 6;

d) Encontre quantos alunos não são de Natal.

r: select * from alunos where cidade <> 'NATAL';

