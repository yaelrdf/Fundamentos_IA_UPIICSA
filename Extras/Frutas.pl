fruta(ciruela_victoria).
fruta(manzana_triunfo).

forma(ciruela_victoria,redonda).
forma(manzana_triunfo,redonda).

color(ciruela_victoria,morado).
color(manzana_triunfo,verder).

manzana(X):-
    fruta(X),forma(X,redonda),color(X,verde).