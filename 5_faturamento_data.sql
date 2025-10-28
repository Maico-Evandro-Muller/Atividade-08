-- 5) Faturamento total por data
SELECT
    c.data,
    SUM(ic.quantidade * ca.preco_unitario) AS faturamento_total
FROM comanda c
JOIN item_comanda ic ON c.codigo = ic.codigo_comanda
JOIN cardapio ca ON ic.codigo_cardapio = ca.codigo
GROUP BY c.data
ORDER BY c.data;
