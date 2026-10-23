/* adquisicion.pl  (complementario, opcional)
   Modulo de adquisicion de conocimiento: permite agregar una nueva regla
   conocimiento(Diagnostico, ListaDeSintomas) en tiempo de ejecucion con
   assertz/1 (la agrega al FINAL de la base de conocimientos), sin editar
   el archivo BaseConocimientos1.pl.
   Cargar en este orden:
     ?- consult('adquisicion.pl').
     ?- consult('experto.pl').
     ?- consult('BaseConocimientos1.pl').
*/
:- dynamic(conocimiento/2).

agrega_conocimiento(Diagnostico, ListaDeSintomas):-
   assertz(conocimiento(Diagnostico, ListaDeSintomas)),
   write('Se agrego el diagnostico: '), write(Diagnostico), nl.

/* Ejemplo de uso:
   ?- agrega_conocimiento('covid', ['el paciente tiene fiebre',
        'el paciente tiene tos seca', 'el paciente tiene perdida de olfato',
        'el paciente tiene cansancio', 'el paciente tiene dolores musculares']).
*/
