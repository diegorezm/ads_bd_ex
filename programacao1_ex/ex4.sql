-- Crie uma função que receba o código de uma conta, código do grupo, data 
-- e valor de um lançamento e insira esse lançamento na tabela se a conta e o 
-- grupo existirem e se o valor corresponder ao tipo do grupo ( grupos de 
-- receita só podem ter valores positivos e grupos de despesa só podem ter 
-- valores negativos ). Se não for possível inserir o lançamento, a função deve 
-- gerar um erro com uma mensagem explicativa sobre o erro ocorrido. A 
-- função não deve retornar nenhum valor.

CREATE OR REPLACE FUNCTION gerar_lancamento(
    cod public.conta.codigo%TYPE,
    cod_grupo public.grupo.codigo%TYPE,
    data public.lancamento."data"%TYPE,
    valor public.lancamento.valor%TYPE
) RETURNS void AS $$
BEGIN
    -- Check if the account exists
    IF NOT EXISTS (SELECT 1 FROM public.conta WHERE codigo = cod) THEN 
        RAISE EXCEPTION 'Conta não existe/não encontrada';
    
    -- Check if the group exists
    ELSIF NOT EXISTS (SELECT 1 FROM public.grupo WHERE codigo = cod_grupo) THEN
        RAISE EXCEPTION 'Grupo não existe/não encontrada';   
    
    -- Check for positive value for revenue group
    ELSIF EXISTS (
        SELECT 1 
        FROM public.grupo g 
        LEFT JOIN public.grupotipo gt ON gt.codigo = g.tipo 
        WHERE g.codigo = cod_grupo AND gt.tipo = 'receita'
    ) AND valor < 0 THEN
        RAISE EXCEPTION 'Valor inválido: grupos de receita só podem ter valores positivos.';  
    
    -- Check for negative value for expense group
    ELSIF EXISTS (
        SELECT 1 
        FROM public.grupo g 
        LEFT JOIN public.grupotipo gt ON gt.codigo = g.tipo 
        WHERE g.codigo = cod_grupo AND gt.tipo = 'despesa'
    ) AND valor > 0 THEN
        RAISE EXCEPTION 'Valor inválido: grupos de despesa só podem ter valores negativos.';  
    END IF;

    -- Insert the launch
    INSERT INTO public.lancamento (conta, grupo, data, valor)
    VALUES (cod, cod_grupo, data, valor);
END;
$$ LANGUAGE plpgsql;

