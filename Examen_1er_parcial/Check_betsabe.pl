% ==================== DIRECTIVAS ====================
:- dynamic competidor/1.
:- dynamic medalla/3.
:- dynamic le_gusta/2.
:- dynamic disciplina/1.
:- dynamic campeon/2.

% Hechos

% Competidores
competidor(juan).
competidor(maria).
competidor(carlos).
competidor(ana).
competidor(luis).
competidor(sofia).

% Disciplinas
disciplina(natacion).
disciplina(ciclismo).
disciplina(carrera).

% Medallas que obtuvieron
medalla(juan, natacion, oro).
medalla(maria, ciclismo, oro).
medalla(carlos, carrera, oro).
medalla(ana, natacion, plata).
medalla(luis, ciclismo, plata).
medalla(sofia, carrera, plata).
medalla(juan, ciclismo, plata).
medalla(maria, natacion, plata).
medalla(carlos, ciclismo, bronce).
medalla(ana, carrera, bronce).
medalla(luis, natacion, bronce).
medalla(sofia, ciclismo, bronce).
% --- Medalla agregada para que Juan cumpla el requisito del triatlón ---
medalla(juan, carrera, plata).

% Gustos de los competidores
le_gusta(juan, natacion).
le_gusta(maria, ciclismo).
le_gusta(carlos, carrera).
le_gusta(ana, natacion).
le_gusta(luis, ciclismo).
le_gusta(sofia, carrera).
% --- Gustos agregados para que a Juan le gusten las 3 disciplinas ---
le_gusta(juan, ciclismo).
le_gusta(juan, carrera).

% Auxiliares

% tipos de medallas 
tipo_medalla(oro).
tipo_medalla(plata).
tipo_medalla(bronce).

medalla_valida(oro).
medalla_valida(plata).
medalla_valida(bronce).

% reglas

campeon(Competidor, Disciplina) :-
    medalla(Competidor, Disciplina, oro).

le_gusta_por_campeonato(Competidor, Disciplina) :-
    campeon(Competidor, Disciplina).

ganador_triatlon(Competidor) :-
    le_gusta(Competidor, natacion),
    le_gusta(Competidor, ciclismo),
    le_gusta(Competidor, carrera),
    medalla(Competidor, natacion, TipoMedalla1),
    (TipoMedalla1 = oro ; TipoMedalla1 = plata),
    medalla(Competidor, ciclismo, TipoMedalla2),
    (TipoMedalla2 = oro ; TipoMedalla2 = plata),
    medalla(Competidor, carrera, TipoMedalla3),
    (TipoMedalla3 = oro ; TipoMedalla3 = plata).

campeon_triatlon(Competidor) :-
    ganador_triatlon(Competidor).

solo_campeon(Disciplina, Competidor) :-
    campeon(Competidor, Disciplina).

solo_medalla(Competidor, Disciplina, TipoMedalla) :-
    medalla(Competidor, Disciplina, TipoMedalla).

gusta_deporte(Competidor, Disciplina) :-
    le_gusta(Competidor, Disciplina).

campeon_le_gusta(Competidor, Disciplina) :-
    campeon(Competidor, Disciplina),
    le_gusta(Competidor, Disciplina).

gusto(Disciplina, Competidor) :-
    le_gusta(Competidor, Disciplina).

campeon_con_medalla(Disciplina, Competidor, TipoMedalla) :-
    medalla(Competidor, Disciplina, TipoMedalla),
    TipoMedalla = oro.

info_campeon(Disciplina, Competidor, TipoMedalla, LeGusta) :-
    campeon(Competidor, Disciplina),
    solo_medalla(Competidor, Disciplina, TipoMedalla),
    (le_gusta(Competidor, Disciplina) -> LeGusta = si ; LeGusta = no).