create table cliente (
	id SERIAL PRIMARY KEY,
	cpf char(11) UNIQUE,
	nome CHAR(25) not null,
	endereco CHAR(8) references endereco(cep),
	telefone CHAR(9) not null
);
