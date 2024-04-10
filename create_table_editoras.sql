create table editoras (
        codigo CHAR(5) primary key not null,
      	endereco CHAR(8) references endereco(cep),
        telefone CHAR(9) not null,
        gerente CHAR(25) not null
);
