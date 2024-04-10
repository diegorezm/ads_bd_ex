create table endereco (
	cep CHAR(8) not null UNIQUE,
	logadouro text not null,
	numero INTEGER not null,
	bairro CHAR(50) not null,
	UF CHAR(2) not null,
	primary KEY(numero, cep)
);
