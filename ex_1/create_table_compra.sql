create table compras (
  id SERIAL PRIMARY KEY,
  data DATE not null,
  nota_fiscal CHAR(44) not null,
  livro CHAR(13) references livros(isbn) not null,
  cliente integer references cliente(id) not null,
  valor_pago INTEGER not null
);
