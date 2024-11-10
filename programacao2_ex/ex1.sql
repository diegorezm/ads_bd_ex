-- Escreva uma função que receba o código de uma diretoria como parâmetro e retorne o 
-- registro do funcionário de maior salario como parâmetro e retorne o registro do funcionário 
-- de maior salário da diretoria.salário da diretoria

CREATE OR REPLACE FUNCTION maior_salario_da_diretoria(cod diretoria.codigo%TYPE)
RETURNS SETOF funcionario.nome%TYPE as $$
DECLARE
	nome funcionario.nome%TYPE;
BEGIN
	SELECT f.nome
  INTO nome
  FROM diretoria d
 	JOIN secao s ON s.diretoria = d.codigo
  JOIN funcionario f ON s.codigo = f.secao
  WHERE d.codigo = cod
  ORDER BY f.salario DESC LIMIT 1;
  RETURN QUERY SELECT nome;
END;
$$ LANGUAGE plpgsql;
