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
% ?- supervisa(Supervisor,Supervisado).        % GOAL principal (actividad 3)
% ?- supervisa(jimenez,Y).
% ?- supervisa(X,ramos).
% ?- supervisa(ortiz,ramos).
% ?- supervisa(ramos,_).
% ?- findall(X-Y, supervisa(X,Y), L).
% ?- trace, supervisa(Supervisor,Supervisado).  % TRACE (actividad 4)
% ?- notrace.