%Quien ve a quien
observa(yael,andrea).
observa(misael, rodrigo).
observa(mildred, fernando).
observa(andrea, yael).
observa(fernando, misael).
observa(emiliano, mildred).


% Generos
hombre(yael).
hombre(misael).
hombre(fernando).
hombre(emiliano).
hombre(rodrigo).
mujer(mildred).
mujer(andrea).

% Regla
feliz(X) :- 
    observa(X, Y),      
    observa(Y, X).

% ========================================
% SECTION 2: RULES (Reglas)
% ========================================
% Rules allow us to derive new facts from existing facts.
% A rule has a head (what we conclude) and a body (the conditions).

% RULE 1: Someone is happy if they observe each other (BICONDITIONAL)
% Juan is happy when: Juan observes Malenne AND Malenne observes Juan


% ========================================
% SECTION 3: QUERIES AND GOALS
% ========================================
% To run these queries, type them in the Prolog console

% GOAL 1: Who is happy?
% ?- feliz(X).

% GOAL 2: Who is a man/male?
% ?- hombre(X).

% GOAL 3: Who is a woman/female?
% ?- mujer(X).

% GOAL 4: Is the happy person a man or woman?
% ?- feliz(X), (hombre(X); mujer(X)).
% or
% ?- feliz(X), hombre(X).
% ?- feliz(X), mujer(X).

% GOAL 5: Who is NOT happy?
% ?- \+ feliz(X).

% GOAL 6: Who observes whom?
% ?- observa(X, Y).

% GOAL 7: Who observes a specific person?
% ?- observa(X, juan).

% GOAL 8: Who does Juan observe?
% ?- observa(juan, X).

% GOAL 9: Does Juan observe Malenne AND does Malenne observe Juan?
% ?- observa(juan, malenne), observa(malenne, juan).

% GOAL 10: Find mutual observations (bidirectional)
% ?- observa(X, Y), observa(Y, X), X @< Y.