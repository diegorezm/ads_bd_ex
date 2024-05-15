select 
p.codigo as produto,
p.descricao,
COUNT(CASE WHEN p.codigo = e.produto THEN 1 ELSE NULL END) AS total_de_entradas
from produto p 
left join entrada e on e.produto = p.codigo
group by 
p.codigo 
;
