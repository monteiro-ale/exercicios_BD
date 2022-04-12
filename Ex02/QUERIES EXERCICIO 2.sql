/*Recuperar os nomes de produtos solicitados em pelo menos um pedido*/
--Forma 1:
SELECT DISTINCT NOME 
FROM produto
INNER JOIN movimento ON produto.cod_prod = movimento.cod_prod
INNER JOIN pedido ON pedido.nro_ped = movimento.nro_ped;
--Forma 2:
SELECT NOME
FROM produto, movimento, pedido
WHERE produto.cod_prod = movimento.cod_prod
AND pedido.nro_ped = pedido.nro_ped
GROUP BY NOME;

/*Recuperar o nome e telefone de clientes que solicitaram pelo menos um produto de nome Confort*/
--Forma 1:
SELECT cliente.NOME,
	TELEFONE
FROM cliente
INNER JOIN pedido ON cliente.cod_cli = pedido.cod_cli
INNER JOIN movimento ON pedido.nro_ped = movimento.nro_ped
INNER JOIN produto ON movimento.cod_prod = produto.cod_prod
WHERE produto.nome = 'Confort'
--Forma 2:
SELECT cliente.NOME,
	TELEFONE
FROM cliente, pedido, movimento, produto
WHERE cliente.cod_cli = pedido.cod_cli
AND pedido.nro_ped = movimento.nro_ped
AND movimento.cod_prod = produto.cod_prod
AND produto.nome = 'Confort'

/*Selecionar código e nome de clientes cujos nomes contenham Ltda*/
--Forma 1:
SELECT nome,
	cod_cli
FROM cliente
WHERE nome LIKE '%Ltda%'
--Forma 2:
WITH ltda as (
	SELECT NOME,
		cod_cli
	FROM cliente
	WHERE nome LIKE '%Ltda%'
)
SELECT cliente.cod_cli,
		cliente.nome
FROM cliente
INNER JOIN ltda ON cliente.cod_cli = ltda.cod_cli;

/*Recuperar o nome de cada produto e o seu preço em dólares*/
--Forma 1:
SELECT nome,
	CAST(preco / 4.77 as decimal(5,2)) AS preco_dolar
FROM produto
--Forma2:
SELECT t.nome,
	t.preco as preco_dolar
FROM ( SELECT nome,
	  	CAST(preco / 4.77 as decimal (5,2)) as preco
	  FROM produto
)t

/*Recuperar o nome de cada produto e o seu preço em dólares. Ordenar a consulta em
ordem decrescente de preço*/
--Forma1:
SELECT nome,
	CAST(preco / 4.77 as decimal(5,2))
FROM produto
ORDER BY preco DESC
--Forma2:
SELECT t.nome,
	t.preco as preco_dolar
FROM ( SELECT nome,
	  	CAST(preco / 4.77 as decimal (5,2)) as preco
	  FROM produto
)t
ORDER BY t.preco DESC
/*##################################################*/