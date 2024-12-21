-- Criação do arquivo .csv
SELECT *
FROM
	fixed_database_1 AS db1
INNER JOIN
	fixed_database_2 AS db2
ON	
	db1.id_marca_ = db2.id_marca;


-- Criação de uma view para as análises
CREATE VIEW todas_as_compras AS 
SELECT *
FROM
	fixed_database_1 AS db1
INNER JOIN
	fixed_database_2 AS db2
ON	
	db1.id_marca_ = db2.id_marca;


-- 1- Qual marca teve o maior volume de vendas?
SELECT
	RANK() OVER(ORDER BY SUM(vendas) DESC) AS rank,
	marca,
	SUM(vendas) AS volume_de_vendas
FROM 
	todas_as_compras
GROUP BY
	marca

-- 2- Qual veículo gerou a maior e menor receita?
SELECT 
	RANK() OVER(ORDER BY SUM(valor_do_veiculo * vendas) DESC) as rank,
	nome,
    SUM(valor_do_veiculo * vendas) AS receita
FROM 
	todas_as_compras
GROUP BY 
	nome

-- Considere faixas de preço de venda dos carros a cada 10 mil reais.
-- Qual faixa mais vendeu carros? Quantos?
SELECT 
    SUM(vendas) AS vendas,
    (FLOOR(valor_do_veiculo / 10000)) AS faixa_preco,
    RANK() OVER(ORDER BY SUM(vendas) DESC) as rank
FROM 
    todas_as_compras
GROUP BY
	faixa_preco
ORDER BY 
	rank ASC

-- 4- Qual a receita das 3 marcas que têm os menores tickets médios?
SELECT 
	RANK() OVER(ORDER BY (SUM(vendas * valor_do_veiculo) / SUM(vendas)) ASC) as rank,
	marca,
    SUM(vendas * valor_do_veiculo) / SUM(vendas) AS ticket_medio,
    SUM(vendas * valor_do_veiculo) AS receita
FROM 
	todas_as_compras
GROUP BY 
	marca

-- 5- Existe alguma relação entre os veículos mais vendidos?


-- Criação de uma tabela auxiliar armazenando medidas dos carros
CREATE TABLE IF NOT EXISTS medidas(
 	id INTEGER PRIMARY KEY AUTOINCREMENT,
  	nome TEXT,
  	altura NUMERIC,
  	largura NUMERIC,
  	comprimento NUMERIC
  )
  
INSERT INTO medidas (nome, altura, largura, comprimento) VALUES
    ('Mobi', 1.495, 1.633, 3.566),
    ('Up', 1.504, 1.645, 3.689),
    ('Picanto', 1.485, 1.595, 3.595),
    ('208', 1.453, 1.745, 4.055),
    ('Corolla', 1.455, 1.780, 4.630),
    ('onix', 1.471, 1.731, 4.163),
    ('Clio', 1.417, 1.640, 3.811),
    ('Forester', 1.730, 1.815, 4.625),
    ('March', 1.528, 1.675, 3.827),
    ('Yaris', 1.490, 1.730, 4.145),
    ('WRX', 1.475, 1.795, 4.595),
    ('J2', 1.475, 1.640, 3.535),
    ('Lancer', 1.505, 1.765, 4.570),
    ('Pajero', 1.900, 1.875, 4.900),
    ('Duster', 1.693, 1.832, 4.376),
    ('L200', 1.785, 1.785, 5.280),
    ('Gol', 1.474, 1.656, 3.892),
    ('Sandero', 1.570, 1.730, 4.070),
    ('Uno', 1.480, 1.636, 3.820),
    ('2008', 1.583, 1.739, 4.159),
    ('206', 1.432, 1.652, 3.835),
    ('Cerato', 1.440, 1.800, 4.640),
    ('E-SJ1', 1.495, 1.670, 3.650),
    ('Saveiro', 1.521, 1.713, 4.474),
    ('Brz', 1.285, 1.775, 4.240),
    ('Captur', 1.619, 1.813, 4.329),
    ('J5', 1.465, 1.765, 4.590),
    ('Cronos', 1.508, 1.726, 4.364),
    ('XV', 1.520, 1.770, 4.430),
    ('argo', 1.503, 1.724, 3.998),
    ('Kombi', 2.040, 1.720, 4.505),
    ('Palio', 1.433, 1.634, 3.827),
    ('Sandero RS', 1.499, 1.722, 4.068),
    ('T-Cross', 1.598, 1.760, 4.199),
    ('307', 1.520, 1.762, 4.212),
    ('E-J7', 1.510, 1.820, 4.770),
    ('Eclipse', 1.685, 1.805, 4.405),
    ('Jetta', 1.478, 1.799, 4.747),
    ('Polo', 1.471, 1.751, 4.074),
    ('Rio', 1.450, 1.725, 4.065);