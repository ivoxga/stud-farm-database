-- Cria a base de dados
CREATE SCHEMA coudelaria;
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Usa base de dados
USE coudelaria;
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Tabela genero
CREATE TABLE genero (
    genero CHAR NOT NULL PRIMARY KEY
);

-- Inserir géneros
INSERT INTO genero (genero) 
VALUES    ('M'), ('F');

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Tabela coudelaria
CREATE TABLE coudelaria( 
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(64),
    proprietario VARCHAR(64),
    ano_inicio INT
    );

-- Inserir coudelarias
INSERT INTO coudelaria (nome, proprietario, ano_inicio) 
VALUES    ('Coudelaria Lusitana', 'António Figueiredo', 1985),
        ('Haras Vale Dourado', 'Marta Ribeiro', 2000),
        ('Coudelaria do Norte', 'Jorge Silva', 1995);
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Tabela cavalo
CREATE TABLE cavalo (
    UELN VARCHAR(15) NOT NULL PRIMARY KEY,
    nome VARCHAR(64) NOT NULL,
    genero CHAR NOT NULL,
    data_nascimento DATE NOT NULL,
    coudelaria_origin INT NOT NULL,
    coudelaria_atual INT,
    pai VARCHAR(15),
    mae VARCHAR(15),

    FOREIGN KEY (coudelaria_origin) REFERENCES coudelaria(ID),
    FOREIGN KEY (coudelaria_atual) REFERENCES coudelaria(ID),
    FOREIGN KEY (pai) REFERENCES cavalo(UELN),
    FOREIGN KEY (mae) REFERENCES cavalo(UELN)
);

-- Inserir cavalos (ordem importante: pais antes dos filhos)
INSERT INTO cavalo (UELN, nome, genero, data_nascimento, coudelaria_origin, coudelaria_atual, pai, mae) 
VALUES
    ('1212120001M0001', 'Dom Quixote', 'M', '2015-04-21', 1, 2, NULL, NULL),
    ('1212120001F0002', 'Isolda', 'F', '2016-05-15', 1, 2, NULL, NULL),
    ('1212120002M0003', 'Furacão', 'M', '2020-07-10', 2, 2, '1212120001M0001', '1212120001F0002'),
    ('1212120002F0004', 'Aurora', 'F', '2021-03-11', 2, 3, '1212120001M0001', '1212120001F0002'),
    ('1212120003M0005', 'Relâmpago', 'M', '2023-01-20', 3, 1, '1212120002M0003', '1212120002F0004');

INSERT INTO cavalo (UELN, nome, genero, data_nascimento, coudelaria_origin, coudelaria_atual)
VALUES     ('1000000001M0001', 'Nobre', 'M', '2005-03-12', 1, 1),
        ('1000000001F0002', 'Estrela', 'F', '2006-07-08', 1, 1),
        ('1000000002M0003', 'Centauro', 'M', '2007-02-20', 2, 2),
        ('1000000002F0004', 'Lua', 'F', '2008-11-15', 2, 2);
        
-- Inserir cavalos com pais
INSERT INTO cavalo (UELN, nome, genero, data_nascimento, coudelaria_origin, coudelaria_atual, pai, mae)
VALUES    ('1100000001M0005', 'Valente', 'M', '2015-05-05', 1, 2, '1000000001M0001', '1000000001F0002'),
        ('1100000001F0006', 'Dama', 'F', '2016-08-19', 1, 2, '1000000001M0001', '1000000001F0002'),
        ('1100000002M0007', 'Hércules', 'M', '2014-04-22', 2, 2, '1000000002M0003', '1000000002F0004'),
        ('1100000002F0008', 'Íris', 'F', '2013-09-10', 2, 2, '1000000002M0003', '1000000002F0004');
        
