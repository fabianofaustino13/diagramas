USE DB_LOJA;

SELECT * FROM TB_DEPARTAMENTOS;

-- QUESTÃO 01
SELECT 
	DEP_NOME AS 'NOME', DEP_DESCONTO AS 'DESCONTO (%)'
    FROM TB_DEPARTAMENTOS
    WHERE DEP_DESCONTO > 0;

USE DB_LOJA;

SELECT * FROM TB_PRODUTOS;

-- QUESTÃO 02
SELECT 
	PRO_DESCRICAO AS 'DESCRIÇÃO',
    PRO_PRECO AS 'VALOR PARA VENDA',
    PRO_QUANTIDADE_ESTOQUE AS 'QUANTIDADE EM ESTOQUE'
    FROM TB_PRODUTOS;

-- QUESTÃO 03
SELECT 
	PRO_DESCRICAO AS 'DECRIÇÃO',
    PRO_PRECO AS 'VALOR PARA VENDA',
    PRO_QUANTIDADE_ESTOQUE AS 'QUANTIDADE EM ESTOQUE',
    PRO_QUANTIDADE_MINIMA AS 'VALOR MÍNIMO EM ESTOQUE'
    FROM TB_PRODUTOS
    WHERE PRO_QUANTIDADE_ESTOQUE <= PRO_QUANTIDADE_MINIMA;
    
-- QUESTÃO 04
SELECT 
	PRO_DESCRICAO AS 'DECRIÇÃO',
    PRO_PRECO AS 'VALOR PARA VENDA',
    PRO_QUANTIDADE_ESTOQUE AS 'QUANTIDADE EM ESTOQUE',
    PRO_QUANTIDADE_MINIMA AS 'VALOR MÍNIMO EM ESTOQUE'
    FROM TB_PRODUTOS
    WHERE PRO_QUANTIDADE_ESTOQUE > PRO_QUANTIDADE_MINIMA;
    
USE DB_LOJA;

SELECT * FROM TB_VENDEDORES;

-- QUESTÃO 05
SELECT 
	VEN_MATRICULA AS 'MATRÍCULA',
    VEN_NOME AS 'NOME',
    VEN_DATA_ADMISSAO AS 'ADMISSÃO EM'
    FROM TB_VENDEDORES
    WHERE FK_VEN_SEX = (SELECT PK_SEX FROM TB_SEXOS WHERE SEX_NOME = 'FEMININO');

-- QUESTÃO 06    
SELECT 
	VEN_MATRICULA AS 'MATRÍCULA',
    VEN_NOME AS 'NOME',
    VEN_DATA_ADMISSAO AS 'ADMITIDO EM'
    FROM TB_VENDEDORES
    WHERE FK_VEN_SEX = (SELECT PK_SEX FROM TB_SEXOS WHERE SEX_NOME = 'MASCULINO') AND VEN_DATA_ADMISSAO BETWEEN '2001-01-01' AND '2008-12-31';
    
USE DB_LOJA;

-- QUESTÃO 07
SELECT 
	PFC_NOME AS 'NOME'
    FROM TB_CLIENTES_PESSOAS_FISICAS
    WHERE PFC_NOME LIKE '%SANTOS%';
    
USE DB_LOJA;

SELECT * FROM TB_PRODUTOS;

-- QUESTÃO 08
SELECT 
	PRO_DESCRICAO AS 'DESCRIÇAO DO PRODUTO',
    PRO_PRECO AS 'PREÇO'
    FROM TB_PRODUTOS
    ORDER BY PRO_PRECO ASC LIMIT 2;

-- QUESTÃO 09
SELECT 
	PRO_DESCRICAO AS 'DESCRIÇAO DO PRODUTO',
    PRO_PRECO AS 'PREÇO'
    FROM TB_PRODUTOS
    ORDER BY PRO_PRECO DESC LIMIT 2;
    
USE DB_LOJA;

SELECT * FROM TB_VENDEDORES;

-- QUESTÃO 10
SELECT 
	VEN_MATRICULA AS 'MATRÍCULA',
    VEN_DATA_ADMISSAO AS 'ADMITIDO EM'
    FROM TB_VENDEDORES
    ORDER BY VEN_DATA_ADMISSAO ASC LIMIT 3;

USE DB_LOJA;

/*SELECT 
    CAMPOS
FROM
    TABELAS
        JOIN
    TB_CLIENTES ON PK_BAIRRO = FK_CLI_BAI
        JOIN
    TB_SEXOS ON PK_SEX = FK_CLI_SEX
WHERE 
	CLI_NOME LIKE '%FAUSTINO%'
ORDER BY 
	CLI_NOME ASC;
*/

