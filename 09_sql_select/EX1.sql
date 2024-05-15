SELECT 
    tipo_movimento.data,
   	case 
   		when tipo_movimento.tipo = 'entrada' then 'E'
   		else 'S'
   	end as tipo,
    p.codigo,
    p.descricao 
FROM 
(
    SELECT codigo, produto, 'entrada' AS tipo, data FROM entrada 
    UNION ALL
    SELECT codigo, produto, 'saida' AS tipo, data FROM saida 
) AS tipo_movimento
JOIN produto p ON tipo_movimento.produto = p.codigo
order by 
tipo_movimento.data,
p.codigo;
