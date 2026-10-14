% ============================================================
% UPIICSA - Fundamentos de Inteligencia Artificial (FIA)
% Practica No. 5 - Lenguaje Prolog: empleado_nombre.pl
% Version SIN corte (CUT)
% ============================================================

% ---------- HECHOS ----------
empleado(ortiz).
empleado(zavala).
mecanografa(ramos).
gerente(jimenez).
gerente(mejia).

% ---------- REGLAS ----------
supervisa(X,Y):-gerente(X),empleado(Y).
supervisa(X,Y):-empleado(X),mecanografa(Y).
supervisa(X,Y):-gerente(X),mecanografa(Y).

% ---------- GOALS DE LA PRACTICA (ejecutar en la consola) ----------
% ¿Quién supervisa a quién?
% ?- supervisa(Supervisor,Supervisado).        % GOAL principal (actividad 3)
% ¿A quién supervisa Jimenez?
% ?- supervisa(jimenez,Y).
% ¿Quién supervisa a Ramos?
% ?- supervisa(X,ramos).
% ¿Ortiz supervisa a Ramos?
% ?- supervisa(ortiz,ramos).
% ¿Ramos supervisa a alguien?
% ?- supervisa(ramos,_).
% ¿Cuál es la lista de relaciones supervisor-supervisado?
% ?- findall(X-Y, supervisa(X,Y), L).
% ¿Cómo se resuelve la consulta de quién supervisa a quién paso a paso?
% ?- trace, supervisa(Supervisor,Supervisado).  % TRACE (actividad 4)
% ¿Cómo se desactiva el modo de traza?
% ?- notrace.