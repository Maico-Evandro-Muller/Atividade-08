// 1) Listagem do cardápio ordenada por nome
const query1 = `
SELECT 
    codigo,
    nome,
    descricao,
    preco_unitario
FROM cardapio
ORDER BY nome;
`;
export default query1;