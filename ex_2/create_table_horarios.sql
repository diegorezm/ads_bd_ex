create table horarios (
	id serial primary key not null,
	horario_chegada time not null,
	horario_saida time not null,
	linha integer references linhas(numero),
	dia_da_semana integer references dias_da_semana(id)
);