%% ---------- Aves que NO vuelan ----------
% pinguino/1
pinguino("Chiliwilly").
pinguino("Cabo").
pinguino("Skipper").
pinguino("Kowalski").
pinguino("Rico").
pinguino("Pingu").

% avestruz/1
avestruz("Nora").
avestruz("Oswaldo").
avestruz("Gerardo").
avestruz("Ostrich_Jr").

% pavo/1
pavo("Tom").
pavo("Gobbles").
pavo("Turquito").

% dodo/1
dodo("Dodi").
dodo("Didi").
dodo("Raphus").

% kiwi/1
kiwi("Kiko").
kiwi("Kiwi_Verde").

%% ---------- Aves que SI vuelan ----------
% canario/1
canario("Twity").
canario("Piolin").
canario("Amarillo").
canario("Sol").

% paloma/1
paloma("Lola").
paloma("Pichon").
paloma("Blanca").
paloma("Dana_Paloma").

% flamingo/1
flamingo("Flamenco_Rosa").
flamingo("Fenix").
flamingo("Flory").

% aguila/1
aguila("Aquila").
aguila("Sam").
aguila("Aguila_Real").

% gorrion/1
gorrion("Pepe").
gorrion("Jack_Sparrow").

% colibri/1
colibri("Zumbido").
colibri("lindor").

%% =====================================================================
%% REGLAS DE INFERENCIA (HECHOS Y REGLAS)
%% =====================================================================

ave(X) :- pinguino(X).
ave(X) :- avestruz(X).
ave(X) :- pavo(X).
ave(X) :- dodo(X).
ave(X) :- kiwi(X).
ave(X) :- canario(X).
ave(X) :- paloma(X).
ave(X) :- flamingo(X).
ave(X) :- aguila(X).
ave(X) :- gorrion(X).
ave(X) :- colibri(X).

%%  no_vuela(X) :- ...
%%  Excepciones al axioma general: aves que NO vuelan

no_vuela(X) :- pinguino(X).
no_vuela(X) :- avestruz(X).
no_vuela(X) :- pavo(X).
no_vuela(X) :- dodo(X).
no_vuela(X) :- kiwi(X).

%% ---------------------------------------------------------------------
%% Aves que vuelan
%% "Para todo X, si X es ave y no pertenece a las excepciones, entonces X vuela"
%% (ave(X) va primero para ligar X antes de aplicar la negacion \+)
%% ---------------------------------------------------------------------
vuela(X) :- ave(X), \+ no_vuela(X).

%% ---------------------------------------------------------------------
%%  Relaciones auxiliares (cuantificadores)
%% ---------------------------------------------------------------------

% Cuantificador universal:  "todos los pinguinos son aves"
todos_pinguinos_son_aves :- forall(pinguino(X), ave(X)).

% Cuantificador universal:  "ningun pinguino vuela"
ningun_pinguino_vuela :- forall(pinguino(X), \+ vuela(X)).

% Cuantificador universal:  "todos los canarios vuelan"
todos_canarios_vuelan :- forall(canario(X), vuela(X)).

% Cuantificador existencial: "existe al menos un ave que vuela"
existe_ave_que_vuela :- ave(X), vuela(X), !.

% Cuantificador existencial: "existe al menos un ave que no vuela"
existe_ave_que_no_vuela :- ave(X), no_vuela(X), !.


%% =====================================================================
%%  3. GOALS (METAS / CONSULTAS)
%%     Se escriben en el prompt  ?-  de SWI-Prolog.
%%     En cada caso se indica el resultado esperado.
%%     Para ver mas respuestas se presiona  ;  (punto y coma).
%% =====================================================================

%% a) Chiliwilly vuela?
%%    ?- vuela("Chiliwilly").
%%    false.

%% b) Quien vuela?
%%    ?- vuela(X).
%%    X = "Twity" ;
%%    X = "Piolin" ;
%%    X = "Amarillo" ;
%%    X = "Sol" ;
%%    X = "Lola" ;
%%    ...   (canarios, palomas, flamingos, aguilas, gorriones, colibries)
%%    Para ver todos de una vez:
%%    ?- forall(vuela(X), (write(X), nl)).

%% c) Quien no vuela?
%%    ?- no_vuela(X).
%%    X = "Chiliwilly" ;
%%    X = "Cabo" ;
%%    X = "Skipper" ;
%%    ...   (pinguinos, avestruces, pavos, dodos, kiwis, emues)
%%    Para ver todos de una vez:
%%    ?- forall(no_vuela(X), (write(X), nl)).

