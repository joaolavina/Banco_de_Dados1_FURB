-- 1.
CREATE TABLE genero(
cd_genero INTEGER AUTO_INCREMENT,
ds_genero VARCHAR(30),
PRIMARY KEY(cd_genero) 
);

CREATE TABLE ator(
cd_ator INTEGER AUTO_INCREMENT,
nm_ator VARCHAR(50),
PRIMARY KEY(cd_ator)
);

CREATE TABLE censura (
cd_censura INTEGER AUTO_INCREMENT,
ds_censura VARCHAR(30),
PRIMARY KEY(cd_censura)
);

CREATE TABLE filme (
cd_filme INTEGER AUTO_INCREMENT,
cd_censura INTEGER REFERENCES censura(cd_censura),
cd_genero INTEGER REFERENCES genero(cd_genero),
nm_filme VARCHAR(50) UNIQUE NOT NULL,
ds_sinopse VARCHAR(250),
nr_duracao VARCHAR(20), 
dt_lancamento DATE,
fl_dublado CHAR(1),
PRIMARY KEY(cd_filme)
);

CREATE TABLE filme_ator (
cd_filme INTEGER REFERENCES filme(cd_filme),
cd_ator INTEGER REFERENCES ator(cd_ator)
);

-- 2.
ALTER TABLE genero
MODIFY COLUMN ds_genero VARCHAR(30) UNIQUE NOT NULL;

ALTER TABLE censura
MODIFY COLUMN ds_censura VARCHAR(30) UNIQUE NOT NULL;

-- 3.
INSERT INTO censura (ds_censura)
VALUES ('Livre'),
('12 anos'),
('16 anos'),
('18 anos');

INSERT INTO genero (ds_genero)
VALUES ('Terror'),
('Comédia'),
('Infantil'),
('Aventura'),
('Romance'),
('Ficção Científica');

INSERT INTO ator (nm_ator)
VALUES ('Mia Goth'),
('Winona Ryder'),
('Margot Robbie'),
('Natalie Portman'),
('Anya Taylor-Joy'),
('Nicolas Cage'),
('Keanu Reeves'),
('Adam Driver'),
('Tom Hanks'),
('Joaquin Phoenix');

INSERT INTO filme (cd_censura, cd_genero, nm_filme, ds_sinopse, nr_duracao, dt_lancamento, fl_dublado)
VALUES (1,1, 'Eduardo, O Filme', 'Eduardo em seu filme',  '26h 69min', '2004/06/24', 'S'),
 (3, 6, 'Star Porra', 'A Gozada das Galáxias' ,'2h 55min', '1998/01/08', null),
 (2, 4, 'Os Aventureiros','Uma aventura' ,'50min', '2014/09/22', 'N'),
 (4, 5, 'Eita bixo seixokkk', 'Coringa kkkkkkkk' ,'5min', '2023/12/01', 'S'),
 (1, 2, 'Humor inclusivo', 'Humor pra todes' ,'1h 26min', '1987/03/03', 'N'),
 (1, 3, 'Filme pra criança', 'Sinopse pra que', '5h 32min', '2014/03/25', 'S');
 
INSERT INTO filme_ator
VALUES (1,1),
(1,6),
(1,4),
(1,8),
(2,2),
(2,7),
(3,3),
(3,8),
(4,4),
(4,9),
(5,5),
(5,3),
(5,10);

-- 4.
SELECT f.nm_filme, c.ds_censura, g.ds_genero, a.nm_ator
FROM filme f JOIN censura c ON (f.cd_censura = c.cd_censura)
	JOIN genero g ON (f.cd_genero = g.cd_genero )
	JOIN filme_ator fa ON (fa.cd_filme = f.cd_filme)
	JOIN ator a ON (a.cd_ator = fa.cd_ator);
	
-- 5.
SELECT f.nm_filme, c.ds_censura, f.fl_dublado, g.ds_genero
FROM filme f 
	JOIN censura c ON (c.cd_censura = f.cd_censura)
	JOIN genero g ON (g.cd_genero = f.cd_genero)
WHERE c.ds_censura LIKE 'Livre'
	AND g.ds_genero LIKE 'Infantil' 
	AND f.fl_dublado LIKE 'S'
ORDER BY f.dt_lancamento DESC;	
	
-- 6. Listagem dos filmes que apresentam (03) três ou mais atores associados
SELECT f.nm_filme, COUNT(fa.cd_ator) AS 'qtd_atores'
FROM filme_ator fa 
	JOIN filme f ON (fa.cd_filme = f.cd_filme)
	JOIN ator a ON (a.cd_ator = fa.cd_ator)
GROUP BY f.nm_filme
HAVING COUNT(fa.cd_ator) >= 3
	
-- 7 Recuperação da quantidade de filme agrupada por cada descrição de censura,
-- ou seja, mostrar a descrição da censura e quantos filmes cada uma apresenta;
SELECT c.ds_censura, COUNT(f.cd_filme) AS 'qtd_filmes'
FROM censura c
	JOIN filme f ON (c.cd_censura = f.cd_censura)
GROUP BY f.cd_censura
