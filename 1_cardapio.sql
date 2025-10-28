-- 1) Listagem do cardápio ordenada por nome
SELECT 
    codigo,
    nome,
    descricao,
    preco_unitario
FROM cardapio
ORDER BY nome;
