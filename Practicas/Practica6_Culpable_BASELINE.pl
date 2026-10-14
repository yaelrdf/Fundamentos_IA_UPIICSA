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
% ¿Qué delitos existen en la base de conocimientos?
% a. ?- delito(Y).
% ¿Qué delitos existen en la base de conocimientos?
% b. ?- delito(Delito).
% ¿Quiénes intentaron cometer delitos y cuáles?
% c. ?- intento(X,Y).
% ¿Qué delito intentó cometer cada individuo?
% d. ?- intento(Individuo,Delito).
% ¿Qué delitos fueron demostrados y contra quién?
% e. ?- demostrado(X,Y).
% ¿Qué delincuente tiene demostrado cada delito?
% f. ?- demostrado(Delincuente,Delito).
% ¿Quiénes fueron condenados y por qué delito?
% g. ?- condenado(X,Y).
% ¿Quiénes son culpables y de qué delito?
% h. ?- culpable(X,Y).
% ¿Qué coincidencias existen entre intentos y delitos demostrados?
% i. ?- intento(X,Y), demostrado(X,Y).
% ¿Qué condenas corresponden a delitos registrados en la base?
% j. ?- condenado(X,Y), delito(Y).
% ¿Cómo se resuelve paso a paso quién fue condenado y por qué delito?
% Trace:  ?- trace, condenado(X,Y).      ?- notrace.