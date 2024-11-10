-- Crie uma função que receba o código da conta e retorne a
-- movimentação da conta com a data, valor, descrição do grupo de lançamento e saldo da conta
-- até o lançamento para todos os lançamentos da conta.

CREATE OR REPLACE FUNCTION movimentacoes_da_conta(cod conta.codigo%TYPE)
RETURNS TABLE (
  data lancamento.data%TYPE, 
  valor lancamento.valor%TYPE, 
  descricao grupo.descricao%TYPE, 
  tipo grupotipo.descricao%TYPE,
  saldo lancamento.valor%TYPE) AS $$
BEGIN
    RETURN QUERY
        SELECT 
            l.data, 
            l.valor, 
            g.descricao, 
            gt.descricao AS GRUPO_TIPO, 
            SUM(l.valor) OVER (ORDER BY l.data) AS saldo
        FROM 
            conta c 
        JOIN 
            lancamento l ON l.conta = c.codigo
        JOIN 
            grupo g ON l.grupo = g.codigo
        JOIN 
            grupotipo gt ON gt.codigo = g.tipo
        WHERE 
            c.codigo = cod;
END;
$$ LANGUAGE plpgsql;
