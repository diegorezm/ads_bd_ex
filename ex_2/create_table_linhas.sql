create table linhas (
	numero integer primary key,
	itinerario integer references itinerario(id) not null,
	onibus integer references onibus(id),
	motorista integer references motoristas(numero)
);