-- 4) Comandas com mais de um tipo de café
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
