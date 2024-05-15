select 
p.participante,
f.descricao as fase,
p2.supervisor 
from participante p 
join fase f on p.fase  = f.codigo 
join projeto p2 on p2.codigo = p.projeto
order by f.codigo;
