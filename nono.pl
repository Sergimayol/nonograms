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
% Parametros:
%   - Lista de listas
showList([]).
showList([X|L]):-
    write(X),
    nl,
    showList(L).

% Función para realizar la transpuesta de una matriz
% Parametros:
%   - Matriz a transponer
%   - Matriz transpuesta
transposeMatrix([], []).
transposeMatrix([[]|L], []):- transposeMatrix(L, []).
transposeMatrix(M, [C|T]):-
    transposeColumn(M, C, M1),
    transposeMatrix(M1, T).

% Función para realizar la transpuesta de una columna
% Parametros:
%   - Matriz a transponer
%   - Columna transpuesta
%   - Matriz transpuesta
transposeColumn([], [], []).
transposeColumn([[X|L1]|M], [X|C], [L1|M1]):-
    transposeColumn(M, C, M1).

treuPistes([],[]).
treuPistes([X|L1], [Y|L2]):-
    extreuPista(X,Y),
    treuPistes(L1,L2).

extreuPista([], []).
% Caso [seguits, color, 1]
extreuPista([X|L1], [[seguits, X, 1]|L2]):-
    vegades(X, [X|L1], N),
    N = 1,
    !,
    extreuPista(L1, L2).
% Caso fucsia
extreuPista([fucsia|L1],L2):-
    extreuPista(L1, L2).
% Caso [seguits, color, N]
extreuPista([X|L1], [[seguits, X, N]|L2]):-
    vegades(X, [X|L1], N),
    seguits(N, X, [X|L1]),
    !,
    replaceAll(X, [X|L1], L3), % Borrar los seguidos
    %borrarTodo(X, [X|L1], L3), % Borrar los seguidos
    extreuPista(L3, L2).
% Caso [no_seguits, color, N]
extreuPista([X|L1], [[no_seguits, X, N]|L2]):-
    vegades(X, [X|L1], N),
    !,
    replaceAll(X, [X|L1], L3), % Borrar los seguidos
    %borrarTodo(X, [X|L1], L3), % Borrar los seguidos
    extreuPista(L3, L2).

% Función para obtener el numero de veces que aparece un 
% elemento en una lista
% Parametros:
%   - Elemento a buscar
%   - Lista donde buscar
%   - Numero de veces que aparece
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
% Parametros:
%   - Numero de veces que aparece
%   - Elemento a buscar
%   - Lista donde buscar
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
% Parametros:
%   - Elemento a sustituir
%   - Lista donde sustituir
%   - Lista sustituida
replaceAll(_,[],[]).
replaceAll(E,[E|L],[fucsia|R]):-
    replaceAll(E,L,R),
    !.
replaceAll(E,[X|L],[X|R]):-
    replaceAll(E,L,R),
    !.

% Función para mostrar una fila.
% Parametros:
%   - Fila a mostrar
%   - Incremento de espacios entre pistas
showRow([],_).
showRow([X|L], Inc):-
    color(X),
    write("X"),
    showNspaces(Inc),
    showRow(L, Inc).

% Función para mostrar graficamente N espacios
% Parametros:
%   - Numero de espacios
showNspaces(0).
showNspaces(N):-
    write(" "),
    N1 is N - 1,
    showNspaces(N1).

% Función para mostrar un nonograma dado una descripción del nonograma
% Parametros:
%   - Descripción del nonograma
%   - Fila donde se empieza a mostrar
%   - Columna donde se empieza a mostrar
%   - Incremento de espacios entre pistas
%   - Incremento de lineas entre pistas y el nonograma
showNonogram([], _, _, _, _).
showNonogram([X|L], Fil, Col, IncF, IncC):-
    gotoXY(Fil, Col),
    showRow(X, IncF),
    Col1 is Col + IncC,
    showNonogram(L, Fil, Col1, IncF, IncC).

% Función para obtener un color aleatorio de una lista de colores
% Parametros:
%   - Lista de colores
%   - Color aleatorio
getRandomColor([X], X).
getRandomColor([_|L], C):-
    random(N),
    N1 is round(N) * 100,
    N1 < 50,
    getRandomColor(L, C).
getRandomColor([X|_], X).

% Función para generar una fila aleatoria dado una lista de colores
% Parametros:
%   - Lista de colores
%   - Numero de columnas
%   - Fila generada
generateRandomRow(_, 0, []).
generateRandomRow(Cs, Col, L):-
    getRandomColor(Cs, C),
    append([C], L1, L),
    Col1 is Col - 1,
    generateRandomRow(Cs, Col1, L1).

% Función para mostrar una horizantal o verticalmente las pistas
% dado una descripción del nonograma (horizontal o vertical).
% Parametros:
%   - Descripción del nonograma (horizontal o vertical)
%   - Fila donde se empieza a mostrar
%   - Columna donde se empieza a mostrar
%   - Incremento de espacios entre pistas
%   - Incremento de lineas entre pistas y el nonograma
showHints([], _, _, _, _).
showHints([H|L], F, C, IncF, IncC):-
    gotoXY(F, C),
    showLine(H, IncF, IncC),
    C1 is C + IncC,
    showHints(L, F, C1, IncF, IncC).

% Función para mostrar una linea de pistas graficamente 
% dada una linea de la descipción del mismo
% Parametros:
%   - Linea de la descripción del nonograma
%   - Incremento de espacios entre pistas
%   - Incremento de espacios entre pistas y el nonograma
showLine([], _, _).
showLine([[H, C, N] | L], IncF, IncC):-
    color(C),
    N > 1,
    H == seguits,
    write("<"),
    write(N),
    write(">"),
    showNspaces(IncF),
    showLine(L , IncF, IncC).
