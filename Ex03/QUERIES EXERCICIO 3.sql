
/*Recuperar os nomes de clientes que não voaram para o Rio de Janeiro no dia 20/09/02.*/

/*1: De-duplicando os clientes que tem mais de um vôo no mesmo dia*/

WITH t1
     AS (SELECT cliente_p.nome,
                cliente_p.cod_cli,
                passagem.num_voo,
                cidade_cheg
         FROM   cliente_p
                INNER JOIN passagem
                        ON cliente_p.cod_cli = passagem.cod_cli
                INNER JOIN voo
                        ON passagem.num_voo = voo.num_voo
         WHERE  passagem.data IN ( '2002-09-20' )
                AND cidade_cheg NOT IN ( 'Rio de Janeiro' )),
     t2
     AS (SELECT Count(cod_cli) AS contagem,
                cod_cli
         FROM   passagem
         WHERE  passagem.data IN ( '2002-09-20' )
         GROUP  BY cod_cli
         HAVING Count(cod_cli) = 1
         ORDER  BY contagem)
SELECT t1.nome
FROM   t1
       INNER JOIN t2
               ON t1.cod_cli = t2.cod_cli
GROUP  BY t1.nome;

/*Sem de-duplicar*/

SELECT cliente_p.nome,
                cliente_p.cod_cli,
                passagem.num_voo,
                cidade_cheg
         FROM   cliente_p
                INNER JOIN passagem
                        ON cliente_p.cod_cli = passagem.cod_cli
                INNER JOIN voo
                        ON passagem.num_voo = voo.num_voo
         WHERE  passagem.data IN ( '2002-09-20' )
                AND cidade_cheg NOT IN ( 'Rio de Janeiro' )

/* Para cada vôo que o piloto Paulo tenha comandado, recuperar a cidade de partida e a data do vôo,
bem como o número de passagens marcadas. Mostrar somente os vôos com menos de 500
passagens.*/
WITH t1
     AS (SELECT cidade_part,
                execucao_voo.data,
                passagem.num_voo
         FROM   voo
                INNER JOIN execucao_voo
                        ON execucao_voo.num_voo = voo.num_voo
                INNER JOIN passagem
                        ON execucao_voo.num_voo = passagem.num_voo
                INNER JOIN piloto
                        ON execucao_voo.cod_piloto = piloto.cod_piloto
         WHERE  piloto.nome = ( 'Paulo' )
         GROUP  BY cidade_part,
                   execucao_voo.data,
                   passagem.num_voo),
     t2
     AS (SELECT Count(cod_cli)
                  OVER (
                    PARTITION BY passagem.num_voo
                    ORDER BY passagem.num_voo) AS contagem,
                passagem.num_voo
         FROM   passagem
                INNER JOIN execucao_voo
                        ON passagem.num_voo = execucao_voo.num_voo
                INNER JOIN piloto
                        ON execucao_voo.cod_piloto = piloto.cod_piloto
         WHERE  piloto.nome = ( 'Paulo' )
         GROUP  BY passagem.num_voo,
                   cod_cli
         HAVING Count(cod_cli) < 500
         ORDER  BY contagem)
SELECT t1.cidade_part,
       t1.data,
       t2.contagem
FROM   t1
       INNER JOIN t2
               ON t1.num_voo = t2.num_voo
GROUP  BY t1.cidade_part,
          t1.data,
          t2.contagem 


/*Obter a cidade de partida e a data do último vôo que o piloto Paulo tenha comandado*/
WITH T1 AS (SELECT cidade_part,
execucao_voo.data
FROM voo
INNER JOIN execucao_voo ON execucao_voo.num_voo = voo.num_voo
INNER JOIN piloto ON execucao_voo.cod_piloto = piloto.cod_piloto
WHERE piloto.nome = ('Paulo')
GROUP BY cidade_part,
execucao_voo.data
),
T2 AS ( SELECT MAX(data) as data
	   FROM execucao_voo, piloto
	   WHERE execucao_voo.cod_piloto = piloto.cod_piloto 
	   AND piloto.nome = ('Paulo')
)
SELECT T1.cidade_part,
t2.data
FROM T1
INNER JOIN T2 ON T1.data = T2.data

