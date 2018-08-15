CREATE DATABASE IF NOT EXISTS DB_LOJA;

USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_SEXOS(
	PK_SEX TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    SEX_NOME VARCHAR(15) NOT NULL,
    SEX_SIGLA CHAR(3) NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_SEX)
);

INSERT INTO TB_SEXOS
	(SEX_NOME, SEX_SIGLA) 
VALUES
	('MASCULINO','MASC'),
    ('FEMININO','FEM');

USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_ESTADOS(
	PK_EST TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    EST_NOME VARCHAR(25) NOT NULL,
    EST_SIGLA VARCHAR(2) NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_EST)
);

INSERT INTO TB_ESTADOS 
	(EST_NOME, EST_SIGLA) 
VALUES 
	('ACRE', 'AC'),
	('ALAGOAS', 'AL'),
	('AMAPÁ', 'AP'),
	('AMAZONAS', 'AM'),
	('BAHIA', 'BA'),
	('CEARÁ', 'CE'),
	('DISTRITO FEDERAL', 'DF'),
	('ESPÍRITO SANTO', 'ES'),
	('GOIÁS', 'GO'),
	('MARANHÃO', 'MA'),
	('MATO GROSSO', 'MT'),
	('MATO GROSSO DO SUL', 'MS'),
	('MINAS GERAIS', 'MG'),
	('PARÁ', 'PA'),
	('PARAÍBA', 'PB'),
	('PARANÁ', 'PR'),
	('PERNAMBUCO', 'PE'),
	('PIAUÍ', 'PI'),
	('RIO DE JANEIRO', 'RJ'),
	('RIO GRANDE DO NORTE', 'RN'),
	('RIO GRANDE DO SUL', 'RS'),
	('RONDÔNIA', 'RO'),
	('RORAIMA', 'RR'),
	('SANTA CATARINA', 'SC'),
	('SÃO PAULO', 'SP'),
	('SERGIPE', 'SE') ,
	('TOCANTINS', 'TO');
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_CIDADES(
	PK_CID SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    CID_NOME VARCHAR(25) NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_CID)
);

INSERT INTO TB_CIDADES 
	(CID_NOME) 
VALUES 
	('NATAL'),
    ('SANTANA DO ARAGUAIA'),
    ('PALMAS'),
    ('FORTALEZA'),
    ('MOSSORÓ'),
    ('SANTA CRUZ'),
    ('SÃO TOMÉ'),
    ('GOIÂNIA');
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_BAIRROS(
	PK_BAI SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    BAI_NOME VARCHAR(25) NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_BAI)
);

INSERT INTO TB_BAIRROS 
	(BAI_NOME) 
VALUES 
	('LAGOA NOVA'),
    ('PETROPOLIS'),
    ('CANDELÁRIA'),
    ('PONTA NEGRA'),
    ('CIDADE ALTA'),
    ('CENTRO'),
    ('TIROL'),
    ('ALECRIM');
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_CLIENTES(
	PK_CLI INT UNSIGNED NOT NULL AUTO_INCREMENT,
    CLI_LOGRADOURO VARCHAR(25),
    CLI_COMPLEMENTO VARCHAR(25),
    CLI_NUMERO VARCHAR(10),
    CLI_CEP VARCHAR(8),
    FK_CLI_BAI SMALLINT UNSIGNED NOT NULL,
    FK_CLI_CID SMALLINT UNSIGNED NOT NULL,
    FK_CLI_EST TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_CLI),
    CONSTRAINT FK_BAI_CLI FOREIGN KEY(FK_CLI_BAI) REFERENCES TB_BAIRROS(PK_BAI),
    CONSTRAINT FK_CID_CLI FOREIGN KEY(FK_CLI_CID) REFERENCES TB_CIDADES(PK_CID),
    CONSTRAINT FK_EST_CLI FOREIGN KEY(FK_CLI_EST) REFERENCES TB_ESTADOS(PK_EST)
);

INSERT INTO TB_CLIENTES 
	(CLI_LOGRADOURO, CLI_NUMERO, CLI_COMPLEMENTO, FK_CLI_BAI, FK_CLI_CID, FK_CLI_EST, CLI_CEP) 
