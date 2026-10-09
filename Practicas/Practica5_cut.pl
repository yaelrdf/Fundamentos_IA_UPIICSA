% ============================================================
% UPIICSA - Fundamentos de Inteligencia Artificial (FIA)
% Practica No. 5 - Lenguaje Prolog: empleado_nombre_cut.pl
% Version CON corte (CUT) en la primera regla de supervisa
% ============================================================

% ---------- HECHOS ----------
empleado(ortiz).
empleado(zavala).
mecanografa(ramos).
gerente(jimenez).
gerente(mejia).

% ---------- REGLAS ----------
supervisa(X,Y):-gerente(X),empleado(Y),!.
supervisa(X,Y):-empleado(X),mecanografa(Y).
supervisa(X,Y):-gerente(X),mecanografa(Y).

% ---------- GOALS DE LA PRACTICA (ejecutar en la consola) ----------
% ?- supervisa(Supervisor,Supervisado).        % GOAL principal (actividad 6-7)
% ?- supervisa(jimenez,Y).
% ?- supervisa(X,ramos).
% ?- supervisa(ortiz,ramos).
% ?- supervisa(ramos,_).
% ?- findall(X-Y, supervisa(X,Y), L).
% ?- trace, supervisa(Supervisor,Supervisado).  % TRACE (actividad 7)
% ?- notrace.