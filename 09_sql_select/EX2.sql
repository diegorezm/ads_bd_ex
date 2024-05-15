SELECT 
    'Créditos' AS tipo,
    SUM(CASE WHEN l.valor > 0 THEN l.valor ELSE 0 END) AS total
FROM 
    lancamento l 
WHERE 
    l.conta = '01'
UNION ALL
SELECT 
    'Débitos' AS tipo,
    SUM(CASE WHEN l.valor < 0 THEN l.valor ELSE 0 END) AS total
FROM 
    lancamento l 
WHERE 
    l.conta = '01';
