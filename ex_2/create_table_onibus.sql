create table onibus(
	id serial primary key not null,
	placa CHAR(7) not null,
	tipo integer references onibus_tipos(id)
);

