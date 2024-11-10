-- Escreva uma função que receba o código de um fabricante
-- e retorne uma tabela no formato venda_cliente com todos  os
-- clientes que compraram automoveis do fabricante.

CREATE OR REPLACE FUNCTION clientes_por_fabricante(cod fabricante.codigo%TYPE)
RETURNS TABLE (cliente_nome cliente.nome%TYPE, data_venda venda.data%TYPE) 
LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
        SELECT 
            c.nome AS cliente_nome, 
            v.data AS data_venda
        FROM fabricante f
        JOIN automovel a ON a.fabricante = f.codigo
        JOIN venda v ON v.automovel = a.codigo
        JOIN cliente c ON c.codigo = v.cliente
        WHERE f.codigo = cod;
END;
$$;