VALUES
	('RUA MORAIS NAVARRO', 55, 'NICE 705', 1, 1, 20, 59075770),
    ('RUA CARLOS RIBEIRO','', '', 6, 2, 14, 68560000),
    ('AVENIDA JOSÉ MENDONÇA','', '', 6, 2, 14, 68560000);

USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_CLIENTES_PESSOAS_FISICAS(
    PK_PFC INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PFC_NOME VARCHAR(80) NOT NULL,
    PFC_CPF VARCHAR(11) NOT NULL,
    PFC_DATA_NASCIMENTO DATE,
    PFC_RG VARCHAR(15),
    FK_PFC_SEX TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_PFC),
    CONSTRAINT UNIQUE KEY (PFC_CPF),
    CONSTRAINT FK_SEX_PFC FOREIGN KEY(FK_PFC_SEX) REFERENCES TB_SEXOS(PK_SEX)
);

INSERT INTO TB_CLIENTES_PESSOAS_FISICAS
	(PFC_NOME, PFC_CPF, FK_PFC_SEX) 
VALUES
	('CARLA AGUIAR FALCÃO', '93120567353', 2),
    ('FABIANO FAUSTINO DE OLIVEIRA', '69628459287', 1),
    ('CONCEIÇÃO AGUIAR', '11111111111', 2),
    ('LUZINEIDA FAUSTINO DE OLIVEIRA', '22222222222', 2),
    ('JOSÉ FAUSTINO DE OLIVEIRA', '33333333333', 1);

USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_PESSOAS_FISICAS_ENDERECOS(
	FK_PFE_CLI INT UNSIGNED NOT NULL,
    FK_PFE_PFC INT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_PFE_CLI, FK_PFE_PFC),
    CONSTRAINT FK_CLI_PFE FOREIGN KEY(FK_PFE_CLI) REFERENCES TB_CLIENTES(PK_CLI),
	CONSTRAINT FK_PFC_PFE FOREIGN KEY(FK_PFE_PFC) REFERENCES TB_CLIENTES_PESSOAS_FISICAS(PK_PFC)
);

INSERT INTO TB_PESSOAS_FISICAS_ENDERECOS 
	(FK_PFE_PFC, FK_PFE_CLI)
VALUES 
	(1,1),
    (2,1),
    (3,1),
    (4,3),
    (5,3);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_CLIENTES_PESSOAS_JURIDICAS(
    PK_PJC INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PJC_RAZAO_SOCIAL VARCHAR(80) NOT NULL,
    PJC_CNPJ VARCHAR(14) NOT NULL,
    PJC_DATA_ABERTURA DATE,
    PJC_INSCRICAO_MUNICIPAL VARCHAR(15),
    PJC_INSCRICAO_ESTADIAL VARCHAR(15),
    CONSTRAINT PRIMARY KEY(PK_PJC),
    CONSTRAINT UNIQUE KEY (PJC_CNPJ)
);

INSERT INTO TB_CLIENTES_PESSOAS_JURIDICAS
	(PJC_RAZAO_SOCIAL, PJC_CNPJ) 
VALUES
	('FALU MODAS', '11111111111111'),
    ('BQD PUBLICIDADES', '22222222222222'),
    ('LUCIANO ÁUDIOS E VÍDEOS', '33333333333333');
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_PESSOAS_JURIDICAS_ENDERECOS(
	FK_PJE_CLI INT UNSIGNED NOT NULL,
    FK_PJE_PJC INT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_PJE_CLI, FK_PJE_PJC),
    CONSTRAINT FK_CLI_PJE FOREIGN KEY(FK_PJE_CLI) REFERENCES TB_CLIENTES(PK_CLI),
	CONSTRAINT FK_PJC_PJE FOREIGN KEY(FK_PJE_PJC) REFERENCES TB_CLIENTES_PESSOAS_JURIDICAS(PK_PJC)
);

INSERT INTO TB_PESSOAS_JURIDICAS_ENDERECOS 
	(FK_PJE_PJC, FK_PJE_CLI)
VALUES 
	(1,2),
    (2,3),
    (3,3);

USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_FONE_PESSOAS_FISICAS(
	FK_FPF_PFC INT UNSIGNED NOT NULL,
    FPF_FONE VARCHAR(12) NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_FPF_PFC, FPF_FONE),
    CONSTRAINT FK_PFC_FPF FOREIGN KEY(FK_FPF_PFC) REFERENCES TB_CLIENTES_PESSOAS_FISICAS(PK_PFC)
);

INSERT INTO TB_FONE_PESSOAS_FISICAS 
	(FK_FPF_PFC, FPF_FONE) 
VALUES 
	(1, 84999215689), (1, 84991143397),
    (2, 84991143397),
    (3, 9434313434), (3, 94991878569),
    (4, 9434311698), (4, 94991865941),
    (5, 85999553635);

USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_FONE_PESSOAS_JURIDICA(
	FK_FPJ_PJC INT UNSIGNED NOT NULL,
    FPJ_FONE VARCHAR(12) NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_FPJ_PJC, FPJ_FONE),
    CONSTRAINT FK_PJC_FPJ FOREIGN KEY(FK_FPJ_PJC) REFERENCES TB_CLIENTES_PESSOAS_JURIDICAS(PK_PJC)
);

INSERT INTO TB_FONE_PESSOAS_JURIDICA 
	(FK_FPJ_PJC, FPJ_FONE) 
VALUES 
	(1, 9434313434), (1, 94991878569),
    (2, 9434311698), (2, 94991865941),
    (3, 94991885773);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_FORNECEDORES(
	PK_FOR INT UNSIGNED NOT NULL AUTO_INCREMENT,
    FOR_RAZAO_SOCIAL VARCHAR(25) NOT NULL,
    FOR_CNPJ VARCHAR(14) NOT NULL,
    FOR_LOGRADOURO VARCHAR(25),
    FOR_NUMERO VARCHAR(10),
    FOR_COMPLEMENTO VARCHAR(25),
    FOR_INSCRICAO_MUNICIPAL VARCHAR(14),
    FOR_INSCRICAO_ESTADUAL VARCHAR(14),
    FOR_WEBSITE VARCHAR(25),
    FK_FOR_BAI SMALLINT UNSIGNED NOT NULL,
    FK_FOR_CID SMALLINT UNSIGNED NOT NULL,
    FK_FOR_EST TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_FOR),
    CONSTRAINT UNIQUE KEY(FOR_CNPJ),
    CONSTRAINT FK_BAI_FOR FOREIGN KEY(FK_FOR_BAI) REFERENCES TB_BAIRROS(PK_BAI),
    CONSTRAINT FK_CID_FOR FOREIGN KEY(FK_FOR_CID) REFERENCES TB_CIDADES(PK_CID),
    CONSTRAINT FK_EST_FOR FOREIGN KEY(FK_FOR_EST) REFERENCES TB_ESTADOS(PK_EST)
);

INSERT INTO TB_FORNECEDORES 
	(FOR_CNPJ, FOR_RAZAO_SOCIAL, FOR_LOGRADOURO, FOR_NUMERO, FOR_COMPLEMENTO, FK_FOR_BAI, FK_FOR_CID, FK_FOR_EST) 
VALUES 
	('11111111111111','TECNO TESTE', 'AV. SENADOR SALGADO FILHO', '', '', 7, 1, 20),
    ('22222222222222','AGUA E GELO', 'AV. HERMES DA FONSECA', '', '', 7, 1, 20),
    ('33333333333333','MMTGAP NET', 'RUA MOSSORÓ', '', '', 7, 1, 20);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_FONE_FORNECEDORES(
	FK_FDF_FOR INT UNSIGNED NOT NULL,
    FDF_FONE VARCHAR(12) NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_FDF_FOR, FDF_FONE),
    CONSTRAINT FK_FOR_FDF FOREIGN KEY(FK_FDF_FOR) REFERENCES TB_FORNECEDORES(PK_FOR)
);

INSERT INTO TB_FONE_FORNECEDORES
	(FK_FDF_FOR, FDF_FONE) 
VALUES 
	(1, 8411112222),
    (2, 8422221111),
    (3, 8433333333);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_COMPRAS(
	PK_COM INT UNSIGNED NOT NULL AUTO_INCREMENT,
    COM_DATA DATE,
    COM_VALOR_COMPRA DECIMAL(6,2),
    FK_COM_FOR INT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_COM, FK_COM_FOR),
    CONSTRAINT FK_FOR_COM FOREIGN KEY(FK_COM_FOR) REFERENCES TB_FORNECEDORES(PK_FOR)
);

