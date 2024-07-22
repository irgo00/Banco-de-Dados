--LISTAR TODOS OS FILMES PELA DESCRIÇÃO DOS FILMES ORDEM ALFABÉTICA:

SELECT *
FROM filme
ORDER BY descricao ASC;

--LOCALIZAR TODOS OS FILMES DA LOCADORA COM O GÊNERO DE AÇÃO:

SELECT F.titulo, C.nome
FROM filme F, categoria C, filme_categoria FC
WHERE F.filme_id = FC.filme_id 
AND C.categoria_id = FC.categoria_id 
AND C.categoria_id = 1;

--LOCALIZAR O ÚLTIMO FILME ALUGADO NA LOCADORA

SELECT F.titulo, A.data_de_aluguel, I.inventario_id
FROM aluguel A, filme F, inventario I
WHERE A.inventario_id = I.inventario_id
AND I.filme_id = F.filme_id
ORDER BY data_de_aluguel DESC;

--INSERIR UM NOVO FILME NA TABELA FILME:

INSERT INTO filme (filme_id, titulo, descricao, ano_de_lancamento, idioma_id, idioma_original_id, duracao_da_locacao, preco_da_locacao, duracao_do_filme, custo_de_substituicao, classificacao, recursos_especiais, ultima_atualizacao) 
VALUES (1001, 'The Godfather', 'História de Mafiosos', 1972, 1, 2, 3, 4.99, 180, 18.99, 'NC-17', 'Deleted Scenes', '2024-07-18 17:19:25');

--FAZER UM DASHBOARD COM O TOTAL DE VENDAS DO ANO E DO MÊS DA LOCADORA