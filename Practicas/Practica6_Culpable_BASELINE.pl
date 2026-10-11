% ============================================================
% UPIICSA - Fundamentos de Inteligencia Artificial (FIA)
% Practica No. 6 - Lenguaje Prolog: culpable_cut.pl
% SEGUNDA PARTE - Version CON corte (CUT) en la regla condenado
% ============================================================
%
% Enunciados (logica de predicados):
%   1. Vx,y : culpable(X,Y)  <-  condenado(X,Y) ^ delito(Y)
%   2. Vx,y : condenado(X,Y) <-  intento(X,Y)   ^ demostrado(X,Y)
%
% Nota: el enunciado 2 escribe "intentado", pero los GOALs de la
% practica y la regla con CUT usan intento/2; se usa intento/2.

% ---------- DELITOS ----------
delito(incendio_premeditado).
delito(fraude).
delito(estafa).
delito(traicion_a_la_patria).
delito(robo_a_mano_armada).
delito(robo_a_casa_habitacion).
delito(robo_a_transeuntes).
delito(robo_en_transporte_publico).
delito(asesinato).
delito(secuestro).
delito(extorsion).

% ---------- INDIVIDUOS QUE HAN INTENTADO UN DELITO (segun el planteamiento) ----------
intento(calteron,   traicion_a_la_patria).
intento(martinez,   robo_a_mano_armada).
intento(rodriguez,  asesinato).
intento(sanchez,    incendio_premeditado).

% ---------- DELITOS DEMOSTRADOS ----------
% SUPUESTO: el planteamiento no dice quien fue demostrado; se asume que
% contra Calteron no se logro demostrar nada.
demostrado(martinez,  robo_a_mano_armada).
demostrado(rodriguez, asesinato).
demostrado(sanchez,   incendio_premeditado).

% ---------- REGLAS ----------
condenado(X,Y):- intento(X,Y), demostrado(X,Y).
culpable(X,Y):-  condenado(X,Y), delito(Y).

% ---------- GOALS DE LA PRACTICA (ejecutar en la consola) ----------
% a. ?- delito(Y).
% b. ?- delito(Delito).
% c. ?- intento(X,Y).
% d. ?- intento(Individuo,Delito).
% e. ?- demostrado(X,Y).
% f. ?- demostrado(Delincuente,Delito).
% g. ?- condenado(X,Y).
% h. ?- culpable(X,Y).
% i. ?- intento(X,Y), demostrado(X,Y).
% j. ?- condenado(X,Y), delito(Y).
% Trace:  ?- trace, condenado(X,Y).      ?- notrace.