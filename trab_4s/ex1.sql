-- Criar uma função que receba o código de um fabricante e a sigla de um estado e retorne a 
-- data,total de vendas no dia e total de vendas acumulado para cada data com venda deste fabricante
-- no estado indicado.

CREATE OR REPLACE FUNCTION total_de_vendas_por_estado(
    fabricante_cod fabricante.codigo%TYPE, 
    estado_cod revenda.estado%TYPE
)
RETURNS TABLE ( 
	  data venda.data%TYPE,
    vendas_dia INTEGER, 
    vendas_acumuladas INTEGER
) 
LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
        SELECT
            v.data as data,
           CAST(COUNT(*) as INTEGER) AS vendas_dia,
    		CAST(SUM(COUNT(*)) OVER (ORDER BY v.data) as INTEGER) AS vendas_acumuladas
        FROM venda v
        JOIN revenda r ON v.revenda = r.codigo
        JOIN automovel a ON v.automovel = a.codigo
        WHERE a.fabricante = fabricante_cod 
        AND r.estado = estado_cod
        GROUP BY v.data
        ORDER BY v.data;
END;
$$;