-- Inserir cavalos com pais e avós
INSERT INTO cavalo (UELN, nome, genero, data_nascimento, coudelaria_origin, coudelaria_atual, pai, mae)
VALUES    ('1200000001M0009', 'Trovão', 'M', '2023-01-01', 2, 2, '1100000001M0005', '1100000001F0006'),
        ('1200000002F0010', 'Brisa', 'F', '2023-02-15', 2, 2, '1100000002M0007', '1100000002F0008');
                
        -- Inserir cavalos com pais e avós (geração 3)
INSERT INTO cavalo (UELN, nome, genero, data_nascimento, coudelaria_origin, coudelaria_atual, pai, mae)
VALUES	
    ('1200000001M0023', 'Samuel', 'M', '2023-01-01', 2, 2, '1100000001M0005', '1100000001F0006');
      
--------------------------------------------------------------------------------------------------------------------------------------------
-- Tabela das provas
CREATE TABLE prova (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(64),
    data_prova DATE
);

-- Inserir provas
INSERT INTO prova (nome, data_prova) 
VALUES    ('Prova Nacional de Dressage', '2023-06-01'),
        ('Campeonato Jovem Lusitano', '2024-09-15'),
        ('Torneio Ibérico', '2024-11-05');

--------------------------------------------------------------------------------------------------------------------------------------------
-- Tabela de participações de um cavalo 
CREATE TABLE participacao (
    cavalo_UELN VARCHAR (15),
    prova_ID INT,
    classificacao INT,

    FOREIGN KEY (cavalo_UELN) REFERENCES cavalo(UELN),
    FOREIGN KEY (prova_ID) REFERENCES prova(ID)
);

-- Inserir participações
INSERT INTO participacao (cavalo_UELN, prova_ID, classificacao) 
VALUES    ('1212120002M0003', 1, 1),
        ('1212120002F0004', 2, 3),
        ('1212120003M0005', 3, 2);
        
        -- Trovão participa e ganha uma prova
INSERT INTO participacao (cavalo_UELN, prova_ID, classificacao) VALUES
('1200000001M0009', 2, 1), 
('1200000001M0009', 3, 3); -- Trovão em 3º no Campeonato Jovem

-- Brisa em provas
INSERT INTO participacao (cavalo_UELN, prova_ID, classificacao) VALUES
('1200000002F0010', 1, 2),
('1200000002F0010', 3, 1); -- Brisa vence o Torneio Ibérico

-- Hércules em provas
INSERT INTO participacao (cavalo_UELN, prova_ID, classificacao) VALUES
('1100000002M0007', 1, 4);

-- Dama participa também
INSERT INTO participacao (cavalo_UELN, prova_ID, classificacao) VALUES
('1100000001F0006', 2, 2);

-- Centauro participa mas não vence
INSERT INTO participacao (cavalo_UELN, prova_ID, classificacao) VALUES
('1000000002M0003', 3, 5);

-- ---------------------------------------------------------------------------------------------------------------------
-- ----------------------------------------- Respostas as questões colocadas -------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------

-- A) Quem é o avô de um cavalo? 
SELECT neto.nome as neto, avoM.nome as avoMaterno, avoP.nome as avoPaterno from cavalo neto
JOIN cavalo pai ON neto.pai = pai.UELN
JOIN cavalo avoP ON pai.pai = avoP.UELN
JOIN cavalo mae ON neto.mae= mae.UELN
JOIN cavalo avoM ON mae.pai= avoM.UELN
WHERE neto.nome = "Brisa";

-- B) Quais são os filhos de uma égua? 
SELECT UELN, nome
FROM cavalo
WHERE mae = '1000000001F0002'; 

-- C) Listar todos os cavalos de uma coudelaria. 
SELECT cavalo.UELN, cavalo.nome, cavalo.genero, cavalo.data_nascimento
FROM cavalo
JOIN coudelaria ON cavalo.coudelaria_atual = coudelaria.ID
WHERE coudelaria.nome = 'Coudelaria Lusitana';

