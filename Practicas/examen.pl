% ==================== DIRECTIVAS ====================
:- dynamic competidor/1.
:- dynamic medalla/3.
:- dynamic le_gusta/2.
:- dynamic disciplina/1.
:- dynamic campeon/2.

% ==================== HECHOS (PREDICADOS) ====================

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

% Medallas obtenidas: medalla(Competidor, Disciplina, TipoMedalla)
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

% Gustos iniciales de competidores: le_gusta(Competidor, Disciplina)
le_gusta(juan, natacion).
le_gusta(maria, ciclismo).
le_gusta(carlos, carrera).
le_gusta(ana, natacion).
le_gusta(luis, ciclismo).
le_gusta(sofia, carrera).

% ==================== ELEMENTOS AUXILIARES ====================

% Definición de tipos de medallas y su jerarquía
tipo_medalla(oro).
tipo_medalla(plata).
tipo_medalla(bronce).

medalla_valida(oro).
medalla_valida(plata).
medalla_valida(bronce).

% ==================== REGLAS ====================

% Regla 1: Si un competidor es campeón en una disciplina, 
% entonces le gusta esa disciplina y tiene medalla de oro
campeon(Competidor, Disciplina) :-
    medalla(Competidor, Disciplina, oro).

% Regla 2: Si un competidor es campeón, entonces le gusta esa disciplina
le_gusta_por_campeonato(Competidor, Disciplina) :-
    campeon(Competidor, Disciplina).

% Regla 3: Ganador del triatlón - debe cumplir:
% - Le gusta natación, ciclismo y carrera
% - Ha ganado medalla de plata u oro en cada disciplina
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

% Regla 4: Obtener el campeón en una disciplina específica
get_campeon(Disciplina, Competidor) :-
    campeon(Competidor, Disciplina).

% Regla 5: Obtener la medalla de un competidor en una disciplina
get_medalla(Competidor, Disciplina, TipoMedalla) :-
    medalla(Competidor, Disciplina, TipoMedalla).

% Regla 6: Verificar si un competidor disfruta de un deporte específico
gusta_deporte(Competidor, Disciplina) :-
    le_gusta(Competidor, Disciplina).

% Regla 7: Competidor que es campeón y le gusta ese deporte
campeon_le_gusta(Competidor, Disciplina) :-
    campeon(Competidor, Disciplina),
    le_gusta(Competidor, Disciplina).

% Regla 8: Listar todos los competidores que les gusta una disciplina particular
competidores_con_gusto(Disciplina, Competidor) :-
    le_gusta(Competidor, Disciplina).

% Regla 9: Campeón en cada disciplina con su medalla
campeon_con_medalla(Disciplina, Competidor, TipoMedalla) :-
    medalla(Competidor, Disciplina, TipoMedalla),
    TipoMedalla = oro.

% Regla 10: Información completa del campeón
info_campeon(Disciplina, Competidor, TipoMedalla, LeGusta) :-
    campeon(Competidor, Disciplina),
    get_medalla(Competidor, Disciplina, TipoMedalla),
    (le_gusta(Competidor, Disciplina) -> LeGusta = si ; LeGusta = no).