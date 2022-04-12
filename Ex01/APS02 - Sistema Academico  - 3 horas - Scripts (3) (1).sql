set datestyle to 'european';
create table curso(codcurso int PRIMARY KEY, curso varchar(50), duracao int,  dtcurso date);

create table analista(codanalista int PRIMARY KEY, analista varchar(50), idade int, endereco char(30),codcurso int, salario float);

create table programador (codprogramador int PRIMARY KEY, progranador varchar(50), idade int, endereco char(30),salario float);

create table atividadesanalise (codatividadeanalise int PRIMARY KEY, dtinicio date,dttermino date, descricao varchar(100), codanalista int);

create table atividadesprog (codatividadeprog int PRIMARY KEY, dtinicio date,dttermino date, descricao varchar(100), codprogramador int, codatividadeanalise int);



insert into curso values ('1','Oracle 8i', '360', '2009-03-01');

insert into curso values ('2','Delphi', '300', '2009-05-30');

insert into curso values ('3','Windows 98', '20', '2009-04-28');

insert into curso values ('4','linux', '35', '2009-06-06');

insert into curso values ('5','Visual Basic', '120', '2009-04-28');

insert into curso values ('6','Office', '15', '2009-05-30');


insert into analista values ('1','Joao', '20','Av. Carlso Gomes, 200', '1','2300');

insert into analista values ('2','Joice', '24','Av independencia,10', '1','2245');

insert into analista values ('3','Pedro', '32','Av Carlos Gomes,100', '2','2145');

insert into analista values ('4','Maria', '28','Dom Pedro II,10', '6','1890');

insert into analista values ('5','Rafael', '29','Av Nilo Peçanha,40', '2','2800');


insert into programador values ('10','Jeferson', '34','Av Ipiranga,10','1000');
insert into programador values ('20','Andrea', '25','Souza Reis,200', '1200');
insert into programador values ('30','Ana Paula', '23','Av. Carlos Gomes,100', '1450');
insert into programador values ('40','Fernando', '20','Av. Ipiranga,20', '1600');
insert into programador values ('50','Susana', '40','Av. Assis Brasil,200', '1180');

insert into atividadesanalise values ('10','2009-01-01', '2009-01-30','Processo de venda', '2');
insert into atividadesanalise values ('20','2009-02-03', '2009-02-28','Pedido de compra', '2');
insert into atividadesanalise values ('30','2009-04-05', '2009-06-20','Cadastro fornecedor', '1');
insert into atividadesanalise values ('40','2009-06-06', '2009-07-30','Cadastro Produto', '4');

insert into atividadesprog values ('100','2009-01-05', '2009-01-07','tela 105', '10', '10');
insert into atividadesprog values ('101','2009-02-05', '2009-02-28','Relatorio 12', '10', '20');
insert into atividadesprog values ('102','2009-02-05', '2009-02-15','Procedure', '20', '20');
insert into atividadesprog values ('103','2009-04-06', '2009-04-10','tela 165', '10', '30');
insert into atividadesprog values ('104','2009-06-09', '2009-06-15','Relatorio 16', '30', '30');