USE DB_ASSEMBLEIA;

SELECT 
	MOR_NOME AS 'NOME DO MORADOR',
    BLO_NOME AS 'BLOCO',
    APA_NOME AS 'APARTAMENTO',
    ADI_SITUACAO AS 'STATUS PARA VOTAÇÃO'
FROM 
	TB_MORADORES
		JOIN
	TB_APARTAMENTOS_MORADORES ON FK_ADM_MOR = PK_MOR
		JOIN
	TB_APARTAMENTOS ON PK_APA = FK_ADM_APA
		JOIN
	TB_BLOCOS ON PK_BLO = FK_APA_BLO
		JOIN
	TB_ADIMPLENTES ON PK_ADI = FK_APA_ADI;
    
USE DB_ASSEMBLEIA;

SELECT 
	DEP_NOME AS 'NOME DO DEPENDENTE',
    MOR_NOME AS 'NOME DO MORADOR',
    BLO_NOME AS 'BLOCO',
    APA_NOME AS 'APARTAMENTO',
    ADI_SITUACAO AS 'STATUS PARA VOTAÇÃO'
FROM 
	TB_MORADORES
		JOIN
	TB_APARTAMENTOS_MORADORES ON FK_ADM_MOR = PK_MOR
		JOIN
	TB_APARTAMENTOS ON PK_APA = FK_ADM_APA
		JOIN
	TB_BLOCOS ON PK_BLO = FK_APA_BLO
		JOIN
	TB_ADIMPLENTES ON PK_ADI = FK_APA_ADI
		JOIN
	TB_DEPENDENTES_MORADORES ON FK_DDM_MOR = PK_MOR
		JOIN
	TB_DEPENDENTES ON PK_DEP = FK_DDM_DEP;
    
USE DB_ASSEMBLEIA;

SELECT 
	ASS_NOME AS 'ASSEMBLEIA',
    TDA_NOME AS 'TIPO DE ASSEMBLEIA',
    MOR_NOME AS 'NOME DO MORADOR'
FROM 
	TB_ASSEMBLEIAS
		JOIN
	TB_MORADORES_ASSEMBLEIAS ON FK_MDA_ASS = PK_ASS
		JOIN
	TB_MORADORES ON PK_MOR = FK_MDA_MOR
		JOIN
	TB_TIPOS_ASSEMBLEIAS ON PK_TDA = FK_ASS_TDA;

USE DB_ASSEMBLEIA;

SELECT 
	ASS_NOME AS 'ASSEMBLEIA',
    TDA_NOME AS 'TIPO DE ASSEMBLEIA',
    MOR_NOME AS 'NOME DO MORADOR'
FROM 
	TB_ASSEMBLEIAS
		JOIN
	TB_MORADORES_ASSEMBLEIAS ON FK_MDA_ASS = PK_ASS
		JOIN
	TB_MORADORES ON PK_MOR = FK_MDA_MOR
		JOIN
	TB_TIPOS_ASSEMBLEIAS ON PK_TDA = FK_ASS_TDA
WHERE TDA_NOME LIKE 'ASSEMBLEIA EXTRAORDINARIA';

USE DB_ASSEMBLEIA;

SELECT 
    *
FROM
    TB_APARTAMENTOS
        RIGHT JOIN
	TB_APARTAMENTOS_MORADORES ON FK_ADM_APA = PK_APA
		RIGHT JOIN 
    TB_APARTAMENTOS ON PK_MOR = FK_ADM_MOR;

		
		
		