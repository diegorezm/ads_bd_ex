select 
count(e.produto) 
from produto p 
left join entrada e on e.produto = p.codigo and p.codigo = '02';
