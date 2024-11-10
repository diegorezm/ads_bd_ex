-- Crie uma função que retorne uma tabela com as datas em que ocorrem vendas de automoveis
-- e total de vendas na data e o total de vendas acumulada até a data.

-- Tipo para a resposta
DROP TYPE IF EXISTS resposta_total_de_vendas;
CREATE TYPE resposta_total_de_vendas AS (
    data DATE,
    total_de_vendas NUMERIC(6,2),
    total_acumulado NUMERIC(8,2)
);

-- Função para obter as vendas por data
DROP FUNCTION IF EXISTS tota_de_vendas_por_data;
CREATE OR REPLACE FUNCTION tota_de_vendas_por_data()
RETURNS TABLE (
    data DATE,
    total_de_vendas NUMERIC(6,2),
    total_acumulado NUMERIC(8,2)
) AS $$
BEGIN 
    -- Retornar o total de vendas e o total acumulado por data
    RETURN QUERY
        SELECT 
            v.data,
            SUM(v.valor) AS total_de_vendas,
            SUM(SUM(v.valor)) OVER (ORDER BY v.data) AS total_acumulado
        FROM 
            venda v
        GROUP BY 
            v.data
        ORDER BY 
            v.data;
END;
$$ LANGUAGE plpgsql;
