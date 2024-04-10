create table horarios (
	id serial primary key,
	horario_chegada time not null,
	horario_saida time not null,
	linha integer references linhas(numero) not null, 
	dia_da_semana integer references dias_da_semana(id) not null
);