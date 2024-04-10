create table cliente (
	id SERIAL primary key,
	nome CHAR(25) not null,
	endereco CHAR(8) references endereco(cep),
	telefone CHAR(9) not null
);
