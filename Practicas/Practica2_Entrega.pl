%Practica 2

% hombre
hombre(fabio).
hombre(ivan).
hombre(silvio).
hombre(jorge).
hombre(saul).

% mujer
mujer(elena).
mujer(rosalba).
mujer(anita).
mujer(julia).
mujer(bree).
mujer(rosa).

% casados(Esposo/a, Esposo/a).
% Se definen en ambas direcciones para facilitar las consultas.
casados(fabio, elena).
casados(elena, fabio).
casados(ivan, rosalba).
casados(rosalba, ivan).
casados(silvio, anita).
casados(anita, silvio).

% ancestros(Progenitor, Hijo/a).
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

%Hermanos
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

% Sobrinos y Sobrinas (Incluye sangre y politicos)
sobrino(S, T):-
    (tio_biologico(T, S);
    tia_biologica(T, S);
    tio_politico(T, S); 
    tia_politica(T, S)), hombre(S).

sobrina(S, T):- 
    (tio_biologico(T, S); 
    tia_biologica(T, S); 
    tio_politico(T, S); 
    tia_politica(T, S)), mujer(S).

sobrinos(S, T) :- 
    tio_biologico(T, S); 
    tia_biologica(T, S); 
    tio_politico(T, S); 
    tia_politica(T, S).