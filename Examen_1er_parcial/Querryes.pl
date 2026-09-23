% ==================== QUERIES - CONSULTAS PARA RESOLVER EL PROBLEMA ====================

% GOAL 1: Identificar a quién de los competidores les gusta un deporte en particular
% Pregunta: ¿A quién le gusta la natación?
?- competidores_con_gusto(natacion, X).
% Resultado esperado: X = juan ; X = ana.

% Pregunta: ¿A quién le gusta el ciclismo?
?- competidores_con_gusto(ciclismo, X).
% Resultado esperado: X = maria ; X = luis.

% Pregunta: ¿A quién le gusta la carrera?
?- competidores_con_gusto(carrera, X).
% Resultado esperado: X = carlos ; X = sofia.

% ==================== GOAL 2: ¿Quién fue el campeón en cada disciplina? ====================

% Campeón en natación
?- get_campeon(natacion, X).
% Resultado: X = juan.

% Campeón en ciclismo
?- get_campeon(ciclismo, X).
% Resultado: X = maria.

% Campeón en carrera
?- get_campeon(carrera, X).
% Resultado: X = carlos.

% Todos los campeones
?- campeon(X, Y).
% Resultado: X = juan, Y = natacion ; X = maria, Y = ciclismo ; X = carlos, Y = carrera.

% ==================== GOAL 3: ¿Qué medalla le fue otorgada a cada campeón? ====================

% Medalla del campeón de natación
?- campeon(X, natacion), get_medalla(X, natacion, M).
% Resultado: X = juan, M = oro.

% Medalla del campeón de ciclismo
?- campeon(X, ciclismo), get_medalla(X, ciclismo, M).
% Resultado: X = maria, M = oro.

% Medalla del campeón de carrera
?- campeon(X, carrera), get_medalla(X, carrera, M).
% Resultado: X = carlos, M = oro.

% Información completa de campeones y medallas
?- campeon_con_medalla(D, C, M).
% Resultado: D = natacion, C = juan, M = oro ; D = ciclismo, C = maria, M = oro ; D = carrera, C = carlos, M = oro.

% ==================== GOAL 4: ¿Al ganador le gusta ese deporte? ====================

% Verificar si al campeón de natación le gusta la natación
?- campeon(X, natacion), le_gusta(X, natacion).
% Resultado: X = juan. (Sí le gusta)

% Verificar si al campeón de ciclismo le gusta el ciclismo
?- campeon(X, ciclismo), le_gusta(X, ciclismo).
% Resultado: X = maria. (Sí le gusta)

% Verificar si al campeón de carrera le gusta la carrera
?- campeon(X, carrera), le_gusta(X, carrera).
% Resultado: X = carlos. (Sí le gusta)

% Información completa: campeón, disciplina, medalla y si le gusta
?- info_campeon(D, C, M, L).
% Resultado: D = natacion, C = juan, M = oro, L = si ;
%            D = ciclismo, C = maria, M = oro, L = si ;
%            D = carrera, C = carlos, M = oro, L = si.

% ==================== GOALS ADICIONALES ====================

% GOAL 5: ¿Quién ganó el triatlón? (Competidor que le gusta todas las disciplinas y tiene medalla plata/oro en cada una)
?- ganador_triatlon(X).
% Resultado: Dependerá de los datos. Con los datos actuales, probablemente ninguno (puede ser que ninguno cumpla todas las condiciones).

% GOAL 6: ¿Qué medallas ganó cada competidor?
?- medalla(Competidor, Disciplina, TipoMedalla), write(Competidor), write(' - '), write(Disciplina), write(': '), write(TipoMedalla), nl, fail.
?- true.

% GOAL 7: Competidores que ganaron medalla de oro
?- medalla(X, _, oro).
% Resultado: X = juan ; X = maria ; X = carlos.

% GOAL 8: Competidores que ganaron medalla de plata
?- medalla(X, _, plata).
% Resultado: X = ana ; X = luis ; X = sofia ; X = juan ; X = maria ; X = carlos.

% GOAL 9: ¿Cuántas medallas de cada tipo ganó un competidor?
?- findall(M, medalla(juan, _, M), Medallas), length(Medallas, N).
% Resultado: Medallas = [oro, plata], N = 2. (Juan ganó 1 oro y 1 plata)

% GOAL 10: Listar todos los campeones con su información
?- findall([D, C, M], campeon_con_medalla(D, C, M), Campeones).
% Resultado: Campeones = [[natacion, juan, oro], [ciclismo, maria, oro], [carrera, carlos, oro]].