USE DB_LOJA;

-- 1) Nome  do departamento, descrição do produto, valor de venda e desconto de todos os produtos com estoque acima do mínimo, por ordem de nome do departamento.

SELECT 
    DEP_NOME, PRO_DESCRICAO, PRO_PRECO, DEP_DESCONTO
FROM
    TB_PRODUTOS
        JOIN
    TB_DEPARTAMENTOS ON PK_DEP = FK_PRO_DEP
WHERE 
	PRO_QUANTIDADE_ESTOQUE > PRO_QUANTIDADE_MINIMA
ORDER BY 
	DEP_NOME ASC;
    
    
USE DB_LOJA;

-- 2) Nome  do departamento, descrição do produto, valor de venda, desconto de todos os produtos do departamento de calçados.

SELECT 
    DEP_NOME, PRO_DESCRICAO, PRO_PRECO, DEP_DESCONTO
FROM
    TB_PRODUTOS
        JOIN
    TB_DEPARTAMENTOS ON PK_DEP = FK_PRO_DEP
WHERE 
	DEP_NOME = 'FUTEBOL';
    

USE DB_LOJA;

-- 3) Nome e telefone de todos os clientes dos bairros TIROL, ALECRIM, ou RIBEIRA, por ordem de nome do cliente.
  
SELECT 
    PFC_NOME AS 'NOME', 
    FPF_FONE AS 'TELEFONE',
    TDF_NOME AS 'TIPO DE TELEFONE'
FROM
    TB_BAIRROS
		JOIN
	TB_CEPS ON FK_BAI_CEP = PK_BAI
		JOIN
	TB_CLIENTES ON FK_CLI_CEP = PK_CEP
		JOIN
	TB_CLIENTES_PESSOAS_FISICAS ON FK_PFC_CLI = PK_CLI
		JOIN 
	TB_FONE_PESSOAS_FISICAS ON FK_FPF_PFC = PK_PFC
		JOIN
	TB_TIPOS_FONES ON PK_TDF = FK_FPF_TDF
WHERE BAI_NOME IN ('LAGOA NOVA', 'PETROPOLIS') -- (BAI_NOME LIKE 'LAGOA NOVA') OR (BAI_NOME LIKE 'PETROPOLIS')
ORDER BY PFC_NOME ASC;


USE DB_LOJA;

-- 4) Nome e telefone de todos os fornecedores das cidades NATAL ou  PARNAMIRIM, por ordem de nome do fornecedor.
  
SELECT 
    FOR_RAZAO_SOCIAL AS 'NOME', 
    FDF_FONE AS 'TELEFONE',
    TDF_NOME AS 'TIPO DE TELEFONE'
FROM
    TB_BAIRROS
		JOIN
	TB_CEPS ON FK_BAI_CEP = PK_BAI
		JOIN
	TB_FORNECEDORES ON FK_FOR_CEP = PK_CEP
		JOIN
	TB_FONE_FORNECEDORES ON FK_FDF_FOR = PK_FOR
		JOIN
	TB_TIPOS_FONES ON PK_TDF = FK_FDF_TDF
WHERE BAI_NOME IN ('PONTA NEGRA', 'CANDELÁRIA') -- (BAI_NOME LIKE 'PONTA NEGRA') OR (BAI_NOME LIKE 'CANDELARIA')
ORDER BY FOR_RAZAO_SOCIAL ASC;

USE DB_LOJA;

-- 5) Nota fiscal, data, descrição das formas de pagamento e nome do vendedor de todas as vendas já realizadas.   

SELECT 
	VEN_NOME AS 'NOME DO VENDEDOR',
    VDS_DATA AS 'DATA',
    VDS_NF AS 'NOTA FISCAL',
    FDP_FORMA AS 'FORMA DE PAGAMENTO'
FROM
    TB_VENDEDORES
		JOIN
	TB_VENDAS ON FK_VDS_VEN = PK_VEN
		JOIN
	TB_PAGAMENTOS_VENDAS ON FK_PDV_VDS = PK_VDS
		JOIN
	TB_FORMAS_PAGAMENTOS ON PK_FDP = FK_PDV_FDP;


USE DB_LOJA;

-- 6) Nota fiscal, data, descrição das formas de pagamento e nome do vendedor de todas as vendas realizadas no mês de maio de 2017.

SELECT 
	VEN_NOME AS 'NOME DO VENDEDOR',
    VDS_DATA AS 'DATA',
    VDS_NF AS 'NOTA FISCAL',
    FDP_FORMA AS 'FORMA DE PAGAMENTO'
