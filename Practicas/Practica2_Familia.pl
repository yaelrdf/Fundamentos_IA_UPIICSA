
%Hechos

hombre(fabio).
hombre(ivan).
hombre(silvio).
hombre(jorge).
hombre(saul).

mujer(elena).
mujer(rosalba).
mujer(anita).
mujer(julia).
mujer(bree).
mujer(rosa).

% Se definen en ambas direcciones para facilitar las consultas.
casados(fabio, elena).
casados(elena, fabio).
casados(ivan, rosalba).
casados(rosalba, ivan).
casados(silvio, anita).
casados(anita, silvio).

ancestros(elena, rosalba).
ancestros(elena, silvio).
ancestros(fabio, rosalba).
ancestros(fabio, silvio).

ancestros(ivan, jorge).
ancestros(ivan, saul).
ancestros(ivan, julia).
ancestros(rosalba, jorge).
ancestros(rosalba, saul).
ancestros(rosalba, julia).

ancestros(silvio, bree).
ancestros(silvio, rosa).
ancestros(anita, bree).
ancestros(anita, rosa).


%Reglas

% Padres y Madres
padre(P, H):- 
    ancestros(P, H), hombre(P).

madre(M, H):- 
    ancestros(M, H), mujer(M).

% Abuelos y Abuelas
abuelo(A, N):-
    padre(A, P), ancestros(P, N).

abuela(A, N):- 
    madre(A, P), ancestros(P, N).

% Nietos y Nietas
nieto(N, A):- 
    ancestros(A, P), ancestros(P, N), hombre(N).

nieta(N, A):-
    ancestros(A, P), ancestros(P, N), mujer(N).

% Reglas auxiliares para Hermanos (usando 'padre' para evitar duplicados en consultas)
hermanos(X, Y):- 
    padre(P, X), padre(P, Y), X \= Y.

hermano(H, X):- 
    hermanos(H, X), hombre(H).

hermana(H, X):-
    hermanos(H, X), mujer(H).

% Tíos biológicos (Auxiliares para facilitar otras reglas)
tio_biologico(T, S):- 
    hermano(T, P), ancestros(P, S).

tia_biologica(T, S):-
    hermana(T, P), ancestros(P, S).

% Tíos y Tías políticos
tio_politico(T, S):- 
    tia_biologica(A, S), casados(T, A), hombre(T).

tia_politica(T, S):- 
    tio_biologico(A, S), casados(T, A), mujer(T).

% Primos y Primas
primo(P, X):-
    ancestros(A, P), (tio_biologico(A, X) ; tia_biologica(A, X)), hombre(P).

prima(P, X):-
    ancestros(A, P), (tio_biologico(A, X) ; tia_biologica(A, X)), mujer(P).

% Sobrinos y Sobrinas (Incluye tanto a los de sangre como a los políticos)
sobrino(S, T):- 
    (tio_biologico(T, S) ; tia_biologica(T, S) ; tio_politico(T, S) ; tia_politica(T, S)), hombre(S).

sobrina(S, T):-
    (tio_biologico(T, S) ; tia_biologica(T, S) ; tio_politico(T, S) ; tia_politica(T, S)), mujer(S).

sobrinos(S, T) :- 
    tio_biologico(T, S); tia_biologica(T, S); tio_politico(T, S); tia_politica(T, S).

% Cuñados y Cuñadas
% Caso 1: Es esposo de mi hermana / Caso 2: Es hermano de mi cónyuge
cuñado(C, P):-
    hermana(H, P), casados(C, H), hombre(C).
cuñado(C, P):-
    casados(P, E), hermano(C, E), hombre(C).

cuñada(C, P):-
    hermano(H, P), casados(C, H), mujer(C).

cuñada(C, P):-
    casados(P, E), hermana(C, E), mujer(C).

% Concuños y Concuñas (Los esposos/as de dos hermanos/as entre sí)
concuño(C, P):-
    casados(C, H1), casados(P, H2), hermanos(H1, H2), hombre(C), C \= P.

concuña(C, P):-
    casados(C, H1), casados(P, H2), hermanos(H1, H2), mujer(C), C \= P.