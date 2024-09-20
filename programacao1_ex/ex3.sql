-- Monte o script para criar a seguinte tabela:
-- ProdutoLote(produto,lote,quantidade)
-- ●produto – 2 caracteres, chave estrangeira para a tabela produto
-- ●lote – 10 caracteres
-- ●quantidade - inteiro

CREATE OR REPLACE FUNCTION create_produto_lote()
RETURNS void AS $$
BEGIN

    EXECUTE 'CREATE TABLE IF NOT EXISTS public.ProdutoLote (
        produto bpchar(2) NOT NULL,
        lote bpchar(10) NOT NULL,
        quantidade int4 NOT NULL,
        CONSTRAINT ProdutoLote_pkey PRIMARY KEY (produto, lote),
        CONSTRAINT ProdutoLote_produto_fkey FOREIGN KEY (produto) REFERENCES public.produto(codigo)
    )';
    
    INSERT INTO public.ProdutoLote (produto, lote, quantidade)
    SELECT
        e.produto,                           -- Produto code
        e."data"::bpchar(10) AS lote,        -- Use the date as the lot (convert it to char)
        COALESCE(SUM(e.quantidade), 0) - COALESCE(SUM(s.quantidade), 0) AS quantidade 
    FROM
        public.entrada e
    LEFT JOIN
        public.saida s
    ON
        e.produto = s.produto AND e."data" = s."data"  -- Join on produto and date (lot)
    GROUP BY
        e.produto, e."data"
    HAVING
        (COALESCE(SUM(e.quantidade), 0) - COALESCE(SUM(s.quantidade), 0)) > 0; -- Only insert where net quantity > 0
    
    RAISE NOTICE 'ProdutoLote table populated with data from entrada and saida.';
    
END;
$$ LANGUAGE plpgsql;
