-- Crie uma função que receba um nome como parâmetro e retorne o 
-- superior máximo desse nome na organização.

  
CREATE OR REPLACE FUNCTION get_superior_maximo(nome_input bpchar)
RETURNS bpchar AS $$
DECLARE
    superior_atual bpchar(15);
BEGIN
    superior_atual := nome_input;

    -- Loop para encontrar o superior máximo
    WHILE superior_atual IS NOT NULL LOOP
        SELECT superior INTO superior_atual
        FROM public.organizacao
        WHERE nome = superior_atual;

        -- Se não houver superior, retorne o atual
        IF superior_atual IS NULL THEN
            RETURN nome_input;
        END IF;
    END LOOP;

    RETURN superior_atual;
END;
$$ LANGUAGE plpgsql;