FROM
    TB_VENDEDORES
		JOIN
	TB_VENDAS ON FK_VDS_VEN = PK_VEN
		JOIN
	TB_PAGAMENTOS_VENDAS ON FK_PDV_VDS = PK_VDS
		JOIN
	TB_FORMAS_PAGAMENTOS ON PK_FDP = FK_PDV_FDP
-- WHERE VDS_DATA BETWEEN 20170501 AND 20170531;
WHERE VDS_DATA LIKE '2017-05-%';


USE DB_LOJA;

-- 7) O nome e departamento de todos os produtos que foram comprados pela loja em março de 2012 (elimine eventuais repetições).

SELECT DISTINCT
	PRO_NOME AS 'NOME DO PRODUTO', 
    DEP_NOME AS 'DEPARTAMENTO'
FROM 
	TB_PRODUTOS
		JOIN
	TB_DEPARTAMENTOS ON FK_PRO_DEP = PK_DEP
		JOIN
	TB_ITENS_COMPRAS ON FK_IDC_PRO = PK_PRO
		JOIN
	TB_COMPRAS ON PK_COM = FK_IDC_COM
-- WHERE COM_DATA BETWEEN 20151001 AND 20151031;
WHERE COM_DATA LIKE '2015-10-%';

USE DB_LOJA;

-- 8) O nome e o departamento de todos os produtos que foram vendidos por um determinado departamento. 

SELECT 
	PRO_NOME AS 'NOME DO PRODUTO',
    DEP_NOME AS 'DEPARTAMENTO',
    VDS_DATA AS 'DATA DA VENDA'
FROM 
	TB_PRODUTOS
		JOIN
	TB_DEPARTAMENTOS ON FK_PRO_DEP = PK_DEP
		JOIN
	TB_ITENS_VENDAS ON FK_IDV_PRO = PK_PRO
		JOIN
	TB_VENDAS ON PK_VDS = FK_IDV_VDS
WHERE DEP_NOME LIKE 'FUTEBOL';


USE DB_LOJA;
	
-- 9) O nome e o departamento de todos  os produtos que foram vendidos por um determinado vendedor no primeiro semestre de  2012 (elimine eventuais repetições).

SELECT
	VEN_NOME AS 'VENDEDOR',
	PRO_NOME AS 'NOME DO PRODUTO',
    DEP_NOME AS 'DEPARTAMENTO',
    VDS_DATA AS 'DATA DA VENDA'
FROM 
	TB_PRODUTOS
		JOIN
	TB_DEPARTAMENTOS ON FK_PRO_DEP = PK_DEP
		JOIN
	TB_ITENS_VENDAS ON FK_IDV_PRO = PK_PRO
		JOIN
	TB_VENDAS ON PK_VDS = FK_IDV_VDS
		JOIN
	TB_VENDEDORES ON PK_VEN = FK_VDS_VEN
WHERE (VDS_DATA BETWEEN 20170101 AND 20170631) AND VEN_NOME LIKE '%ANA%';

-- #########################################################
-- CONSULTA EM 2 TABELAS QUE NÃO POSSUEM LIGAÇÕES

USE DB_LOJA;

SELECT
	*
FROM
	(SELECT 
		*
	FROM 
		TB_CIDADES
			LEFT JOIN
		TB_ESTADOS ON PK_EST = FK_EST_CID
	UNION
	SELECT 
		*
	FROM TB_CIDADES
			RIGHT JOIN
		TB_ESTADOS ON PK_EST = FK_EST_CID) AS R
	WHERE R.PK_CID IS NULL OR R.PK_EST IS NULL;
-- #########################################################

USE DB_LOJA;
-- 10) O nome  dos vendedores que nunca venderam nenhum produto.

SELECT
	*
FROM 
	TB_VENDAS
		RIGHT JOIN
	TB_VENDEDORES ON PK_VEN = FK_VDS_VEN
WHERE FK_VDS_VEN IS NULL;


-- #################################################################
-- 								LISTA 3
-- #################################################################

-- 1) Nome de todas as cidades e, se existirem, seus respectivos bairros.

USE DB_LOJA;

SELECT 
	CID_NOME
FROM
	TB_CIDADES
		LEFT JOIN
	TB_BAIRROS ON FK_BAI_CID = PK_CID;

-- 2) Nome de todas as cidades sem nenhum bairro cadastrado.

USE DB_LOJA;

SELECT 
	CID_NOME
FROM
	TB_CIDADES
		LEFT JOIN
	TB_BAIRROS ON FK_BAI_CID = PK_CID
