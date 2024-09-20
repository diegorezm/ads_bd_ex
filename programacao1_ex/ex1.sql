-- Crie uma função que receba como parâmetro o código da revenda e 
-- retorne o lucro médio das vendas feitas pela revenda.

CREATE FUNCTION calcular_lucro_medio_revenda(codigo_revenda CHAR(2))
RETURNS NUMERIC(7,2) AS $$
DECLARE
    lucro_medio NUMERIC(7,2);
BEGIN
    SELECT AVG(valor)
    INTO lucro_medio
    FROM venda
    WHERE revenda = codigo_revenda;
    -- Retorna o lucro médio
    RETURN lucro_medio;
END;
$$ LANGUAGE plpgsql;