showLine([[_, C, N] | L], IncF, IncC):-
    color(C),
    write(N),
    showNspaces(IncF),
    showLine(L, IncF, IncC).

% Función para resolver las filas de un nonograma
% Parametros:
%   - Descripción del nonograma
%   - Filas del nonograma
resolveRows([],[]).
resolveRows([X|L1], [C1|L2]):-
    obtainColors(X,C),
    permutate(C,C1),
    verifyHints(X,C1),
    resolveRows(L1,L2).

% Función para obtener los colores de una fila
% Parametros:
%   - Fila del nonograma
%   - Colores de la fila
obtainColors([],[]).
obtainColors([[_,C,N]|L], L3):-
    copyOf(N,C,X),
    obtainColors(L,L2),
    append(X,L2,L3).

% Función para copiar un elemento N veces
% Parametros:
%   - Numero de veces a copiar
%   - Elemento a copiar
%   - Lista copiada
copyOf(1,X,[X]):-!.
copyOf(N,X,[X|L]):-
    N1 is N-1,
    copyOf(N1,X,L).

% Función para permutar una lista
% Parametros:
%   - Lista a permutar
%   - Lista permutada
permutate([],[]).
permutate([X|Y],Z):-
    permutate(Y,L),
    add(X,L,Z).

% Función para añadir un elemento a una lista
% Parametros:
%   - Elemento a añadir
%   - Lista a la que se añade
%   - Lista con el elemento añadido
add(E,L,[E|L]).
add(E,[X|Y],[X|Z]):-
    add(E,Y,Z).

% Función para verificar las pistas de una fila
% Parametros:
%   - Pistas de la fila
%   - Colores de la fila
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
% Parametros:
%   - Pistas del nonograma
%   - Colores del nonograma
verifyAllHints([],_).
verifyAllHints([X|L], [Y|L2]):-
    verifyHints(X,Y),
    verifyAllHints(L,L2).

% Función para aplanar una lista
% Parametros:
%   - Lista a aplanar
%   - Lista aplanada
flatten([],[]).
flatten([X|L1],L2):-
    is_list(X),
    flatten(X,L3),
    flatten(L1,L4),
    append(L3,L4,L2).
flatten([X|L1],[X|L2]):-
    flatten(L1,L2).

% Función auxiliar para verificar las pistas de una fila
% Parametros:
%   - Color a verificar
%   - Número de veces que se tiene que repetir
%   - Colores de la fila
auxF(_,_,[]):-fail.
auxF(X,N,[X|L1]):-
    verifyAuxF(X,N,[X|L1]),
    !.
auxF(X,N,[_|L1]):-
    auxF(X,N,L1).

% Función auxiliar para verificar las pistas de una fila
% Parametros:
%   - Color a verificar
%   - Número de veces que se tiene que repetir
%   - Colores de la fila
verifyAuxF(X,1,[X|_]).
verifyAuxF(X,N,[X|L1]):-
    N1 is N-1,
    verifyAuxF(X,N1,L1).

% ------ PREDICADO 1 ------
% Función para escribir por pantalla las filas de un nonograma
% Parametros:
%   - Lista de filas del nonograma (lista de listas)
escriuNonograma(Nono):-
    showList(Nono). 

% ------ PREDICADO 2 ------
% Función para pintar, graficament, en la pantalla un nonograma.
% Parametros:
%   - Lista de filas del nonograma (lista de listas)
%   - Número de filas del nonograma
%   - Número de columnas del nonograma
%   - Separación entre filas
%   - Separación entre columnas
mostraNonograma([X|L], Fil, Col, IncF, IncC):-
    cls,
    showNonogram([X|L], Fil, Col, IncF, IncC),
    color(negre),
    !.

% ------ PREDICADO 3 ------
% Función para construir un nonograma aleatorio a partir de una lista de colores, 
% un número de filas y un número de columnas.
% Parametros:
%   - Lista de colores validos
%   - Número de filas del nonograma
%   - Número de columnas del nonograma
%   - Nonograma generado
ferNonograma(_, 0, _, []).
ferNonograma(Colors, Fil, Col, Nono):-
    generateRandomRow(Colors, Col, Row),
    append([Row], Nono1, Nono),
    Fil1 is Fil - 1,
    ferNonograma(Colors, Fil1, Col, Nono1),
    !.

% ------ PREDICADO 4 ------
% Función para extrar las pistas dado un nonograma
% Parametros:
%   - Lista de filas del nonograma (lista de listas)
%   - Descripción de las pistas
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
% Parametros:
%   - Descripción de las pistas hortizontales
%   - Fila inicial para pintar las pistas
%   - Columna inicial para pintar las pistas
%   - Incremento de fila para pintar las pistas
%   - Incremento de columna para pintar las pistas
mostraPistesHoritzontals(DescHo, F, C, FInc, CInc):-
    showHints(DescHo, F, C, FInc, CInc),
    !.

% ------ PREDICADO 5.2 ------
% Función para pintar las pistas dada una descripción de verticales 
% Parametros:
%   - Descripción de las pistas verticales
%   - Fila inicial para pintar las pistas
%   - Columna inicial para pintar las pistas
%   - Incremento de fila para pintar las pistas
%   - Incremento de columna para pintar las pistas
mostraPistesVerticals(DescVer, F, C, FInc, CInc):-
    showHints(DescVer, F, C, FInc, CInc),
    !.

% ------ PREDICADO 6 ------
% Función para resolver un nonograma dado su descripción
% Parametros:
%   - Descripción del nonograma
%   - Solución del nonograma
resolNonograma([PF,PC], Nono):-
    resolveRows(PF,Nono),
    transposeMatrix(Nono,NonoT),
    verifyAllHints(PC,NonoT),
    !.
