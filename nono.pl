cls:-write('\e[2J'), gotoXY(0,0).
gotoXY(X,Y):-write('\e['),write(X),write(";"),write(Y),write("H").

colorsValids([negre,vermell,verd,groc,blau,lila,cel]).

color(negre):-write("\e[1;90m").
color(vermell):-write("\e[1;91m").
color(verd):-write("\e[1;92m").
color(groc):-write("\e[1;93m").
color(blau):-write("\e[1;94m").
color(lila):-write("\e[1;95m").
color(cel):-write("\e[1;96m").
color(blanc):-write("\e[1;97m").


% Función para mostrar una lista de listas
showList([]).
showList([X|L]):-
    write(X),
    nl,
    showList(L).

% Función para realizar la transpuesta de una matriz
transposeMatrix([], []).
transposeMatrix([[]|L], []):- transposeMatrix(L, []).
transposeMatrix(M, [C|T]):-
    transposeColumn(M, C, M1),
    transposeMatrix(M1, T).

% Función para realizar la transpuesta de una columna
transposeColumn([], [], []).
transposeColumn([[X|L1]|M], [X|C], [L1|M1]):-
    transposeColumn(M, C, M1).

treuPistes([],[]).
treuPistes([X|L1], [Y|L2]):-
    extreuPista(X,Y),
    treuPistes(L1,L2).

extreuPista([], []):-!.
% Caso fucsia
extreuPista([fucsia|L1],L2):-
    extreuPista(L1, L2).
% Caso [seguits, color, 1]
extreuPista([X|L1], [[seguits, X, 1]|L2]):-
    vegades(X, [X|L1], N),
    N = 1,
    !,
    extreuPista(L1, L2).
% Caso [seguits, color, N]
extreuPista([X|L1], [[seguits, X, N]|L2]):-
    vegades(X, [X|L1], N),
    seguits(N, X, [X|L1]),
    replaceAll(X, [X|L1], L3), % Borrar los seguidos
    extreuPista(L3, L2),
    !.
% Caso [no_seguits, color, N]
extreuPista([X|L1], [[no_seguits, X, N]|L2]):-
    vegades(X, [X|L1], N),
    replaceAll(X, [X|L1], L3), % Borrar los seguidos
    extreuPista(L3, L2).

% Función para obtener el numero de veces que aparece un 
% elemento en una lista
vegades(_, [], 0).
vegades(X, [X|L], N):-
    vegades(X, L, N1),
    N is N1 + 1,
    !.
vegades(X, [_|L], N):-
    vegades(X, L, N),
    !.

% Función para obtener el numero de veces que aparece un
% elemento en una lista seguidos
seguits(0, _, []).
seguits(N, X, [X|L]) :-
    seguits(N1, X, L),
    N is N1 + 1,
    !.
seguits(0, _, _).

% Cambiar por sustituir
borrarTodo(_,[],[]).
borrarTodo(E,[E|L],R):-
    borrarTodo(E,L,R),
    !.
borrarTodo(E,[X|L],[X|R]):-
    borrarTodo(E,L,R),
    !.

% Función para sustituir un elemento por otro en una lista
replaceAll(_,[],[]).
replaceAll(E,[E|L],[fucsia|R]):-
    replaceAll(E,L,R),
    !.
replaceAll(E,[X|L],[X|R]):-
    replaceAll(E,L,R),
    !.

% Función para obtener un color aleatorio de una lista de colores
getRandomColor([X], X).
getRandomColor([_|L], C):-
    random(N),
    N1 is round(N) * 100,
    N1 < 50,
    getRandomColor(L, C).
getRandomColor([X|_], X).

% Función para generar una fila aleatoria dado una lista de colores
generateRandomRow(_, 0, []).
generateRandomRow(Cs, Col, L):-
    getRandomColor(Cs, C),
    append([C], L1, L),
    Col1 is Col - 1,
    generateRandomRow(Cs, Col1, L1).

% Función para resolver las filas de un nonograma
resolveRows([],[]).
resolveRows([X|L1], [C1|L2]):-
    obtainColors(X,C),
    permutate(C,C1),
    verifyHints(X,C1),
    resolveRows(L1,L2).

% Función para obtener los colores de una fila
obtainColors([],[]).
obtainColors([[_,C,N]|L], L3):-
    copyOf(N,C,X),
    obtainColors(L,L2),
    append(X,L2,L3).

% Función para copiar un elemento N veces
% Parametros:
copyOf(1,X,[X]):-!.
copyOf(N,X,[X|L]):-
    N1 is N-1,
    copyOf(N1,X,L).

% Función para permutar una lista
permutate([],[]).
permutate([X|Y],Z):-
    permutate(Y,L),
    add(X,L,Z).

% Función para añadir un elemento a una lista
add(E,L,[E|L]).
add(E,[X|Y],[X|Z]):-
    add(E,Y,Z).

% Función para verificar las pistas de una fila
verifyHints([],_).
verifyHints([[seguits,C,1]|L],L2):-
    flatten(L2,L3),
    member(C,L3),
    !,
    verifyHints(L,L2).
