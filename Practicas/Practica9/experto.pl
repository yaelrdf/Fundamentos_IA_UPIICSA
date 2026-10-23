/* Sistema Experto: experto.pl
   Trata los sintomas como una lista. La cabeza es el diagnostico y la
   "cola" son los sintomas. Utiliza assert/1 para cambiar dinamicamente la
   base de conocimientos. Determina la verdad y falsedad de los sintomas
   conocidos. Puede contestar a las preguntas 'porque' e incluye capacidad
   de explicacion. Elimina dinamicamente las aseveraciones agregadas despues
   de cada consulta. */

/* ------------------------------------------------------------------------
   DIRECTIVA :- style_check(-singleton).   (Actividad 4)
   style_check/1 activa o desactiva advertencias de estilo del compilador de
   SWI-Prolog. El argumento -singleton DESACTIVA el aviso
   "Singleton variables: [Diagnosis]" que aparece cuando una variable con
   nombre se usa una sola vez dentro de una clausula (por ejemplo, Diagnosis
   en prueba_presencia_de(Diagnosis, [])). Ese aviso solo sirve para detectar
   posibles errores de escritura; aqui las variables se dejan con nombre a
   proposito para que el codigo sea mas legible, por lo que la advertencia se
   suprime. Debe colocarse ANTES de las clausulas que generan el aviso.
   ------------------------------------------------------------------------ */
 :- style_check(-singleton).

/* MEMORIA DE TRABAJO (base de hechos): conocido/1 se declara dinamico para
   poder agregar (asserta) y eliminar (retract) hechos durante la consulta. */
:-dynamic (conocido/1).

/* ===================== MOTOR DE INFERENCIA ===================== */
consulta:-
   haz_diagnostico(X),
   escribe_diagnostico(X),
   ofrece_explicacion_diagnostico(X),
   clean_scratchpad.
consulta:-
   write('No hay suficiente conocimiento para elaborar un diagnostico'),
   clean_scratchpad.

haz_diagnostico(Diagnosis):-
  obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas),
  prueba_presencia_de(Diagnosis, ListaDeSintomas).

obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas):-
  conocimiento(Diagnosis, ListaDeSintomas).

prueba_presencia_de(Diagnosis, []).
prueba_presencia_de(Diagnosis, [Head|Tail]):-prueba_verdad_de(Diagnosis, Head),
  prueba_presencia_de(Diagnosis, Tail).

prueba_verdad_de(Diagnosis, Sintoma):-conocido(Sintoma).
prueba_verdad_de(Diagnosis, Sintoma):-not(conocido(is_false(Sintoma))),
  pregunta_sobre(Diagnosis, Sintoma, Reply), Reply=si.

/* ===================== INTERFAZ DE USUARIO ===================== */
pregunta_sobre(Diagnosis ,Sintoma, Reply):-write('Es verdad que '),
  write(Sintoma), write('?'),
  read(Respuesta), process(Diagnosis, Sintoma, Respuesta, Reply).

process(Diagnosis, Sintoma, si, si):-asserta(conocido(Sintoma)).
process(Diagnosis, Sintoma, no, no):-asserta(conocido(is_false(Sintoma))).
/* ===================== MODULO DE EXPLICACION ("porque") ===================== */
process(Diagnosis, Sintoma, porque, Reply):-nl,
  write('Estoy investigando la hipotesis siguiente: '),
  write(Diagnosis), write('.'), nl, write('Para esto necesito saber si '),
  write(Sintoma), write('.'), nl, pregunta_sobre(Diagnosis, Sintoma, Reply).
process(Diagnosis, Sintoma, Respuesta, Replay):- Respuesta \== no,
  Respuesta \== si, Respuesta \== porque, nl,
  write('Debes contestar si, no o porque '), nl,
  pregunta_sobre(Diagnosis, Sintoma, Replay).

escribe_diagnostico(Diagnosis):- write('El diagnostico es '),
  write(Diagnosis), write('.'), nl.

/* ===================== MODULO DE EXPLICACION (justificacion) ===================== */
ofrece_explicacion_diagnostico(Diagnosis):-
  pregunta_si_necesita_explicacion(Respuesta),
  actua_consecuentemente(Diagnosis, Respuesta).

pregunta_si_necesita_explicacion(Respuesta):-
write('Quieres que justifique este diagnostico? '),
read(RespuestaUsuario),
asegura_respuesta_si_o_no(RespuestaUsuario, Respuesta).

asegura_respuesta_si_o_no(si, si).
asegura_respuesta_si_o_no(no, no).
asegura_respuesta_si_o_no(_, Respuesta):- write('Debes contestar si o no.'),
pregunta_si_necesita_explicacion(Respuesta).

actua_consecuentemente(Diagnosis, no).
actua_consecuentemente(Diagnosis, si):- conocimiento(Diagnosis, ListaDeSintomas),
write('Se determino este diagnostico porque se encontraron los siguentes sintomas: '), nl,
escribe_lista_de_sintomas(ListaDeSintomas).

escribe_lista_de_sintomas([]).
escribe_lista_de_sintomas([Head | Tail]):-
write(Head), nl, escribe_lista_de_sintomas(Tail).

/* ===================== MEMORIA DE TRABAJO (limpieza) ===================== */
clean_scratchpad:- retract(conocido(X)), fail.
clean_scratchpad.
conocido(_):- fail.

/* not/1: negacion por falla. Si la meta X se cumple, el corte (!) evita
   probar la segunda clausula y fail hace que not(X) falle; si X no se
   cumple, la segunda clausula hace que not(X) tenga exito. (SWI-Prolog ya
   trae not/1 predefinido; esta definicion lo sustituye con el mismo
   comportamiento.) */
not(X):- X,!,fail.
not(_).
