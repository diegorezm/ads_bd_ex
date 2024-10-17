-- Criar um função que receba os códigos de uma diretoria e retorne a descrição da diretoria
-- a descrição da função e média salarial da função na diretoria para todas as funções. Caso a
-- diretoria não possua funcionários, a função deve emitir uma mensagem de aviso.

CREATE TYPE retorno_media_salarial_por_diretoria AS (
	diretoria_descricao VARCHAR(255),
  funcao_descricao VARCHAR(255),
  media_salarial INTEGER
);

CREATE OR REPLACE FUNCTION media_salarial_por_diretoria(
    diretoria_cdg bpchar(3)
)
RETURNS SETOF retorno_media_salarial_por_diretoria AS $$
DECLARE 
    ret retorno_media_salarial_por_diretoria;
    rec_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO rec_count
    FROM funcionario f
    JOIN secao s ON f.secao = s.codigo
    JOIN diretoria d ON d.codigo = s.diretoria
    WHERE d.codigo = diretoria_cdg;

    IF rec_count = 0 THEN
        RAISE NOTICE 'A diretoria não possui funcionários.';
        RETURN;
    END IF;

    FOR ret IN 
        SELECT    
            d.descricao AS diretoria_descricao,
            fu.descricao AS funcao_descricao,
            AVG(f.salario) AS media_salarial
        FROM diretoria d
        JOIN secao s ON d.codigo = s.diretoria
        JOIN funcionario f ON f.secao = s.codigo
        JOIN funcao fu ON f.funcao = fu.funcao
        WHERE d.codigo = diretoria_cdg
        GROUP BY d.descricao, fu.descricao, d.codigo
        ORDER BY d.codigo
    LOOP
        RETURN NEXT ret;
    END LOOP;

    RETURN;
END;
$$ LANGUAGE plpgsql;