WHERE PK_BAI IS NULL;

-- 3) Nome de todas as marcas sem nenhum produto cadastrado.

USE DB_LOJA;

SELECT 
	MAR_NOME
FROM
	TB_MARCAS
		LEFT JOIN
	TB_PRODUTOS ON FK_PRO_MAR = PK_MAR
WHERE PK_PRO IS NULL;

-- 4) Nome de todos os produtos que não tiveram nenhuma unidade vendida.

USE DB_LOJA;

SELECT 
	PRO_NOME
FROM
	TB_PRODUTOS
		LEFT JOIN
	TB_ITENS_VENDAS ON FK_IDV_PRO = PK_PRO
WHERE FK_IDV_PRO IS NULL;

-- 5) Nome e fone de todos os vendedores que não venderam nada.

USE DB_LOJA;

SELECT 
	VEN_NOME AS 'NOME DO VENDEDOR',
    FDV_FONE AS 'TELEFONE'
FROM
	TB_VENDEDORES
		LEFT JOIN
	TB_VENDAS ON FK_VDS_VEN = PK_VEN
		JOIN
	TB_FONE_VENDEDORES ON FK_FDV_VEN = PK_VEN
WHERE PK_VDS IS NULL;

-- 6) Nome dos clientes, pessoa física, sem telefone cadastrado.

USE DB_LOJA;

SELECT 
	PFC_NOME
FROM
	TB_CLIENTES
		JOIN
	TB_CLIENTES_PESSOAS_FISICAS ON FK_PFC_CLI = PK_CLI
		LEFT JOIN
	TB_FONE_PESSOAS_FISICAS ON FK_FPF_PFC = PK_PFC
WHERE FK_FPF_PFC IS NULL;

-- 7) Nome e fone de todos os fornecedores que já forneceram produtos.

USE DB_LOJA;

SELECT DISTINCT
	FOR_RAZAO_SOCIAL AS 'NOME DO FORNECEDOR',
    FDF_FONE AS 'TELEFONE'
FROM
	TB_FORNECEDORES
		JOIN
	TB_COMPRAS ON FK_COM_FOR = PK_FOR
		JOIN
	TB_ITENS_COMPRAS ON FK_IDC_COM = PK_COM
		JOIN
	TB_PRODUTOS ON PK_PRO = FK_IDC_PRO
		JOIN
	TB_FONE_FORNECEDORES ON FK_FDF_FOR = PK_FOR;
    
-- 8) Nome e fone de todos os fornecedores que nunca forneceram.

USE DB_LOJA;

SELECT
	FOR_RAZAO_SOCIAL AS 'NOME DO FORNECEDOR',
	FDF_FONE AS 'TELEFONE'
FROM
	TB_FORNECEDORES
		JOIN
	TB_COMPRAS ON FK_COM_FOR = PK_FOR
		LEFT JOIN
	TB_ITENS_COMPRAS ON FK_IDC_COM = PK_COM
		JOIN
	TB_FONE_FORNECEDORES ON FK_FDF_FOR = PK_FOR   
WHERE FK_IDC_COM IS NULL;

-- #################################################################
-- 								LISTA 4
-- #################################################################

-- 1) Nome do departamento e a quantidade de produtos associados a cada departamento.

USE DB_LOJA;

SELECT 
	DEP_NOME AS 'DEPARTAMENTOS',
    COUNT(DEP_NOME) AS 'TOTAL DE PRODUTOS'
FROM
	TB_PRODUTOS
		JOIN
	TB_DEPARTAMENTOS ON PK_DEP = FK_PRO_DEP
GROUP BY DEP_NOME;

-- 2) Nome do cliente e a quantidade de telefones cadastrados para cada cliente,  apenas para clientes com mais de um telefone.

USE DB_LOJA;

SELECT 
	PFC_NOME AS 'PESSOA FÍSICA',
	COUNT(PFC_NOME) AS 'TOTAL DE TELEFONE'
FROM
	TB_CLIENTES
		LEFT JOIN
	 TB_CLIENTES_PESSOAS_FISICAS ON FK_PFC_CLI = PK_CLI
	 	JOIN
	 TB_FONE_PESSOAS_FISICAS ON FK_FPF_PFC = PK_PFC
GROUP BY PFC_NOME
HAVING COUNT(PFC_NOME) > 1;

-- 3) Quantidade de unidades vendidas e total arrecadado por cada marca.

USE DB_LOJA;

