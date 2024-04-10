CREATE TABLE empresas (
  numero INTEGER PRIMARY KEY NOT NULL,
  nome CHAR(25) NOT NULL,
  endereco CHAR(8) REFERENCES endereco(cep),
  gerente CHAR(25) NOT NULL
);