verifyHints([[seguits,C,N]|L],L2):-
    auxF(C,N,L2),
    !,
    verifyHints(L,L2).
verifyHints([[no_seguits,C,_]|L],L2):-
    vegades(C,L2,N2),
    not(auxF(C,N2,L2)),
    !,
    verifyHints(L,L2).

% Función para verificar todas las pistas de un nonograma
verifyAllHints([],_).
verifyAllHints([X|L], [Y|L2]):-
    verifyHints(X,Y),
    verifyAllHints(L,L2).

% Función para aplanar una lista
flatten([],[]).
flatten([X|L1],L2):-
    is_list(X),
    flatten(X,L3),
    flatten(L1,L4),
    append(L3,L4,L2).
flatten([X|L1],[X|L2]):-
    flatten(L1,L2).

% Función auxiliar para verificar las pistas de una fila
auxF(_,_,[]):-fail.
auxF(X,N,[X|L1]):-
    verifyAuxF(X,N,[X|L1]),
    !.
auxF(X,N,[_|L1]):-
    auxF(X,N,L1).

% Función auxiliar para verificar las pistas de una fila
verifyAuxF(X,1,[X|_]).
verifyAuxF(X,N,[X|L1]):-
    N1 is N-1,
    verifyAuxF(X,N1,L1).

% ------ PREDICADO 1 ------
% Función para escribir por pantalla las filas de un nonograma
escriuNonograma(Nono):-
    showList(Nono). 

% ------ PREDICADO 2 ------
% Función para pintar, graficament, en la pantalla un nonograma.
mostraNonograma([], _, _, _, _).
mostraNonograma([R|L], Y, X, IncY, IncX):- 
    displayRow(R, X, Y, IncX),
    Y1 is Y + IncY,
    mostraNonograma(L, Y1, X, IncY, IncX).

displayRow([], _, _, _).
displayRow([C|L], X, Y, IncX):-
    displayColorAt(X, Y, C, "X"),
    X1 is X + IncX,
    displayRow(L, X1, Y, IncX).

displayColorAt(X, Y, C, S):-
    gotoXY(X, Y),
    color(C),
    write(S),
    color(negre).

% ------ PREDICADO 3 ------
% Función para construir un nonograma aleatorio a partir de una lista de colores, 
% un número de filas y un número de columnas.
ferNonograma(_, 0, _, []):- !.
ferNonograma(Colors, Fil, Col, Nono):-
    generateRandomRow(Colors, Col, Row),
    append([Row], Nono1, Nono),
    Fil1 is Fil - 1,
    ferNonograma(Colors, Fil1, Col, Nono1).

% ------ PREDICADO 4 ------
% Función para extrar las pistas dado un nonograma
descriuNonograma(Nono, Desc):-
    % Hacer pista para las filas
    treuPistes(Nono, DescF),
    % Transponer el nonograma
    transposeMatrix(Nono, NonoT),
    % Hacer pista para las columnas
    treuPistes(NonoT, DescC),
    % Concatenar las pistas de las filas y las columnas
    append([DescF],[DescC], Desc),
    !.

% ------ PREDICADO 5.1 ------
% Función para pintar las pistas dada una descripción de hortizontales
mostraPistesHorizontals([], _, _, _, _).
mostraPistesHorizontals([RH|Desc], Row, Col, IncY, IncX) :-
    showHintRow(RH, Row, Col, IncX),
    R1 is Row + IncY,
    !,
    mostraPistesHorizontals(Desc, R1, Col, IncY, IncX).

showHintRow([], _, _, _).
showHintRow([H|L], Row, Col, IncX) :-
    showHint(H, Col, Row),
    C1 is Col + IncX,
    showHintRow(L, Row, C1 ,IncX).

% ------ PREDICADO 5.2 ------
% Función para pintar las pistas dada una descripción de verticales 
mostraPistesVerticals([], _, _, _, _).
mostraPistesVerticals([CH|Desc], Row, Col, IncY, IncX) :-
    showHintCol(CH, Row, Col, IncY),
    C1 is Col + IncX,
    !,
    mostraPistesVerticals(Desc, Row, C1, IncY, IncX).

showHintCol([], _, _, _).
showHintCol([H|L], Row, Col, IncY) :-
    showHint(H, Col, Row),
    R1 is Row + IncY,
    showHintCol(L,R1 ,Col ,IncY).

showHint([seguits, C, 1], Col, Row) :-
    displayColorAt(Col, Row, C, 1).
showHint([seguits, C, N], Col, Row) :-
    NC1 is Col - 1,
    displayColorAt(NC1, Row, C, "<"),
    displayColorAt(Col, Row, C, N),
    NC2 is Col + 1,
    displayColorAt(NC2, Row, C, ">").
showHint([no_seguits, C, N], Col, Row) :-
    displayColorAt(Col, Row, C, N).

% ------ PREDICADO 6 ------
% Función para resolver un nonograma dado su descripción
resolNonograma([PF,PC], Nono):-
    resolveRows(PF,Nono),
    transposeMatrix(Nono,NonoT),
    verifyAllHints(PC,NonoT),
    !.
