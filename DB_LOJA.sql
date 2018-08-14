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

CREATE TABLE IF NOT EXISTS TB_CLIENTE_PESSOA_FISICA(
    FK_PFC_CLI INT UNSIGNED NOT NULL,
    PFC_NOME VARCHAR(80) NOT NULL,
    PFC_CPF VARCHAR(11) NOT NULL,
    PFC_DATA_NASCIMENTO DATE,
    PFC_RG VARCHAR(15),
    FK_PFC_SEX TINYINT UNSIGNED NOT NULL,
    CONSTRAINT PRIMARY KEY(FK_PFC_CLI),
    CONSTRAINT UNIQUE KEY (PFC_CPF),
    CONSTRAINT FK_SEX_PFC FOREIGN KEY(FK_PFC_SEX) REFERENCES TB_SEXOS(PK_SEX)
);