INSERT INTO TB_COMPRAS 
	(FK_COM_FOR, COM_DATA, COM_VALOR_COMPRA) 
VALUES 
	(1, 20151002, 1500.00),
    (1, 20160102, 2500.00),
    (2, 20170707, 500.00),
    (3, 20180505, 5500.00);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_MARCAS(
	PK_MAR SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    MAR_NOME VARCHAR(25) NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_MAR)
);

INSERT INTO TB_MARCAS 
	(MAR_NOME) 
VALUES 
	('MIKASA'),
    ('MIZUNO'),
    ('NIKE'),
    ('ADIDAS');
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_DEPARTAMENTOS(
	PK_DEP SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    DEP_NOME VARCHAR(25) NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_DEP)
);

ALTER TABLE TB_DEPARTAMENTOS
ADD COLUMN DEP_DESCONTO DOUBLE;

INSERT INTO TB_DEPARTAMENTOS 
	(DEP_NOME) 
VALUES 
	('VÔLEI'),
    ('FUTEBOL'),
    ('ATLETISMO'),
    ('NATAÇÃO');
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_PRODUTOS(
	PK_PRO INT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRO_NOME VARCHAR(25) NOT NULL,
    PRO_PRECO DECIMAL(6,2) NOT NULL,
    PRO_DESCRICAO VARCHAR(200),
    PRO_QUANTIDADE_MINIMA SMALLINT UNSIGNED,
    PRO_QUANTIDADE_ESTOQUE SMALLINT UNSIGNED,
    FK_PRO_MAR SMALLINT UNSIGNED NOT NULL,
    FK_PRO_DEP SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_PRO),
    CONSTRAINT FK_MAR_PRO FOREIGN KEY(FK_PRO_MAR) REFERENCES TB_MARCAS(PK_MAR),
    CONSTRAINT FK_DEP_PRO FOREIGN KEY(FK_PRO_DEP) REFERENCES TB_DEPARTAMENTOS(PK_DEP)
);

-- ALTER TABLE TB_PRODUTOS
-- MODIFY COLUMN PRO_DESCRICAO VARCHAR(200);

INSERT INTO TB_PRODUTOS 
	(PRO_NOME, PRO_PRECO, PRO_QUANTIDADE_MINIMA, PRO_QUANTIDADE_ESTOQUE, FK_PRO_MAR, FK_PRO_DEP) 
VALUES 
	('BOLA DE VÔLEI', 300.00, 10, 100, 1, 1),
    ('TÊNIS', 250.00, 10, 50, 2, 2),
    ('CAMISA DRYFIT', 49.90, 5, 25, 3, 3),
    ('BERMUDA', 69.90, 5, 20, 3, 4);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_ITENS_PRODUTOS(
	FK_IDP_PRO INT UNSIGNED NOT NULL,
    FK_IDP_COM INT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_IDP_PRO, FK_IDP_COM),
    CONSTRAINT FK_PRO_IDP FOREIGN KEY(FK_IDP_PRO) REFERENCES TB_PRODUTOS(PK_PRO),
    CONSTRAINT FK_COM_IDP FOREIGN KEY(FK_IDP_COM) REFERENCES TB_COMPRAS(PK_COM)
);

INSERT INTO TB_ITENS_PRODUTOS 
	(FK_IDP_COM, FK_IDP_PRO) 