-- D) Listar todos os cavalos que obtiveram 1º Prémio indicando a coudelaria origem. 
SELECT participacao.classificacao, cavalo.nome as Nome_Cavalo, coudelaria.nome  as Nome_Coudelaria, prova.nome as Nome_prova, prova.data_prova  FROM cavalo  
JOIN coudelaria ON coudelaria.ID = cavalo.coudelaria_origin 
JOIN participacao ON participacao.cavalo_UELN = cavalo.UELN
JOIN prova ON prova.id = participacao.prova_id
WHERE participacao.classificacao = 1;

-- E) Listar os prémios obtidos pelos cavalos nascidos numa dada coudelaria.
SELECT 
    c.nome AS nome_cavalo,
    cd.nome AS coudelaria_origem,
    p.nome AS prova,
    p.data_prova,
    pt.classificacao
FROM cavalo c
JOIN coudelaria cd ON c.coudelaria_origin = cd.ID
JOIN participacao pt ON c.UELN = pt.cavalo_UELN
JOIN prova p ON pt.prova_ID = p.ID
WHERE cd.nome = 'Haras Vale Dourado'
ORDER BY p.data_prova;

-- F) 	Saber se um cavalo tem relação com outro. 
SELECT c1.nome AS c1, c2.nome AS c2,
CASE
	WHEN c1.pai = c2.UELN THEN 'Cavalo 2 é pai de Cavalo 1'
	WHEN c1.mae = c2.UELN THEN 'Cavalo 2 é mãe de Cavalo 1'
	WHEN c2.pai = c1.UELN THEN 'Cavalo 1 é pai de Cavalo 2'
	WHEN c2.mae = c1.UELN THEN 'Cavalo 1 é mãe de Cavalo 2'
    WHEN c1.pai = c2.pai  AND  c1.mae = c2.mae THEN 'São irmãos'
	WHEN p1.pai = p2.pai AND p1.pai IS NOT NULL AND c1.UELN != c2.UELN THEN 'São irmãos por parte do pai'
	WHEN p1.mae = p2.mae AND p1.mae IS NOT NULL AND c1.UELN != c2.UELN THEN 'São irmãos por parte da mãe'
	WHEN p1.pai = c2.UELN OR m1.pai = c2.UELN THEN 'Cavalo 2 é avô de Cavalo 1'
	WHEN p2.pai = c1.UELN OR m2.pai = c1.UELN THEN 'Cavalo 1 é avô de Cavalo 2'
	WHEN p1.mae = c2.UELN OR m1.mae = c2.UELN THEN 'Cavalo 2 é avó de Cavalo 1'
	WHEN p2.mae = c1.UELN OR m2.mae = c1.UELN THEN 'Cavalo 1 é avó de Cavalo 2'
	ELSE 'Sem relação direta conhecida'
END AS relacao
FROM cavalo c1
JOIN cavalo c2
LEFT JOIN cavalo p1 ON c1.pai = p1.UELN
LEFT JOIN cavalo m1 ON c1.mae = m1.UELN
LEFT JOIN cavalo p2 ON c2.pai = p2.UELN
LEFT JOIN cavalo m2 ON c2.mae = m2.UELN
WHERE c1.nome = 'Estrela' AND c2.nome = 'Trovão';

-- G) Saber se um cavalo tem relação com outro.
SELECT 
    neto.nome AS cavalo,
    pai.nome AS pai,
    mae.nome AS mae,
    pai_do_pai.nome AS pai_do_pai,
    mae_do_pai.nome AS mae_do_pai,
    pai_da_mae.nome AS pai_da_mae,
    mae_da_mae.nome AS mae_da_mae
FROM cavalo neto
LEFT JOIN cavalo pai ON neto.pai = pai.UELN
LEFT JOIN cavalo mae ON neto.mae = mae.UELN
LEFT JOIN cavalo pai_do_pai ON pai.pai = pai_do_pai.UELN
LEFT JOIN cavalo mae_do_pai ON pai.mae = mae_do_pai.UELN
LEFT JOIN cavalo pai_da_mae ON mae.pai = pai_da_mae.UELN
LEFT JOIN cavalo mae_da_mae ON mae.mae = mae_da_mae.UELN
WHERE neto.nome = 'Trovão';