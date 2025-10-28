// 2) Comandas com itens detalhados
const query2 = `
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
`;
export default query2;