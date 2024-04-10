create table cliente (
	id SERIAL PRIMARY KEY,
	cpf char(11) UNIQUE not null,
	nome CHAR(25) not null,
	endereco CHAR(8) references endereco(cep) not null,
	telefone CHAR(9) not null
);
