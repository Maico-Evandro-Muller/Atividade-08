-- Banco de dados: Cafeteria BomGosto

-- ==============================
-- 1. Criação das tabelas
-- ==============================
CREATE TABLE cardapio (
    codigo INT PRIMARY KEY,
    nome VARCHAR(100) UNIQUE,
    descricao TEXT,
    preco_unitario DECIMAL(10,2)
);

CREATE TABLE comanda (
    codigo INT PRIMARY KEY,
    data DATE,
    mesa INT,
    nome_cliente VARCHAR(100)
);

CREATE TABLE item_comanda (
    codigo_comanda INT,
    codigo_cardapio INT,
    quantidade INT,
    PRIMARY KEY (codigo_comanda, codigo_cardapio),
    FOREIGN KEY (codigo_comanda) REFERENCES comanda(codigo),
    FOREIGN KEY (codigo_cardapio) REFERENCES cardapio(codigo)
);

-- ==============================
-- 2. Consultas
-- ==============================

-- (1) Listagem do cardápio ordenada por nome
SELECT 
    codigo,
    nome,
    descricao,
    preco_unitario
FROM cardapio
ORDER BY nome;

-- (2) Comandas com itens detalhados
SELECT
    c.codigo AS codigo_comanda,
    c.data,
    c.mesa,
    c.nome_cliente,
    ca.nome AS nome_cafe,
    ca.descricao,
    ic.quantidade,
    ca.preco_unitario,
    (ic.quantidade * ca.preco_unitario) AS preco_total
FROM comanda c
JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo
ORDER BY c.data, c.codigo, ca.nome;

-- (3) Total de cada comanda
SELECT
    c.codigo,
    c.data,
    c.mesa,
    c.nome_cliente,
    SUM(ic.quantidade * ca.preco_unitario) AS valor_total
FROM comanda c
JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo
GROUP BY c.codigo, c.data, c.mesa, c.nome_cliente
ORDER BY c.data;

-- (4) Comandas com mais de um tipo de café
SELECT
    c.codigo,
    c.data,
    c.mesa,
    c.nome_cliente,
    SUM(ic.quantidade * ca.preco_unitario) AS valor_total
FROM comanda c
JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo
GROUP BY c.codigo, c.data, c.mesa, c.nome_cliente
HAVING COUNT(ic.codigo_cardapio) > 1
ORDER BY c.data;

-- (5) Faturamento total por data
SELECT
    c.data,
    SUM(ic.quantidade * ca.preco_unitario) AS faturamento_total
FROM comanda c
JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo
GROUP BY c.data
ORDER BY c.data;