%% d) Quien es ave?
%%    ?- ave(X).
%%    X = "Chiliwilly" ;
%%    X = "Cabo" ;
%%    ...   (todas las instancias de todos los conceptos)
%%    ?- forall(ave(X), (write(X), nl)).

%% e) Quien es pinguino?
%%    ?- pinguino(X).
%%    X = "Chiliwilly" ;
%%    X = "Cabo" ;
%%    X = "Skipper" ;
%%    X = "Kowalski" ;
%%    X = "Rico" ;
%%    X = "Pingu".

%% f) Etc.

%% f.1) Twity es canario?
%%    ?- canario("Twity").
%%    true.

%% f.2) Twity vuela?
%%    ?- vuela("Twity").
%%    true.

%% f.3) Nora es ave?
%%    ?- ave("Nora").
%%    true.

%% f.4) Nora vuela?
%%    ?- vuela("Nora").
%%    false.

%% f.5) Quien es avestruz?
%%    ?- avestruz(X).
%%    X = "Nora" ;
%%    X = "Oswaldo" ;
%%    X = "Gerardo" ;
%%    X = "Ostrich_Jr".

%% f.6) Quien es paloma?
%%    ?- paloma(X).
%%    X = "Lola" ;
%%    X = "Pichon" ;
%%    X = "Blanca" ;
%%    X = "Dana_Paloma".

%% f.7) Quien es pavo?  Vuela el pavo "Tom"?
%%    ?- pavo(X).
%%    X = "Tom" ;
%%    X = "Gobbles" ;
%%    X = "Turquito".
%%    ?- vuela("Tom").
%%    false.

%% f.8) Quien es flamingo?  Vuela "Fenix"?
%%    ?- flamingo(X).
%%    X = "Flamenco_Rosa" ;
%%    X = "Fenix" ;
%%    X = "Flory".
%%    ?- vuela("Fenix").
%%    true.

%% f.9) Quien es dodo?  Vuela "Dodi"?
%%    ?- dodo(X).
%%    X = "Dodi" ;
%%    X = "Didi" ;
%%    X = "Raphus".
%%    ?- vuela("Dodi").
%%    false.

%% f.10) Es "Skipper" un ave que no vuela?
%%    ?- ave("Skipper"), no_vuela("Skipper").
%%    true.

%% f.11) Que aves vuelan y son palomas?
%%    ?- paloma(X), vuela(X).
%%    X = "Lola" ;
%%    X = "Pichon" ;
%%    X = "Blanca" ;
%%    X = "Dona_Paloma".

%% f.12) Que aves son pinguinos y vuelan?  (ninguna)
%%    ?- pinguino(X), vuela(X).
%%    false.

%% f.13) Cuantificador UNIVERSAL: todos los pinguinos son aves?
%%    ?- todos_pinguinos_son_aves.
%%    true.
%%    ?- forall(pinguino(X), ave(X)).
%%    true.

%% f.14) Cuantificador UNIVERSAL: ningun pinguino vuela?
%%    ?- ningun_pinguino_vuela.
%%    true.

%% f.15) Cuantificador UNIVERSAL: todos los canarios vuelan?
%%    ?- todos_canarios_vuelan.
%%    true.

%% f.16) Cuantificador UNIVERSAL: todas las aves vuelan?  (falso)
%%    ?- forall(ave(X), vuela(X)).
%%    false.

%% f.17) Cuantificador EXISTENCIAL: existe un ave que vuela?
%%    ?- existe_ave_que_vuela.
%%    true.

%% f.18) Cuantificador EXISTENCIAL: existe un ave que no vuela?
%%    ?- existe_ave_que_no_vuela.
%%    true.

%% f.19) Cuantas aves hay en total?
%%    ?- aggregate_all(count, ave(_), N).
%%    N = 38.

%% f.20) Cuantas aves vuelan y cuantas no vuelan?
%%    ?- aggregate_all(count, vuela(_), V).
%%    V = 18.
%%    ?- aggregate_all(count, no_vuela(_), NV).
%%    NV = 20.

%% f.21) Lista de todas las aves que no vuelan
%%    ?- findall(X, no_vuela(X), L).
%%    L = ["Chiliwilly", "Cabo", "Skipper", "Kowalski", "Rico", "Pingu",
%%         "Nora", "Oswaldo", "Gerardo", "Ostrich_Jr", "Tom", "Gobbles",
%%         "Turquito", "Dodi", "Didi", "Raphus", "Kiko", "Kiwi_Verde",
%%         "Emilio", "Emma"].

%% f.22) Es "Cosa" un ave?  (no existe en la base de conocimientos)
%%    ?- ave("Cosa").
%%    false.

%% =====================================================================
%%  FIN DEL PROGRAMA ave.pl
%% =====================================================================