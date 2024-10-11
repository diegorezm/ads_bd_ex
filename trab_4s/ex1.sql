-- Criar uma função que receba o código de um fabricante e a sigla de um estado e retorne a 
-- data,total de vendas no dia e total de vendas acumulado para cada data com venda deste fabricante
-- no estado indicado.


CREATE TYPE vendas_por_estado AS (
    data DATE, 
    vendas_dia INTEGER, 
    vendas_acumuladas INTEGER
);

CREATE OR REPLACE FUNCTION total_de_vendas_por_estado(
    fabricante_cod fabricante.codigo%TYPE, 
    estado_cod revenda.estado%TYPE
)
RETURNS SETOF vendas_por_estado AS $$
DECLARE
    ret vendas_por_estado;
BEGIN
	FOR ret IN
        SELECT
            v.data,
            COUNT(*) AS vendas_dia,
            SUM(COUNT(*)) OVER (ORDER BY v.data) AS vendas_acumuladas
        FROM venda v
        JOIN revenda r ON v.revenda = r.codigo
        JOIN automovel a ON v.automovel = a.codigo
        WHERE a.fabricante = fabricante_cod AND r.estado = estado_cod
        GROUP BY v.data
        ORDER BY v.data
    LOOP
        RETURN NEXT ret; 
    END LOOP;

    RETURN;
END;
$$ LANGUAGE plpgsql;
