/*--------------------------------------------------- TUNING -------------------------------------------------------
deixar uma query complexa com performance, retornando valores de forma rápida e eficiente

analisar minuciosamente todas as tabelas (ver as chaves, as triggers, as foreign keys, os grants (usuários que podem acessar a tabela))

sempre colocar apelido na tabela

tentar não buscar Strings na cláusula WHERE, pois o banco demora mais para buscar, mais fácil buscar números

---------------------------------------------------------------------------------------------------------------------*/

/*----------------------------------------------------- DASHBOARDS ------------------------------------------------------------
representação gráfica do que é retornado em uma query

-exporta para o excel
-vai em inserir
-seleciona toda a tabela e insere o gráfico

-------------------------------------------------------------------------------------------------------------------------------*/

--permitir o MySQL executar funções que não alteram em nada no banco
SET GLOBAL log_bin_trust_function_creators = 1; 

----------------------------------------------------------COMANDOS BÁSICOS-------------------------------------------------------

--------------------------- WHERE --------------------------
filtra os resultados

SELECT _________ 
FROM tabela 
WHERE _____ =, <, >, <>(diferente) _____;

--------------------------------- LIKE ----------------------------------
encontrar resultados que se pareçam com o conteúdo procurado

SELECT _________ 
FROM tabela 
WHERE _________ LIKE _________;

--nomes que começam com MAR:
SELECT *
FROM cliente
WHERE primeiro_nome LIKE "MAR%";

--nomes que começam, terminam ou tem MAR no meio:
SELECT *
FROM cliente
WHERE primeiro_nome LIKE "%MAR%";

--nomes que terminam com MAR:
SELECT *
FROM cliente
WHERE primeiro_nome LIKE "%MAR";

-------------------------- IN ---------------------------------
exibe todos os itens que estão naquele intervalo indicado
SELECT _____
FROM tabela
WHERE _________ IN (x, y, z);

--os clientes com ID 1, 2 e 3:
SELECT *
FROM cliente
WHERE cliente_id IN (1, 2, 3);

---------------------- BETWEEN ---------------------------------
trás todos os resultados que estão no intervalo indicado

SELECT _____
FROM tabela
WHERE _____ BETWEEN _____ AND _____;

--clientes com id entre 1 e 20:

SELECT *
FROM cliente
WHERE cliente_id BETWEEN 1 AND 20;

------------------------------ ORDER BY --------------------------------
SELECT _________ 
FROM tabela 
ORDER BY coluna (ou número da coluna) (ASC ou DESC);

-------------------------- JOINS -------------------------
juntar duas ou mais tabelas pelos IDs primários e estrangeiros

SELECT _____
FROM tabela1, tabela2
WHERE tabela1.id_tabela1 = tabela2.id_tabela1;

--mostrar o nome das pessoas que alugaram filmes e a data de aluguel

SELECT C.primeiro_nome, C.ultimo_nome, A.data_de_aluguel, A.data_de_devolucao
FROM cliente C, aluguel A
WHERE C.cliente_id = A.cliente_id;

----------------------INSERT--------------------------------
inserir dados na tabela

INSERT INTO tabela (coluna1, coluna2, coluna3)
VALUES(x, y, z),
      (x, y, z),
      (x, y, z);

-----------------------UPDATE----------------------------
atualiza dados que já estão inseridos na tabela

UPDATE tabela
SET ____________
WHERE __________;

-------------------- DELETE ---------------------------
deleta uma linha

DELETE FROM tabela
WHERE _____;

-------------------------------------- FUNÇÕES AGREGADAS ------------------------------------------------

------------------------AVG-----------------------
retorna a média da coluna selecionada

SELECT AVG(coluna) 
FROM tabela;

--média de preço de locação dos filmes

SELECT AVG(F.preco_da_locacao)
FROM filme F;

---------------------- SUM -------------------------
retorna a soma da coluna selecionada

SELECT SUM(coluna) 
FROM tabela;

--soma de preço de locação dos filmes

SELECT SUM(F.preco_da_locacao)
FROM filme F;

---------------------- MIN ------------------------
retorna o menor valor da coluna selecionada

SELECT MIN(F.preco_da_locacao)
FROM filme F;

--o menor preço de locação dos filmes

SELECT MIN(F.preco_da_locacao)
FROM filme F;

---------------------- MAX ------------------------
retorna o maior valor da coluna selecionada

SELECT MAX(F.preco_da_locacao)
FROM filme F;

--o maior preço de locação dos filmes

SELECT MAX(F.preco_da_locacao)
FROM filme F;

-------------------------- COUNT() -----------------------------------
exibe a quantidade de itens da tabela

SELECT COUNT(*)
FROM tabela;

--a quantidade de filmes na tabela filme

SELECT COUNT(*)
FROM filme;

----------------------------- GROUP BY -----------------------------
agrupa os dados iguais
usado junto com os comandos COUNT(), MAX(), MIN(), SUM(), AVG().

SELECT COUNT(*)
FROM tabela
GROUP BY coluna;

--quantidade de filmes agrupados pelo preço de locação:

SELECT COUNT(filme_id), preco_da_locacao
FROM filme
GROUP BY preco_da_locacao;

------------------------- HAVING -------------------------------
aplica uma condição ao tipo de agrupamento (group by) que será retornado

SELECT _____
FROM tabela
WHERE _____
GROUP BY _____
HAVING _____;

