-- Crie uma função que receba como parâmetro a matricula do funcionário e 
-- retorne o nome da diretoria a qual o funcionário esta subordinado ou “nao 
-- retorne o nome da diretoria a qual o funcionário esta subordinado ou “nao 
-- alocado” se o funcionário não pertencer a nenhuma diretoria. A função deve 
-- alocado” se o funcionário não pertencer a nenhuma diretoria. A função deve 
-- gerar um erro caso não exista funcionário com a matricula indicada, com 
-- gerar um erro caso não exista funcionário com a matricula indicada, com 
-- uma mensagem indicando o erro ocorrido.

CREATE FUNCTION functionario_by_matricula(matricula funcionario.matricula%TYPE)
RETURNS diretoria.descricao%TYPE AS $$
DECLARE
    diretoria_nome diretoria.descricao%TYPE;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM funcionario f WHERE f.matricula = matricula) THEN
        RAISE EXCEPTION 'Funcionario com matricula % nao encontrado', matricula;
    END IF;
    
 
    SELECT d.descricao INTO diretoria_nome
    FROM funcionario f
    JOIN secao s ON f.secao = s.codigo
    JOIN diretoria d ON s.diretoria = d.codigo
    WHERE f.matricula = matricula;

    IF NOT FOUND THEN
        RETURN 'nao alocado';
    ELSE
        RETURN diretoria_nome;
    END IF;
END;
$$ LANGUAGE plpgsql;
