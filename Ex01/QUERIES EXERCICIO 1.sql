/*1 – Criar uma view com o nome de cursosanalista, que contém o nome do curso, nome do
 analista e salário do analista com um aumento de 10%.*/
-- curso.Curso // analista.Analista // (analista.Salario + 10%) MATCH em codcurso
CREATE
OR REPLACE VIEW cursoanalista as
SELECT
    Curso,
    Analista,
    Salario + (Salario * 0.10) as salario_acresc
FROM
    curso
    INNER JOIN analista ON curso.Codcurso = analista.codcurso;

SELECT
    *
FROM
    cursoanalista;

/*2 – Montar uma consulta que mostra o nome do programador e a quantidade de dias de
 férias. Caso o programador tenha idade:
 de 20 a 24 anos 18 dias
 de 25 a 35 anos 21 dias
 acima de 35 anos 25 dias*/
-- programador.Programador // programador.Idade
/*A coluna da tabela "programador" foi criada como "progranador" ao invés de programador*/
SELECT
    progranador,
    Idade,
    CASE
        WHEN Idade BETWEEN 20
        AND 24 THEN '18 dias'
        WHEN Idade BETWEEN 25
        AND 35 THEN '21 dias'
        WHEN Idade > 35 THEN '25 dias'
    END AS dias_de_ferias
FROM
    programador
ORDER BY
    idade;

/*3 – Criar uma view com o nome de ativanalista, contendo o nome do analista e a
 quantidade de atividades de análise que ele realizou.
 */
-- analista.Analista // count (atividadeanalise)
CREATE VIEW ativanalista AS
SELECT
    Analista,
    COUNT(atividadesanalise.codanalista)
FROM
    analista
    INNER JOIN atividadesanalise ON analista.codanalista = atividadesanalise.codanalista
GROUP BY
    atividadesanalise.codanalista,
    analista;

SELECT
    *
FROM
    ativanalista;

/*4 – Montar uma consulta para atualizar o salário dos analistas a partir da quantidade de
 atividades de análise realizadas.
 1 atividade 5%
 2 atividades 10%
 3 atividades ou mais 15%*/

SELECT
    Analista,
    Salario,
    CASE
        WHEN COUNT(atividadesanalise.codanalista) = 1 THEN Salario + (Salario * 0.05)
        WHEN COUNT(atividadesanalise.codanalista) = 2 THEN Salario + (Salario * 0.10)
        WHEN COUNT(atividadesanalise.codanalista) >= 3 THEN Salario + (Salario * 0.15)
    END AS acrescimo_por_atv
FROM
    analista
    INNER JOIN atividadesanalise ON atividadesanalise.codanalista = analista.codanalista
GROUP BY
    Analista,
    Salario;

/*5 – Monte uma consulta para mostrar o nome do(s) analista(s) e o nome de seu respectivo
curso, o(s) qual(is) nunca tive(ram) atividades realizadas com o programador o qual tenha
em seu nome a palavra “Jefer”.*/




SELECT
    Analista,
    Curso
FROM
    analista
    INNER JOIN curso ON analista.codcurso = curso.codcurso
    INNER JOIN atividadesanalise ON analista.codanalista = atividadesanalise.codanalista
    INNER JOIN atividadesprog ON atividadesanalise.Codatividadeanalise = atividadesprog.Codatividadeanalise
WHERE
    Codatividadeanalise NOT IN (
        SELECT
            progranador
        FROM
            programador
        WHERE
            progranador LIKE 'Jefer%'
    )

SELECT DISTINCT
    Analista,
    Curso
FROM
    analista
    INNER JOIN curso ON analista.codcurso = curso.codcurso
    INNER JOIN atividadesanalise ON analista.codanalista = atividadesanalise.codanalista
	LEFT JOIN atividadesprog ON atividadesanalise.Codatividadeanalise = atividadesprog.Codatividadeanalise
	LEFT JOIN programador ON atividadesprog.codprogramador = programador.codprogramador
WHERE atividadesprog.Codatividadeanalise NOT IN
	( SELECT
            codprogramador
        FROM
            atividadesprog
        WHERE
            progranador NOT LIKE 'Jefer%'
	)


ALUGUEL 800
INTERNET 100
FACULDADE 550
LUZ 219
CIGARRO 360
PENSAO 200
TRANSPORTE 200
RENOVACAO BOLSA 586,18
3015
SOBRA 685 

WITH T1 AS (SELECT cliente_p.nome,
				cliente_p.cod_cli,
                passagem.cod_cli,
			    passagem.num_voo,
                cidade_cheg,
	   			num_voo
			FROM cliente_p
            INNER JOIN passagem ON cliente_p.cod_cli = passagem.cod_cli 
            INNER JOIN voo ON passagem.num_voo = voo.num_voo
            WHERE passagem.data IN ('2002-09-20')
            AND cidade_cheg NOT IN ('Rio de Janeiro')
),
T2 AS (SELECT
			passagem.cod_cli,
			passagem.num_voo
			FROM passagem
	   		WHERE passagem.data IN ('2002-09-20')
),
T3 AS (SELECT 	cidade_cheg,
	   			num_voo
	   		FROM voo
	   		WHERE cidade_cheg NOT IN ('Rio de Janeiro')
),
T4 AS (SELECT DISTINCT
			passagem.cod_cli
			FROM passagem
	   		WHERE passagem.data IN ('2002-09-20')
)

SELECT T1.nome
FROM T1
INNER JOIN T2 ON T1.cod_cli = T2.cod_cli
INNER JOIN T3 ON T2.num_voo = T3.num_voo
GROUP BY T1.nome;