--mostrar as pessoas que possuem mais de 20 aluguéis

SELECT C.primeiro_nome, C.ultimo_nome, C.email, count(*) total_de_alugueis
FROM cliente C, aluguel A
WHERE A.cliente_id = C.cliente_id
GROUP BY C.primeiro_nome, C.ultimo_nome, C.email
HAVING count(*) >=20
ORDER BY count(*);


-----------------------------------------------------------------------------------------------------

----------------------------- DISTINCT -------------------------------
não trás dados repetidos

SELECT DISTINCT _____
FROM tabela
WHERE _________;

--------------------------- SUB CONSULTAS ----------------------------
é uma consulta dentro de outra consulta
sub consulta não tem order by
o select interno deve ser a mesma coluna do select externo

SELECT _____
FROM tabela
WHERE _____ = (SELECT _____ FROM _____ WHERE _____);

--exibir todos os filmes com o preço mínimo de locação

SELECT titulo, preco_da_locacao 
FROM filme
WHERE preco_da_locacao = (SELECT MIN(preco_da_locacao) FROM filme);

--retornar o endereço de todos os clientes que possuem mais de 20 aluguéis

SELECT E.* FROM endereco E 
WHERE E.endereco_id IN (SELECT C.endereco_id
FROM cliente C, aluguel A
WHERE A.cliente_id = C.cliente_id
GROUP BY C.endereco_id
HAVING count(*) >=20);

----------------------------- VIEWS ----------------------------------
cria uma "tabela" nova para facilitar a produtividade, porém piora o desempenho do banco
posso colocar sub consultas dentro da view para facilitar a leitura de querys
não consigo apagar nem inserir dados em uma view
é boa prática colocar v_ antes do nome da view

CREATE VIEW nome_view AS (SELECT _____  FROM _____ WHERE _____);

--criar uma view que exibe todos os filmes mais baratos (0.99)

CREATE VIEW v_filmes_baratos AS
SELECT F.titulo, F.descricao, F.preco_da_locacao
FROM filme F
WHERE F.preco_da_locacao = (SELECT MIN(preco_da_locacao) FROM filme);

--criar uma view que exibe o relatório de vendas anuais de cada tipo de filme
CREATE VIEW v_relatorio_anual_vendas AS

select c.nome 'Categoria', sum(f.preco_da_locacao) 'Preço da Locação'
from aluguel a, filme f, inventario i, categoria c, filme_categoria fc
where a.data_de_devolucao between "2005-01-01" and "2005-12-31"
and a.inventario_id = i.inventario_id
and f.filme_id = i.filme_id
and c.categoria_id = fc.categoria_id
and fc.filme_id = f.filme_id
group by c.nome;

-- ALTERAR UMA VIEW
apenas copia o que foi feito no create e altera para alter

ALTER VIEW v_filmes_baratos AS
SELECT F.titulo, F.descricao, F.preco_da_locacao
FROM filme F
WHERE F.preco_da_locacao = (SELECT MAX(preco_da_locacao) FROM filme);

--SUBSTITUIR UMA VIEW
coloca CREATE OR REPLACE VIEW

CREATE OR REPLACE VIEW v_filmes_baratos AS
SELECT F.titulo, F.descricao, F.preco_da_locacao
FROM filme F
WHERE F.preco_da_locacao = (SELECT MIN(preco_da_locacao) FROM filme);

--APAGAR UMA VIEW
usa o comando DROP VIEW nome_da_view;

DROP VIEW v_filmes_baratos;

--POSSO ALTERAR OU EXCLUIR DIRETO DO WORKBENCH TAMBÉM

----------------------------- FUNÇÕES --------------------------------------------------
uma função realiza comandos dentro dela e retorna algum valor
dá para criar direto pelo mySQL

DELIMITER $$ --para não dar erro, o mysql irá executar apenas quando encontrar $$ (pode ser qualquer símbolo apenas para substituir o ;, pois se deixar o ; ele irá executar até o DECLARE e dar erro)

CREATE FUNCTION nome_funcao(parâmetros)
RETURNS _____

BEGIN --mesma coisa que {

DECLARE variável tipoVariável; --declara variáveis
SET variável = _____;
RETURN variável;

END$$ --mesma coisa que }

DELIMITER ; --volta ao delimitador padrão

--EXEMPLO: criar uma função que soma dois números:

DELIMITER $$
CREATE FUNCTION soma(n1 decimal(8,2), n2 decimal(8,2))
RETURNS decimal(8,2)

BEGIN

DECLARE total decimal(8,2);
SET total = n1 + n2;
RETURN total;

END$$

--usar a função:

SELECT soma(x, y);

--criar uma função que passa o id do filme e retorna seu nome:

DELIMITER $$
CREATE FUNCTION `nome_filme`(id integer) RETURNS varchar(200)
BEGIN

declare nome varchar(200);
select F.titulo into nome from filme F where filme_id = id; --INTO joga o resulltado na variável declarada, possibilitando retorno

RETURN nome;
END$$
DELIMITER ;

-- ALTERAR UMA FUNÇÃO: 
-- botão direito na função > alter function
-- ou apaga e cria novamente, fazendo as alterações na criação

--DELETAR UMA FUNÇÃO:
-- botão direito na função > drop function
-- ou DROP FUNCTION nome_funcao;