SELECT 
    MAR_NOME AS 'MARCA',
    PRO_PRECO AS 'PREÇO UNITÁRIO',
    SUM(IDV_QUANTIDADE) AS 'TOTAL DE UNIDADE VENDIDO',
    IDV_PRECO AS 'TOTAL POR MARCA'
FROM 
	TB_MARCAS
		JOIN
	TB_PRODUTOS ON FK_PRO_MAR = PK_MAR
		JOIN
	TB_ITENS_VENDAS ON FK_IDV_PRO = PK_PRO
GROUP BY PK_MAR;

-- 4) Nome do fornecedor e o total gasto em compras, pela loja, com cada fornecedor em 2012.

USE DB_LOJA;

SELECT 
	FOR_RAZAO_SOCIAL AS 'FORNECEDOR',
    SUM(COM_PRECO) AS 'TOTAL COMPRA',
    COM_DATA AS 'DATA DA COMPRA'
FROM
	TB_FORNECEDORES
		JOIN
	TB_COMPRAS ON FK_COM_FOR = PK_FOR
WHERE COM_DATA LIKE '2015-%'
GROUP BY FOR_RAZAO_SOCIAL;

-- 5) Descrição do produto, total de unidades vendidas e total arrecadado por produto em junho de 2012.

USE DB_LOJA;

SELECT 
	PRO_NOME AS 'PRODUTO',
    VDS_DATA AS 'DATA',
    IDV_QUANTIDADE 'QUANTIDADE VENDIDA',
    IDV_PRECO 'R$'
FROM
	TB_PRODUTOS
		JOIN
	TB_ITENS_VENDAS ON FK_IDV_PRO = PK_PRO
		JOIN
	TB_VENDAS ON PK_VDS = FK_IDV_VDS
WHERE VDS_DATA LIKE '2017-05-%'
GROUP BY PRO_NOME;

-- 6) Nome do cliente, quantidade de produtos vendidos e total arrecadadopor cliente em no 1º semestre de 2012,apenas para os cliente sque renderam mais de R$ 100,00 em vendas.

USE DB_LOJA;

SELECT 
	PFC_NOME AS 'CLIENTE',
	IDV_QUANTIDADE 'QUANTIDADE VENDIDA',   
    IDV_PRECO AS 'R$'
    
FROM
	TB_CLIENTES
		JOIN
	TB_CLIENTES_PESSOAS_FISICAS ON FK_PFC_CLI = PK_CLI
		JOIN
	TB_VENDAS ON FK_VDS_CLI = PK_CLI
		JOIN
	TB_ITENS_VENDAS ON FK_IDV_VDS = PK_VDS
WHERE VDS_DATA BETWEEN '2017-07-01' AND '2017-12-31'
GROUP BY PFC_NOME
HAVING IDV_PRECO <= 3000;

-- 7) Descrição do produto, total de unidades compradas e total gasto por produto em março de 2012,apenas para produtos do departamento de calçados.

USE DB_LOJA;

SELECT 
	DEP_NOME AS 'DEPARTAMENTO',
    PRO_DESCRICAO AS 'DESCRIÇÃO',
    IDC_PRECO AS 'PREÇO UNITÁRIO',
    SUM(IDC_QUANTIDADE) AS 'TOTAL DE UNIDADE COMPRADA',
    SUM(IDC_PRECO) * SUM(IDC_QUANTIDADE)AS 'INVESTIMENTO',
    COM_DATA
FROM 
	TB_DEPARTAMENTOS
		JOIN
	TB_PRODUTOS ON FK_PRO_DEP = PK_DEP
		JOIN
	TB_ITENS_COMPRAS ON FK_IDC_PRO = PK_PRO
		JOIN
	TB_COMPRAS ON PK_COM = FK_IDC_COM
WHERE COM_DATA LIKE '2017%'
GROUP BY PK_DEP;

-- 8) Descrição  do produto, departamento do produto, totalde unidades vendidas e total arrecadado por produto no primeiro semestre 2012,  apenas para produtos com os quais se arrecadou mais de R$ 500,00. 

USE DB_LOJA;

SELECT 
	PRO_NOME AS 'PRODUTO',
    VDS_DATA AS 'DATA',
    IDV_QUANTIDADE 'QUANTIDADE VENDIDA',
    IDV_PRECO 'R$'
FROM
	TB_PRODUTOS
		JOIN
	TB_ITENS_VENDAS ON FK_IDV_PRO = PK_PRO
		JOIN
	TB_VENDAS ON PK_VDS = FK_IDV_VDS
WHERE VDS_DATA LIKE '2017-05-%'
GROUP BY PRO_NOME;

USE DB_LOJA;

SELECT * FROM TB_FUNCIONARIOS