VALUES 
	(1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 3),
    (3, 1),
    (3, 2),
    (3, 4);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_VENDEDORES(
	PK_VEN SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    VEN_NOME VARCHAR(80) NOT NULL,
    VEN_CPF VARCHAR(11) NOT NULL,
    VEN_MATRICULA VARCHAR(10) NOT NULL,
    VEN_LOGRADOURO VARCHAR(25),
    VEN_NUMERO VARCHAR(10),
    VEN_COMPLEMENTO VARCHAR(25),
    VEN_CEP VARCHAR(8),
    VEN_DATA_ADMISSAO DATE,
    VEN_DATA_DEMISSAO DATE,
    FK_VEN_SEX TINYINT UNSIGNED NOT NULL,
    FK_VEN_SUP SMALLINT UNSIGNED,
    FK_VEN_BAI SMALLINT UNSIGNED NOT NULL,
    FK_VEN_CID SMALLINT UNSIGNED NOT NULL,
    FK_VEN_EST TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_VEN),
    CONSTRAINT UNIQUE KEY(VEN_CPF),
    CONSTRAINT FK_SEX_VEN FOREIGN KEY(FK_VEN_SEX) REFERENCES TB_SEXOS(PK_SEX),
	CONSTRAINT FK_BAI_VEN FOREIGN KEY(FK_VEN_BAI) REFERENCES TB_BAIRROS(PK_BAI),
    CONSTRAINT FK_CID_VEN FOREIGN KEY(FK_VEN_CID) REFERENCES TB_CIDADES(PK_CID),
    CONSTRAINT FK_EST_VEN FOREIGN KEY(FK_VEN_EST) REFERENCES TB_ESTADOS(PK_EST)
);

-- ALTER TABLE TB_VENDEDORES
-- ADD COLUMN VEN_MATRICULA VARCHAR(10);
ALTER TABLE TB_VENDEDORES
ADD COLUMN FK_VEN_SEX TINYINT UNSIGNED NOT NULL;

INSERT INTO TB_VENDEDORES 
	(VEN_CPF, VEN_NOME, FK_VEN_SUP, FK_VEN_BAI, FK_VEN_CID, FK_VEN_EST) 
VALUES 
	(00000000000, 'JOAOZINHO 30', 2, 1, 1, 20),
    (11111111111, 'TEREZINHA DE JESUS', '', 2, 1, 20),
    (22222222222, 'ANA JÚLIA', 2, 3, 1, 20),
    (33333333333, 'LÉO BATISTA', 3, 4, 1, 20);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_FONE_VENDEDORES(
	FK_FDV_VEN SMALLINT UNSIGNED NOT NULL,
    FDV_FONE VARCHAR(12) NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_FDV_VEN, FDV_FONE),
    CONSTRAINT FK_VEN_FDV FOREIGN KEY(FK_FDV_VEN) REFERENCES TB_VENDEDORES(PK_VEN)
);

INSERT INTO TB_FONE_VENDEDORES 
	(FK_FDV_VEN, FDV_FONE) 
VALUES 
	(1, 8412345678),
    (2, 8487654321),
    (3, 8412121212),
    (4, 8421212121);

USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_VENDAS(
	PK_VDS INT UNSIGNED NOT NULL AUTO_INCREMENT,
    VDS_DATA DATE,
    VDS_PRECO DECIMAL(6,2),
    FK_VDS_CLI INT UNSIGNED NOT NULL,
    FK_VDS_VEN SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(PK_VDS),
    CONSTRAINT FK_CLI_VDS FOREIGN KEY(FK_VDS_CLI) REFERENCES TB_CLIENTES(PK_CLI),
    CONSTRAINT FK_VEN_VDS FOREIGN KEY(FK_VDS_VEN) REFERENCES TB_VENDEDORES(PK_VEN)
);

INSERT INTO TB_VENDAS 
	(FK_VDS_CLI, FK_VDS_VEN, VDS_DATA, VDS_PRECO) 
VALUES 
	(1,2,20171001,1000.00),
    (2,3,20170501,1500.00),
    (3,4,20180501,100.00),
    (1,1,20180801,2000.00);
    
USE DB_LOJA;

CREATE TABLE IF NOT EXISTS TB_ITENS_VENDAS(
	FK_IDV_PRO INT UNSIGNED NOT NULL,
    FK_IDV_VDS INT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_IDV_PRO, FK_IDV_VDS),
    CONSTRAINT FK_PRO_IDV FOREIGN KEY(FK_IDV_PRO) REFERENCES TB_PRODUTOS(PK_PRO),
	CONSTRAINT FK_VDS_IDV FOREIGN KEY(FK_IDV_VDS) REFERENCES TB_VENDAS(PK_VDS)
);

INSERT INTO TB_ITENS_VENDAS 
	(FK_IDV_VDS, FK_IDV_PRO) 
VALUES 
	(1,1),
    (1,2),
    (1,3),
    (1,4),
    (2,1),
    (2,2),
    (2,4);
